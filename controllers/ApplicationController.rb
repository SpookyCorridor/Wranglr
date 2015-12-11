class ApplicationController < Sinatra::Base

	
	require 'bundler'
	Bundler.require 

	set :root, File.dirname(__FILE__)
	set :views, File.expand_path('../../views', __FILE__)
	set :public_dir, File.expand_path('../../dist', __FILE__)

	not_found do 
		erb :not_found 
	end 
end 