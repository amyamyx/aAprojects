require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class ModelBase
  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM #{ self.tables[self] }")
    data.map { |datum| self.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        * 
      FROM 
        #{ self.tables[self] }
      WHERE 
        id = ?
    SQL

    self.new(data.first)
  end

  def initialize(options)
    @id = options['id']
  end

  def save
    @id ? update : create
  end

  def id
    @id
  end

  private

  def self.tables
    {
      User => 'users',
      Question => 'questions',
      Reply => 'replies',
      QuestionFollow => 'question_follows',
      QuestionLike => 'question_likes'
    }
  end

  def table
    self.class.tables[self.class]
  end

  def create
    raise "#{self} alreacy in database" if @id
    values = var_values.values
    query_str = "INSERT INTO #{ table } (#{columns}) VALUES (#{ marks(values.size) })"
    QuestionsDatabase.instance.execute(query_str, *values)
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    values = var_values.values
    query_str = "UPDATE #{ table } SET #{ set_str } WHERE id = ?"
    QuestionsDatabase.instance.execute(query_str, *values, id)
  end

  def columns
    instance_variables.reject { |sym| sym == :@id }.map do |var|
      var.to_s[1..-1]
    end.join(", ")
  end

  def var_values
    value_hash = {}

    instance_variables.each do |sym|
      next if sym == :@id
      value_hash[sym] = instance_variable_get(sym)
    end

    value_hash
  end

  def marks(n)
    (["?"] * n).join(", ")
  end
  public

  def set_str
    result = ""

    var_values.each do |sym, val|
      result += "#{sym.to_s[1..-1]} = ?, "
    end

    result[0...-2]
  end
end

class User < ModelBase
  attr_accessor :fname, :lname

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL
    
    User.new(data.first)
  end

  def initialize(options)
    @fname = options['fname']
    @lname = options['lname']
    @id = options['id']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def name
    @fname + " " + @lname
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(
          COUNT(likes.id) / COUNT(DISTINCT questions.id) AS FLOAT
          ) AS avg_karma
      FROM
        questions
      LEFT JOIN
        question_likes likes ON likes.question_id = questions.id
      WHERE
        author_id = ?
    SQL

    data.first['avg_karma']
  end
end

class Question < ModelBase
  attr_accessor :body, :title, :author_id

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
end

class Reply < ModelBase
  attr_accessor :body, :question_id, :parent_reply_id, :author_id

  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM  
        replies
      WHERE
        author_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM  
        replies
      WHERE
        question_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @author_id = options['author_id']
    @body = options['body']
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_reply_id)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    data.map { |datum| Reply.new(datum) }
  end
end

class QuestionFollow < ModelBase
  attr_accessor :follower_id, :question_id

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        follower_id
      FROM
        question_follows
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.find_by_id(datum['follower_id']) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id
      FROM
        question_follows
      WHERE
        follower_id = ?
    SQL

    data.map { |datum| Question.find_by_id(datum['question_id']) }
  end

  def self.most_followed_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_id
      FROM 
        question_follows
      GROUP BY
        question_id
      HAVING
        COUNT(follower_id)
      ORDER BY
        COUNT(follower_id) DESC
      LIMIT
        ?
    SQL

    data.map { |datum| Question.find_by_id(datum['question_id']) }
  end

  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end
end

class QuestionLike < ModelBase
  attr_accessor :question_id, :liker_id

  def self.likers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        liker_id
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    data.map { |datum| User.find_by_id(datum['liker_id']) }
  end

  def self.num_likes_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) as num_likes
      FROM
        question_likes
      WHERE
        question_id = ?
    SQL

    data.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        question_id
      FROM
        question_likes
      WHERE
        liker_id = ?
    SQL

    data.map { |datum| Question.find_by_id(datum['question_id']) }
  end
  
  def self.most_liked_questions(n)
    data = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_id
      FROM
        question_likes
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    
    data.map { |datum| Question.find_by_id(datum['question_id']) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @liker_id = options['liker_id']
  end
end

