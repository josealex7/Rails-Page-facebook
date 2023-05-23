class Api::Stripe::PaymentsController < ApplicationController
  def create
    if current_user.customer.nil?
      redirect_to api_stripe_create_costumer_path
    end
    price = params[:precio] + '00'
    begin
      response = Stripe::PaymentIntent.create(
        amount: price.to_i,
        currency: 'usd',
        payment_method: 'pm_card_visa',
        customer: current_user.customer.stripe_customer_id,
        metadata: {
          id_user: current_user.id,
          id_pokemon: params[:url_image],
          pokemon_name: params[:name_pokemon],
          tipo: params[:tipo],
          precio: params[:precio]
        }
      )
      confirm(response['id'])
      redirect_to profile_shops_path(id: current_user.id)
    rescue Stripe::CardError => e
      puts "Status is: #{e.http_status}"
      puts "Type is: #{e.error.type}"
      puts "Charge ID is: #{e.error.charge}"
      # The following fields are optional
      puts "Code is: #{e.error.code}" if e.error.code
      puts "Decline code is: #{e.error.decline_code}" if e.error.decline_code
      puts "Param is: #{e.error.param}" if e.error.param
      puts "Message is: #{e.error.message}" if e.error.message
    rescue Stripe::RateLimitError => e
      puts 'Stripe::RateLimitError'
      puts e
    rescue Stripe::InvalidRequestError => e
      puts 'Stripe::InvalidRequestError'
      puts e
    rescue Stripe::AuthenticationError => e
      puts 'Stripe::AuthenticationError'
      puts e
    rescue Stripe::APIConnectionError => e
      puts 'Stripe::APIConnectionError'
      puts e
    rescue Stripe::StripeError => e
      puts 'Stripe::StripeError'
      puts e
    rescue => e
      puts 'ultimo'
      puts e
    end
  end

  def confirm(stripe_id)
    Stripe::PaymentIntent.confirm(
      stripe_id,
      {payment_method: 'pm_card_visa'},
    )
  end


end