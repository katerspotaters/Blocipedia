class ChargesController < ApplicationController
  before_action :authenticate_user!
  after_action :make_premium, only: :create

  def new
     @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium Account - #{current_user}",
     amount: 15_00
   }

  end

  def create
    # Creates a Stripe Customer object, for associating
     # with the charge
     customer = Stripe::Customer.create(
       email: current_user.email,
       card: params[:stripeToken]
     )

     # Where the real magic happens
     charge = Stripe::Charge.create(
       customer: customer.id, # Note -- this is NOT the user_id in your app
       amount: 15_00,
       description: "Blocipedia Premium Account - #{current_user.email}",
       currency: 'usd'
     )

     flash[:success] = "Thank you for your payment, #{current_user.email}!"
     redirect_to new_charge_path # or wherever

   # Stripe will send back CardErrors, with friendly messages
   # when something goes wrong.
   # This `rescue block` catches and displays those errors.
   rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to new_charge_path
   end

   def make_premium
     current_user.add_role :premium
     current_user.save!
   end



end
