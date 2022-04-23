class StudentService
  def all
    students.map{|student| student.serializable_hash }
  end

  def show(id)
    student = find(id) 
    if student.nil?
      raise ActiveRecord::RecordNotFound 
    end
    
    student.serializable_hash
  end

  def create(student)
    exists = find(student.id)
    
    if !exists.nil?
      raise ActiveRecord::RecordNotUnique 
    end

    students << student
    student.serializable_hash
  end

  def update(id, params)
    student = find(id)
    if student.nil?
      raise ActiveRecord::RecordNotFound
    end

    params[:id] = id
    new_student = Student.new params

    if !new_student.valid?
      return [new_student.errors, nil]
    end

    student.nombre = params[:nombre]
    student.apellidos = params[:apellidos]
    student.matricula = params[:matricula]
    student.promedio = params[:promedio]

    [nil, student.serializable_hash]
  end

  def delete(id)
    student_founded = find(id)
    
    if student_founded.nil?
      raise ActiveRecord::RecordNotFound
    end
    
    students.delete_if {|student| student.id == student_founded.id }
  end

  private

  def find(id)
    student = students.find { |student| student.id == id.to_i }
  end

  def students
    @@students ||= []
  end
end