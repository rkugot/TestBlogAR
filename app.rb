#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:blog.db"

class Post < ActiveRecord::Base
	has_many :comments
end

get '/' do
	erb "My Blog"		
end

get '/new' do
	erb :new
end

post '/new' do
  	
  	@p = Post.new params[:post]
  	@p.save

  	redirect to '/'

end