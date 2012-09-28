require 'sinatra'
require 'haml'
require 'erb'


before do
	content_type :html
	@defeat = {rock: :scissors, paper: :rock, scissors: :paper}
	@throws = @defeat.keys
end

get '/' do
	haml :index
end

post '/' do
	redirect "/throw/#{params[:player_move]}"
end

get '/throw/:type' do
	player_throw = params[:type].to_sym
	if !@throws.include?(player_throw)
		hatl 403, "You must throw one of the following: #{@throws}"
	end
	computer_throw = @throws.sample
	if player_throw == computer_throw
		@result = "You tied with the computer."
		haml :result
	elsif computer_throw == @defeat[player_throw]
		@result = "Nicely done; #{player_throw} beats #{computer_throw}!"
		haml :result
	else
		@result = "Ouch; #{computer_throw} beats #{player_throw}."
		haml :result
	end

end
