class Teacher 
    include ActiveModel::Model
    include ActiveModel::Serialization
  
    attr_accessor :id, :numero_empleado, :nombres, :apellidos, :horas_clase
  
    validates :id, presence: true
    validates :numero_empleado, presence: true
    validates :nombres, presence: true
    validates :apellidos, presence: true
    validates :horas_clase, presence: true

    validates :id, numericality: { only_integer: true }
    validates :nombres, format: {with: /[a-zA-Z]/, message: "is not a string"}
    validates :apellidos, format: {with: /[a-zA-Z]/, message: "is not a string"}
    validates :numero_empleado, numericality: { only_integer: true }
    validates :horas_clase, numericality: { only_integer: true }
  
    def attributes
      { id: nil, numeroEmpleado: nil, nombres: nil, apellidos: nil, horasClase: nil }
    end

    def numeroEmpleado
      self.numero_empleado
    end

    def horasClase
      self.horas_clase
    end
  end
