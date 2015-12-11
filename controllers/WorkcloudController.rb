class WordcloudController < ApplicationController

	register Sinatra::CrossOrigin

	get '/' do 
		erb :index 
	end 

	get '/stats/:id' do
		@cloud = Wordcloud.find(params[:id])
		@wordlist = @cloud.wordlist
		erb :stats 
	end 

	post '/stats' do
		cross_origin 
		@wordlist = JSON.parse(request.body.read).to_json
		@cloud = Wordcloud.create({
			wordlist: @wordlist 
			})
		@cloud['id'].to_s 
	end 
end 