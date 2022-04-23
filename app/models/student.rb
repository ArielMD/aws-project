class Student 
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :id, :nombre, :apellidos, :matricula, :promedio

  validates :id, presence: true
  validates :nombre, presence: true
  validates :apellidos, presence: true
  validates :matricula, presence: true
  validates :promedio, presence: true

  validates :id, numericality: { only_integer: true, :greater_than_or_equal_to => 0 }
  validates :nombre, format: {with: /[a-zA-Z]/, message: "is not a string"}
  validates :apellidos, format: {with: /[a-zA-Z]/, message: "is not a string"}
  validates :matricula, numericality: { only_integer: true }
  validates :promedio, numericality: { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

  def attributes
    {id: nil, nombre: nil, apellidos: nil, matricula: nil, promedio: nil}
  end
end
