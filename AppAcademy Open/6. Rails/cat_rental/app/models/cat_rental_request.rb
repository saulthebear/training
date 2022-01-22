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

  belongs_to :cat
  
  def overlapping_requests
    my_start = start_date
    my_end = end_date
    CatRentalRequest.where('(start_date >= :my_start AND start_date <= :my_end) OR (start_date < :my_start AND end_date >= :my_start)', { my_start: my_start, my_end: my_end })
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end
  
  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors.add :base, 
                 :invalid,
                 message: "This request overlaps an existing approved request"
    end
  end
end
