class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update destroy]
  before_action :all_employees, only: %i[index update_table set_table]

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.create(employee_params)
    if @employee.save
      redirect_to employees_path
    end
  end

  def edit
  end

  def update_table(employee)
    if @employees.count > 5
      employee.update(table: rand(1..((@employees.count.to_f / 5).ceil)))
    else
      employee.update(table: 1)
    end
  end

  def set_table
    @employees.each do |employee|
      update_table(employee)
    end
    redirect_to employees_path
  end

  def update
    @employee.update(employee_params)
    redirect_to employees_path
  end

  def destroy
    @employee.destroy!
    redirect_to employees_path, status: :see_other
  end

  private

  def all_employees
    @employees = Employee.all
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :unit)
  end
end
