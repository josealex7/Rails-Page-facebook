require 'json'
require 'rest-client'
class HomeController < ApplicationController
  def index
    @publications = feed_publications.order(created_at: :desc)
    @histories = feed_histories.order(created_at: :desc)
  end

  def videogames
  end

  def marketplace
    if @pokemons.nil?
      new_pokemon
    end
  end

  def new_pokemon
    response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
    get_pokemons(response)
  end

  def change_pokemon
    url = params[:url]
    response = RestClient.get(url)
    get_pokemons(response)
    render :marketplace
  end

  def load_more
    @page = params[:page].to_i
    @per_page = 10
    @publications = feed_items(:publications, @per_page, @page)
    
    respond_to do |format|
      format.js { render partial: 'publications/publication_load', locals: { publications: @publications } }
    end
  end

  private 

  def get_pokemons(response)
    @pokemons = JSON.parse(response.body) 
    pokemon_list = @pokemons['results']
    @pokemons['details'] = []
    pokemon_list.each do |pokemon|
      response = RestClient.get(pokemon['url'])
      pokemon_data = JSON.parse(response.body)
      @pokemons['details'] << pokemon_data
      rescue RestClient::ExceptionWithResponse => e
        puts "Error al realizar la petición: #{e.response.code}"
    rescue RestClient::ExceptionWithResponse => e
      puts "Error al realizar la petición: #{e.response.code}"
  end
    
  end

  def feed_items(relation_name, days_ago, page, per_page = 10)
    friends_ids = current_user.friends.pluck(:id)
    relation_name.to_s.classify.constantize
                  .where(user_id: [current_user.id] + friends_ids)
                  .where('created_at >= ?', days_ago.days.ago)
                  .limit(per_page)
                  .offset((page - 1) * per_page)
  end
  

  def feed_publications
    feed_items(:publications, 30, 1)
  end

  def feed_histories
    feed_items(:histories, 1, 1, 100)
  end
end