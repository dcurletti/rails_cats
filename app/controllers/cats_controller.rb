class CatsController < ApplicationController
  before_action :owns_cat?, only: [:edit, :update]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def owns_cat?
    @cat = Cat.find(params[:id])
    if current_user.nil? || @cat.user_id != current_user.id
      redirect_to cat_url(@cat)
    end
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(params[:id])
    else
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit([:name, :color, :sex, :description, :birth_date, :user_id])
  end
end
