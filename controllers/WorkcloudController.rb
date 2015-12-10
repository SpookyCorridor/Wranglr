class WordcloudController < ApplicationController

	register Sinatra::CrossOrigin

	get '/' do 
		erb :index 
	end 

	get '/stats:id' do
		erb :stats 
	end 

	post '/stats' do
		cross_origin 
		rs = JSON.parse(request.body.read).to_json
		puts rs
	end 
end 