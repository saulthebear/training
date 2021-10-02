require "employee"

class Startup

  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    @salaries.key?(title)
  end

  def >(other)
    funding > other.funding
  end

  def hire(employee_name, title)
    raise ArgumentError.new('Invalid title') unless valid_title?(title)

    @employees << Employee.new(employee_name, title)
  end

  def size
    @employees.length
  end

  def pay_employee(employee)
    salary = @salaries[employee.title]
    raise "Not enough funding to pay #{employee.name}!" if @funding < salary

    employee.pay(salary)
    @funding -= salary
  end

  def payday
    @employees.each { |employee| pay_employee(employee) }
  end

  def average_salary
    salaries_sum = 0
    employee_count = @employees.length
    return 0 if employee_count.zero?

    @employees.each { |employee| salaries_sum += @salaries[employee.title] }
    salaries_sum / employee_count
  end

  def close
    @employees = []
    @funding = 0
  end

  def acquire(other_startup)
    @funding += other_startup.funding

    other_startup.salaries.each do |title, salary|
      @salaries[title] = salary unless @salaries.key?(title)
    end

    @employees += other_startup.employees
    other_startup.close
  end

end
