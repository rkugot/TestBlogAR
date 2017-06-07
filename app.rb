#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:blog.db"

class Post < ActiveRecord::Base
	has_many :comments
	validates :name, presence: true
	validates :content, presence: true
end

get '/' do
	erb "My Blog"		
end

get '/new' do
	@p = Post.new
	erb :new
end

post '/new' do
  	
  	@p = Post.new params[:post]
  	if @p.save
  		redirect to '/'
  	else 
  		@error = @p.errors.full_messages.first
  		erb :new
  	end

end