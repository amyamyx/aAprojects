# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  question_id      :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
  validate :not_duplicate_response, :non_author_response

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: 'AnswerChoice'

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice,
    source: :question


  def not_duplicate_response
    no_sibling_response =  sibling_responses
      .joins(:respondent)
      .where('user_id = ?', self.user_id).empty?

    errors[:same] << 'user can\'t respond twice to one question' unless no_sibling_response
  end

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

  def non_author_response
    author_response = question.poll.user_id == self.user_id
    errors[:author] << 'can\'t respond to own poll' if author_response
  end
end
