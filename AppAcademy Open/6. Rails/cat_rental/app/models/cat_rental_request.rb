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
  STATUSES = %w[PENDING APPROVED DENIED]
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validate :does_not_overlap_approved_request
  validate :start_date_before_end_date

  belongs_to :cat
  
  def overlapping_requests
    requests_ending_after_my_start = CatRentalRequest.where(
      'end_date >= :my_start_date',
      { my_start_date: self.start_date }
    )
    requests_starting_before_my_end = CatRentalRequest.where(
      ':my_end_date >= start_date',
      { my_end_date: self.end_date }
    )
    
    requests_excluding_mine = CatRentalRequest.where.not(id: self.id)
    
    requests_ending_after_my_start
      .and(requests_starting_before_my_end)
      .and(requests_excluding_mine)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end
  
  def does_not_overlap_approved_request
    return if self.status != 'DENIED'
    
    return unless overlapping_approved_requests.exists?
    
    errors.add :base, 
               :invalid,
               message: "This request overlaps an existing approved request"
  end
  
  def start_date_before_end_date
    return unless start_date >= end_date 
    
    errors.add :start_date, message: "must be before end date"
  end
end
