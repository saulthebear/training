class Course < ApplicationRecord
  has_many :enrollments,
    class_name: 'Enrollment',
    foreign_key: :course_id

  belongs_to :prerequisite,
    class_name: 'Course',
    foreign_key: :prereq_id,
    primary_key: :id

  belongs_to :instructor,
    class_name: 'User', 
    foreign_key: :instructor_id
end
