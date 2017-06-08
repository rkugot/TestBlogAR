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

class Comment < ActiveRecord::Base
	belongs_to :post
end

get '/' do
	@posts = Post.order "created_at DESC"
	erb :index		
end

get '/new' do
	@p = Post.new
	erb :new
end

get '/post/:id' do
	@comments = Comment.where(post_id: params[:id]).order "created_at DESC"
	@row = Post.find(params[:id])
	erb :details
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

post '/post/:id' do
	post_id = params[:id]
	content = params[:content]
	@row = Post.find(params[:id])
	@comments = Comment.where(post_id: params[:id]).order "created_at DESC"
	@c = Comment.new(post_id: post_id, content: content)
	@c.save
	erb :details
end





