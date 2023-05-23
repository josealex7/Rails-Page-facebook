class Api::Stripe::CustomersController < ApplicationController
  def create
    begin
      name = current_user.user_type != 'page' ? current_user.full_name : current_user.first_name
      response = Stripe::Customer.create({
        description: 'Usuario de SmileyFace' + current_user.user_type != 'page' ? current_user.full_name : current_user.first_name,
        email: current_user.email,
        name: name,
        metadata: {
          id: current_user.id
        }
      })          
      @customer = current_user.build_customer(stripe_customer_id: response['id'], name: name, email: current_user.email)
    
      if @customer.save
        redirect_to marketplace_path
      else
        # Manejo de errores de validación u otras acciones
      end
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
      # Too many requests made to the API too quickly
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e
      # Something else happened, completely unrelated to Stripe
    end
  end
end