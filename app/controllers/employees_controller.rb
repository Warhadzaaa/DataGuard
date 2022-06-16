class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update destroy set_table]

  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.create(employee_params)
    redirect_to employees_path
  end

  def edit
  end

  def set_table
    if @employee.count > 5
      @employee.update(table: rand(1..((@employees.count.to_f / 5).ceil)))
    else
      @employee.update(table: 1)
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

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :unit)
  end
end
