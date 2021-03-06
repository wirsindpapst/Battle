require 'sinatra/base'

class Battle < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/play' do
    @player_1_name = params[:player_1_name]
    @player_2_name = params[:player_2_name]
    erb(:play)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
