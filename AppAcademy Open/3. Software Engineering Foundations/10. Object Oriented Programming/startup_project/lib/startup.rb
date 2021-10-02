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

  def >(startup)
    funding > startup.funding
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
end
