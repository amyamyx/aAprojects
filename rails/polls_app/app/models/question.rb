# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  poll_id    :integer          not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: 'Poll'

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: 'AnswerChoice',
    dependent: :destroy

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    result = Hash.new(0)

    answer_choices.includes(:responses).each do |choice|
      num = choice.responses.count
      result[choice.text] = num if num > 0 
    end

    result
  end
end
