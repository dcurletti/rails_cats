require 'date'

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: {in: ["red", "blue", "white"], message: "Not a valid color"}

  def age
    age = (Date.today - birth_date).to_i / 365
    age == 0 ? 1 : age
  end
end
