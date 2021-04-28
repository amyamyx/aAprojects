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

class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  
        *
      FROM  
        users
      WHERE
        id = ?
    SQL

    User.new(data.first)
  end

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
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
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

  def save
    @id ? update : create
  end

  private
  
  def create
    raise "#{self} alreacy in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
      INSERT INTO
        users(fname, lname)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
      UPDATE
        users
      SET
        fname = ?,
        lname = ?
      WHERE
        id = ?
    SQL
  end
end

class Question
  attr_accessor :body, :title, :author_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  
        *
      FROM  
        questions
      WHERE
        id = ?
    SQL

    Question.new(data.first)
  end

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

  def save
    @id ? update : create
  end

  private
  
  def create
    raise "#{self} alreacy in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
      INSERT INTO
        questions(title, body, author_id)
      VALUES
        (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @id)
      UPDATE
        questions
      SET
        title = ?,
        body = ?,
      WHERE
        id = ?
    SQL
  end
end

class Reply
  attr_accessor :body, :question_id, :parent_reply_id, :author_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  
        *
      FROM  
        replies
      WHERE
        id = ?
    SQL

    Reply.new(data.first)
  end

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

  def save
    @id ? update : create
  end

  private
  
  def create
    raise "#{self} alreacy in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @author_id, @question_id, @parent_reply_id, @body)
      INSERT INTO
        replies(author_id, question_id, parent_reply_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @body, @id)
      UPDATE
        replies
      SET
        body = ?
      WHERE
        id = ?
    SQL
  end
end

class QuestionFollow
  attr_accessor :follower_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  
        *
      FROM  
        question_follows
      WHERE
        id = ?
    SQL

    QuestionFollow.new(data.first)
  end

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

  def save
    @id ? update : create
  end

  private
  
  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @follower_id)
      INSERT INTO
        question_follows(question_id, follower_id)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @follower_id, @id)
      UPDATE
        question_follows
      SET
        question_id = ?,
        follower_id = ?
      WHERE
        id = ?
    SQL
  end
end

class QuestionLike
  attr_accessor :question_id, :liker_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT  
        *
      FROM  
        question_likes
      WHERE
        id = ?
    SQL

    QuestionLike.new(data.first)
  end

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

  def save
    @id ? update : create
  end

  private
  
  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @liker_id)
      INSERT INTO
        question_likes(question_id, liker)
      VALUES
        (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @question_id, @liker_id, @id)
      UPDATE
        question_likes
      SET
        question_id = ?,
        liker_id = ?
      WHERE
        id = ?
    SQL
  end
end

