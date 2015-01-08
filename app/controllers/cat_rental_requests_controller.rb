class CatRentalRequestsController < ApplicationController
  before_action :is_owner?, only: [:approve, :deny]

  def new
    @catrentalrequest = CatRentalRequest.new()
  end

  def create
    @catrentalrequest = CatRentalRequest.new(cat_rental_params)
    @catrentalrequest.user_id = current_user.id
    if @catrentalrequest.save
      redirect_to cat_url(cat_rental_params[:cat_id])
    else
      render :new
    end
  end

  def approve
    @catrentalrequest = CatRentalRequest.find(params[:id])
    @catrentalrequest.approve!
    redirect_to cat_url(@catrentalrequest.cat_id)
  end

  def deny
    @catrentalrequest = CatRentalRequest.find(params[:id])
    @catrentalrequest.deny!
    redirect_to cat_url(@catrentalrequest.cat_id)
  end

  def is_owner?
    @catrentalrequest = CatRentalRequest.find(params[:id])
    if current_user.nil? || @catrentalrequest.owner.id != current_user.id
      flash.now[:errors] = "You don't own this cat."
      redirect_to cat_url(@catrentalrequest.cat)
    end
  end

  private
  def cat_rental_params
    params.require(:catrentalrequest).permit([:start_date, :end_date, :cat_id])
  end

end
