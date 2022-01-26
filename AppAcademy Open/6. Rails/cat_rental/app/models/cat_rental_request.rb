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
  STATUSES = %w[PENDING APPROVED DENIED].freeze
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validate :does_not_overlap_approved_request
  validate :start_date_before_end_date

  belongs_to :cat
  
  belongs_to :requester,
             class_name: 'User',
             foreign_key: :user_id,
             primary_key: :id
  
  after_initialize :assign_pending_status

  def approve!
    self.status = 'APPROVED'
    CatRentalRequest.transaction do
      save!
      overlapping_pending_requests.update_all(status: 'DENIED')
    end
  end

  def approved?
    self.status == 'APPROVED'
  end

  def denied?
    self.status == 'DENIED'
  end
  
  def pending?
    status == 'PENDING'
  end

  def deny!
    self.status = 'DENIED'
    save!
  end

  private

  def assign_pending_status
    self.status ||= 'PENDING'
  end
  
  def overlapping_requests
    requests_ending_after_my_start = CatRentalRequest.where(
      'end_date >= :my_start_date',
      { my_start_date: self.start_date }
    )
    requests_starting_before_my_end = CatRentalRequest.where(
      ':my_end_date >= start_date',
      { my_end_date: self.end_date }
    )
    
    requests_for_same_cat = CatRentalRequest.where(cat_id: self.cat_id)
    
    requests_excluding_mine = CatRentalRequest.where.not(id: self.id)
    
    requests_for_same_cat
      .and(requests_ending_after_my_start)
      .and(requests_starting_before_my_end)
      .and(requests_excluding_mine)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end
  
  def does_not_overlap_approved_request
    return if self.denied?
    
    return unless overlapping_approved_requests.exists?
    
    errors.add :base, 
               :invalid,
               message: "Request conflicts with existing approved request"
  end
  
  def start_date_before_end_date
    return unless start_date >= end_date 
    
    errors.add :start_date, message: "must come before end date"
    errors.add :end_date, message: "must come after start date"
  end
end
