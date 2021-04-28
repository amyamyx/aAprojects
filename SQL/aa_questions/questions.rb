require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include singleton

  def initialilze
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :fname, :lname

  def self.all
    data = QuestionsDatabase.instance('SELECT * FROM users')
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance(<<-SQL, id)
      SELECT  
        *
      FROM  
        users
      WHERE
        id = ?
    SQL

    User.new(data)
  end

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ?, lname = ?
    SQL
    
    User.new(data)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Question
  attr_accessor :body, :title, :author_id

  def self.all
    data = QuestionsDatabase.instance('SELECT * FROM questions')
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance(<<-SQL, id)
      SELECT  
        *
      FROM  
        questions
      WHERE
        id = ?
    SQL

    Question.new(data)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
end

class Reply
  attr_accessor :body, :question_id, :parent_reply_id, :author_id

  def self.all
    data = QuestionsDatabase.instance('SELECT * FROM replies')
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance(<<-SQL, id)
      SELECT  
        *
      FROM  
        replies
      WHERE
        id = ?
    SQL

    Reply.new(data)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @author_id = options['author_id']
    @body = options['body']
  end
end

class Follow
  attr_accessor :follower_id, :question_id

  def self.all
    data = QuestionsDatabase.instance('SELECT * FROM question_follows')
    data.map { |datum| FOllow.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance(<<-SQL, id)
      SELECT  
        *
      FROM  
        question_follows
      WHERE
        id = ?
    SQL

    Follow.new(data)
  end

  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end
end

class Like
  attr_accessor :question_id, :liker_id

  def self.all
    data = QuestionsDatabase.instance('SELECT * FROM question_likes')
    data.map { |datum| Like.new(datum) }
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance(<<-SQL, id)
      SELECT  
        *
      FROM  
        question_likes
      WHERE
        id = ?
    SQL

    Like.new(data)
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @liker_id = options['liker_id']
  end
end

