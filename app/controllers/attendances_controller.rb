class AttendancesController < ApplicationController

  def create
    if current_user == nil
      redirect_to root_path
    end
    @event = Event.find(params[:format])

    Attendance.create(:user => current_user, :event => @event)
    flash[:success] = "Congratulations! You just joined the event."
    redirect_to event_path(params[:format])

    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd',
    })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

end
