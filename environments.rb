require 'sinatra/assetpack'

assets do 
  serve '/js', :from => '../dist/js'
  js :application, [
    '/js/app.min.js'
    # You can also do this: 'js/*.js'
  ]

  serve '/css', :from => '../dist/css'
  css :application, [
    '/css/main.min.css'
  ]

end 

configure :development do 
	set :database, 'sqlite3:dev.db'
	set :show_exceptions, true 
end 

configure :production do 
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

	ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )

end 