class CatRentalRequest < ActiveRecord::Base
  validates :end_date, :cat_id, :start_date, presence: true
  validates :status, inclusion: {in: ["PENDING", "APPROVED", "DENIED"], message: "not a valid status"}
  validate :overlapping_approved_requests


  def overlapping_requests
    CatRentalRequest.find_by(cat_id: cat_id).any? do |catrequest|
      next if catrequest.id == id
      start_date.between?(catrequest.start_date, catrequest.end_date)
    end
  end

  def overlapping_approved_requests
    if overlapping_requests == false
      CatRentalRequest.find_by(cat_id: cat_id).none? do |catrequest|
        next if catrequest.id == id
        next unless
        start_date.between?(catrequest.start_date, catrequest.end_date)
      end
    else
      false
    end
  end

end
