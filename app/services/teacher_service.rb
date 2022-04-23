class TeacherService
  def all
    teachers.map{|teacher| teacher.serializable_hash }
  end

  def show(id)
    teacher = find(id) 
    if teacher.nil?
      raise ActiveRecord::RecordNotFound 
    end
    
    teacher.serializable_hash
  end

  def create(teacher)
    exists = find(teacher.id)
    
    if !exists.nil?
      raise ActiveRecord::RecordNotUnique 
    end

    teachers << teacher
    teacher.serializable_hash
  end

  def update(id, params)
    teacher = find(id)
    if teacher.nil?
      raise ActiveRecord::RecordNotFound
    end

    params[:id] = id
    new_teacher = Teacher.new params

    if !new_teacher.valid?
      return [new_teacher.errors, nil]
    end

    teacher.numero_empleado = params[:numero_empleado]
    teacher.nombres = params[:nombres]
    teacher.apellidos = params[:apellidos]
    teacher.horas_clase = params[:horas_clase]

    [nil, teacher.serializable_hash]
  end

  def delete(id)
    teacher_founded = find(id)
    
    if teacher_founded.nil?
      raise ActiveRecord::RecordNotFound
    end
    
    teachers.delete_if {|teacher| teacher.id == teacher_founded.id }
  end

  private

  def find(id)
      teacher = teachers.find { |teacher| teacher.id == id.to_i }
  end

  def teachers
    @@teachers ||= []
  end
end