require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'json'
require 'sass'

#Declare URL for screen scrapping
WORKSHOPS_DAY_1_URL = 'http://divecfest.cucei.udg.mx/t1.php?fecha=13'
WORKSHOPS_DAY_2_URL = 'http://divecfest.cucei.udg.mx/t1.php?fecha=14'
CONFERENCES_DAY_1_URL = 'http://divecfest.cucei.udg.mx/conferencias.html'
CONFERENCES_DAY_2_URL = 'http://divecfest.cucei.udg.mx/conferencias1.html'

get '/' do
	@title = "DivecFest 2013"
  haml :index
end

get '/workshops/day1' do
	@title = "DivecFest 2013 : Talleres día 1"
  @workshops = get_workshops_day1
  haml :workshops
end

get '/workshops/day1.json' do
  get_workshops_day1.to_json
end

get '/workshops/day2' do
  @title = "DivecFest 2013 : Talleres día 2"
  @workshops = get_workshops_day2
  haml :workshops

end

get '/workshops/day2.json' do
  get_workshops_day2.to_json
end


get '/conferences/day1' do
  @title = "DivecFest 2013 : Conferencias día 1"
  @conferences = get_conferences_day1 
  haml :conferences
end

get '/conferences/day1.json' do
  get_conferences_day1.to_json
end

get '/conferences/day2' do
  @title = "DivecFest 2013 : Conferencias día 2"
  @conferences = get_conferences_day1 
  haml :conferences
end

get '/conferences/day2.json' do
  get_conferences_day2.to_json
end

get '/*' do
  haml :error
end

# GET SCHEDULE BY DAY

def get_workshops_day1
  get_workshops_schedule WORKSHOPS_DAY_1_URL
end

def get_workshops_day2
  get_workshops_schedule WORKSHOPS_DAY_2_URL
end

def get_conferences_day1
  get_conferences_schedule CONFERENCES_DAY_1_URL
end

def get_conferences_day2
  get_conferences_schedule CONFERENCES_DAY_2_URL
end

# COMMOM METHODS FOR PARSING

def get_conferences_schedule url
  {}
end

def get_workshops_schedule url
  {}
end