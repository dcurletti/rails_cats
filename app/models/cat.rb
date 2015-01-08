require 'date'

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: {in: ["red", "blue", "white"], message: "Not a valid color"}

  belongs_to(
    :owner,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def age
    age = (Date.today - birth_date).to_i / 365
    age == 0 ? 1 : age
  end
end
