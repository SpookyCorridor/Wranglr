class CreateWordclouds < ActiveRecord::Migration
  def change
  	create_table :wordclouds do |t|
  		t.string :wordlist
  		t.timestamps
  	end 
  end
end
