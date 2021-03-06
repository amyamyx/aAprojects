# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord
  validates :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
    message: "should only be 'PENDING', 'APPROVED' or 'DENIED'" }
  validate :does_not_start_after_end_date
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id, 
    class_name: "Cat"
  
  belongs_to :requester, 
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"


  def overlapping_requests
    query_str = '(start_date > ? AND start_date <= ?) OR (end_date >= ? AND end_date <= ?)'
    my_id = self.id || 0

    CatRentalRequest
      .where(cat_id: self.cat_id)
      .where(
        query_str, 
        self.start_date, 
        self.end_date, 
        self.start_date, 
        self.end_date
      )
      .where("id != ?", my_id)
  end

  def overlapping_approved_requests
    overlapping_requests
      .where(status: "APPROVED")
  end

  def overlapping_pending_requests
    overlapping_requests
      .where(status: "PENDING")
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:overlapping] << "with other approved requests" 
    end
  end

  def does_not_start_after_end_date
    if self.start_date > self.end_date
      errors[:base] << "Can't start after the end date"
    end
  end

  def approve!
    self.transaction do
      update!(status: "APPROVED")
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

  def deny! 
    update!(status: "DENIED")
  end
end
