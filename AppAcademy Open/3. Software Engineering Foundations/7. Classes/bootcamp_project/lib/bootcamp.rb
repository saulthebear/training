class Bootcamp
  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @students = []
    @teachers = []
    @grades = Hash.new { |hash, key| hash[key] = [] }
  end

  # Getters
  def name
    @name
  end
  def slogan
    @slogan
  end
  def teachers
    @teachers
  end
  def students
    @students
  end
  
  def hire(teacher)
    @teachers << teacher
  end
  
  def enroll(student)
    if @student_capacity > @students.length
      @students << student
      return true
    else
      return false
    end
  end

  def enrolled?(student)
    @students.include?(student)
  end

  def student_to_teacher_ratio
    @students.length / @teachers.length
  end

  def add_grade(student, grade)
    return false unless self.enrolled?(student)

    @grades[student] << grade
    true
  end

  def num_grades(student)
    @grades[student].length
  end

  def average_grade(student)
    return nil unless self.enrolled?(student) && self.num_grades(student).positive?

    @grades[student].sum / self.num_grades(student)
  end
end
