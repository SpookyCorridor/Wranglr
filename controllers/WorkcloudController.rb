class WordcloudController < ApplicationController

	register Sinatra::CrossOrigin

	get '/' do 
		erb :index 
	end 

	get '/stats/:id' do
		@cloud = Wordcloud.find(params[:id])
		@wordlist = eval(@cloud.wordlist)

		# the below instance variables are necessary for 
		# figuring out how to rank each word and size it up 
		# in a way that's compatible for any size website/document 

		@most_frequent = @wordlist.values.sort.pop
		@least_frequent = @wordlist.values.sort.shift
		@mean = (@wordlist.values.sum / @wordlist.values.size.to_f).ceil
		erb :stats 
	end 

	post '/stats' do
		cross_origin 
		# likely there will be huge requests so it can't go through 
		# header 
		@wordlist = JSON.parse(request.body.read).to_json
		@cloud = Wordcloud.create({
			wordlist: @wordlist 
			})

		# grab the id so the proper route can be built back on the user's 
		# page that sent the ajax request 
		@cloud['id'].to_s 
	end 
end 