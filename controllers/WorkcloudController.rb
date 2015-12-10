class WordcloudController < ApplicationController

	register Sinatra::CrossOrigin

	get '/' do 
		erb :index 
	end 

	get '/stats:id'
		erb :stats 
	end 

	post '/stats' do
		cross_origin 
		puts request
	end 
end 