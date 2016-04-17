class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_premium
  #after_action :make_premium, only: :create

  def new
     @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium Account - #{current_user}",
     amount: 15_00
   }

  end

  def create
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     charge = Stripe::Charge.create(
       customer: customer.id,
       amount: 15_00,
       description: "Blocipedia Premium Account - #{current_user.email}",
       currency: 'usd'
     )

     current_user.add_role :premium
     flash[:notice] = "Thank you for your payment, #{current_user.email}!"
     redirect_to root_url

   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end

   def check_if_premium
     if current_user.has_role? :premium
       flash[:notice] = "You are already a premium member!"
       redirect_to root_url
     end
   end



end
