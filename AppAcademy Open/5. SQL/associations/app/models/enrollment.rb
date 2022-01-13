class Enrollment < ApplicationRecord
  belongs_to :user,
    foreign_key: :student_id
  

  belongs_to :course,
    foreign_key: :course_id
end
