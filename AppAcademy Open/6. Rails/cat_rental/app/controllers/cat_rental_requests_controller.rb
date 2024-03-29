class CatRentalRequestsController < ApplicationController
  before_action :redirect_unless_authorized, only: %i[approve deny]
  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end
  
  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    @rental_request.requester = current_user
    
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end
  
  private
  
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end
  
  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params.require(:cat_rental_request)
          .permit(:cat_id, :start_date, :end_date, :status)
  end
  
  def redirect_unless_authorized
    redirect_to cats_url unless cat_belongs_to_current_user?(current_cat.id)
  end
end
