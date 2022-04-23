class StudentsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :student_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :student_not_unique
  rescue_from ActionController::ParameterMissing, with: :params_missing

  def index
    students = student_service.all
    render json: students, status: :ok
  end

  def show
    student = student_service.show(params[:id])
    render json: student, status: :ok
  end

  def create
    new_student = Student.new students_params

    if !new_student.valid?
      return render json: new_student.errors, status: :unprocessable_entity
    end

    student = student_service.create(new_student)
    render json: student, status: :created
  end

  def update
    errors, student = student_service.update(params[:id], edit_params)
    if(errors)
      return render json: errors, status: :unprocessable_entity
    else
      render json: student, status: :ok
    end
  end

  def destroy
    student_service.delete(params[:id])
    render json: { message: "Alumno eliminado" }, status: :ok
  end

  private

  def student_service
    service ||= StudentService.new
  end

  def students_params
    params.require(:student).permit(:id, :nombre, :apellidos, :matricula, :promedio)
  end

  def edit_params
    params.require(:student).permit(:nombre, :apellidos, :matricula, :promedio)
  end

  def student_not_unique
    render json: { mensage: 'El alumno ya existe' }, status: :unprocessable_entity
  end

  def student_not_found
    render json: { mensaje: "Alumno no encontrado" }, status: :not_found
  end

  def params_missing
    render json: { mensaje: "Se debe incluir los parametros" }, status: :bad_request
  end
end