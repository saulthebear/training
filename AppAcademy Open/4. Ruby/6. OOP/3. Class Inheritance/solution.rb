class Employee

  attr_reader :name, :title, :salary
  attr_accessor :boss

  def initialize(name, title, salary, boss = nil)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee

  def self.subordinates_salaries(employee)
    return 0 unless employee.is_a?(Manager) && !employee.employees.empty?

    employee.employees.reduce(0) do |salary_sum, sub_employee|
      salary_sum + sub_employee.salary + Manager.subordinates_salaries(sub_employee)
    end
  end

  attr_reader :employees

  def initialize(name, title, salary, boss = nil, employees = nil)
    super(name, title, salary, boss)
    @employees = []
    add_employees(employees) if employees
  end

  def bonus(multiplier)
    salary_of_all_subordinates = Manager.subordinates_salaries(self)
    salary_of_all_subordinates * multiplier
  end

  def add_employees(*employees)
    employees.each do |employee|
      @employees << employee unless @employees.include?(employee)
      employee.boss = self
    end
  end
end
