class TeachersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :teacher_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :teacher_not_unique
  rescue_from ActionController::ParameterMissing, with: :params_missing
  
  def index
    teachers = teacher_service.all
    render json: teachers, status: :ok
  end

  def show
    teacher = teacher_service.show(params[:id])
    render json: teacher, status: :ok
  end

  def create
    new_teacher = Teacher.new teachers_params

    if !new_teacher.valid?
      return render json: new_teacher.errors, status: :unprocessable_entity
    end

    teacher = teacher_service.create(new_teacher)
    render json: teacher, status: :created  
  end

  def update
    errors, teacher = teacher_service.update(params[:id], edit_params)
    if(errors)
      return render json: errors, status: :unprocessable_entity
    end

    render json: teacher, status: :ok
  end

  def destroy
    teacher_service.delete(params[:id])
    render json: { message: "Maestro eliminado" }, status: :ok
  end

  private
  
  def teacher_service
    service ||= TeacherService.new
  end

  def teachers_params
    params.require(:teacher).permit(:id, :numero_empleado, :nombres, :apellidos, :horas_clase)
  end

  def edit_params
    params.require(:teacher).permit(:numero_empleado, :nombres, :apellidos, :horas_clase)
  end

  def teacher_not_unique
    render json: { mensage: 'El maestro ya existe' }, status: :unprocessable_entity
  end

  def teacher_not_found
    render json: { mensaje: "Maestro no encontrado" }, status: :not_found
  end

  def params_missing
    render json: { mensaje: "Se debe incluir los parametros" }, status: :bad_request
  end
end