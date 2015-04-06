require 'sinatra'
require 'shotgun'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/todo_list.db")
  class Item
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :done, Boolean, :required => true, :default => false
  property :created, DateTime
  end
DataMapper.finalize.auto_upgrade!

get '/' do
  erb :entrer
end

get '/todolist' do
  @items = Item.all(:order => :created.desc)
  erb :todolist
end

post '/todolist' do
  Item.create(:content => params[:content], :created => Time.now)
  redirect '/todolist'
end
