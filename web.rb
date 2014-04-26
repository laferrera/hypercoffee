require 'sinatra'
require 'mongo'
require 'json/ext' # required for .to_json

include Mongo

configure do
  conn = MongoClient.new("localhost", 27017)
  set :mongo_connection, conn
  set :mongo_db, conn.db('test')
end

get '/' do
  erb :index
end

post '/update_coffee' do
  puts params  
  content_type :json
  new_id = settings.mongo_db['coffeeBrewed'].insert params
  status 200 
end

get '/documents/?' do
  content_type :json
  settings.mongo_db['coffeeBrewed'].find.to_a.to_json
end

get '/last/?' do
  content_type :json
  settings.mongo_db['coffeeBrewed'].find.to_a.last.to_json
end

set :public_folder, File.dirname(__FILE__) + '/static'