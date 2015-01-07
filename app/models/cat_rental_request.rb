
class CatRentalRequest < ActiveRecord::Base
  validates :end_date, :cat_id, :start_date, presence: true
  validates :status, inclusion: {in: ["PENDING", "APPROVED", "DENIED"], message: "not a valid status"}
  validate :overlapping_approved_requests

  def overlapping_requests
    CatRentalRequest.where(cat_id: cat_id).where("id <> ?", id)
      .where("(? <= end_date AND start_date <= ?)", start_date, end_date)
  end

  def overlapping_approved_requests
    if status == "APPROVED"
      result = overlapping_requests.where(status: "APPROVED")
      unless result.empty?
        errors[:start_date] << "Cat already loaned out"
      end
    end
  end

  def approve!
    CatRentalRequest.transaction do
      overlapping_requests.where(status: "PENDING").each do |request|
        request.deny!
      end
      update(status: "APPROVED")
    end
  end

  def deny!
    update(status: "DENIED")
  end

  def pending?
    status == "PENDING"
  end

end

# CatRentalRequest.where(cat_id: 1).where("id <> 1").where(status: "APPROVED").where("2014-10-12 BETWEEN start_date AND end_date")
