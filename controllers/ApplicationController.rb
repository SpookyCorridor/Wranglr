class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require 

	set :views, File.expand_path('../../views', __FILE__)

	not_found do 
		erb :not_found 
	end 
end 