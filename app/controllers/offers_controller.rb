class OffersController < ApplicationController
  before_filter :require_permission, only: [:edit, :update, :destroy]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def show
    find_offer
    @counteroffer = Counteroffer.new
  end

  def create
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_to @offer
    else
      render :new
    end
  end

  def edit
    find_offer
  end

  def update
    find_offer
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render :edit
    end
  end

  def destroy
    offer = Offer.find(params[:id])
    offer.destroy

    redirect_to root_path
  end

  private

  def require_permission
    if current_user != Offer.find(params[:id]).user
      flash[:error] = "You do not have the right to do it."

      redirect_to dashboard_path
    end
  end

  def find_offer
    @offer ||= Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(
      :description,
      :name,
      :url,
      :user_id,
      :offer_id
      )
  end
end