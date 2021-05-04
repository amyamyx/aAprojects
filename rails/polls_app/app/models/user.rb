# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :user_id, 
    class_name: 'Poll',
    dependent: :destroy

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'Response',
    dependent: :destroy
  
  has_many :answered_questions,
    through: :responses,
    source: :question

  def completed_polls
    Poll.find_by_sql(<<-SQL)
      SELECT
        polls.*
      FROM  
        polls
      JOIN  
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
        SELECT
          *
        FROM
          responses
        WHERE
          user_id = #{self.id}
      ) AS responses ON responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(responses.*) = COUNT(DISTINCT questions.*)
    SQL
  end

  def uncompleted_polls
    Poll.find_by_sql(<<-SQL)
      SELECT
        polls.*
      FROM  
        polls
      JOIN  
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
        SELECT
          *
        FROM
          responses
        WHERE
          user_id = #{self.id}
      ) AS responses ON responses.answer_choice_id = answer_choices.id
      GROUP BY
        polls.id
      HAVING
        COUNT(responses.*) > 0
    SQL
  end
end
