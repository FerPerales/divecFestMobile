require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'
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
	@title = "DivecFest 2013 : Talleres dia 1"
  @workshops = get_workshops_day1
  haml :workshops
end

get '/workshops/day1.json' do
  get_workshops_day1.to_json
end

get '/workshops/day2' do
  @title = "DivecFest 2013 : Talleres dia 2"
  @workshops = get_workshops_day2
  haml :workshops

end

get '/workshops/day2.json' do
  get_workshops_day2.to_json
end


get '/conferences/day1' do
  @title = "DivecFest 2013 : Conferencias dia 1"
  @conferences = get_conferences_day1 
  haml :conferences
end

get '/conferences/day1.json' do
  get_conferences_day1.to_json
end

get '/conferences/day2' do
  @title = "DivecFest 2013 : Conferencias dia 2"
  @conferences = get_conferences_day2
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
  doc = Nokogiri::HTML(open(url))
  table_headers = doc.css('.ui-widget-header');

  headers_array = []
  table_headers.css('td').each do |header|
    headers_array << header.text
  end

  conferences_hash = {}
  counter = 1
  body = doc.css('tbody')
  body.css('tr').each do |conference|
    hsh = {}  
    conference.css('td').each_with_index do |cell, i|
      hsh[headers_array[i]] = cell.text
    end
    conferences_hash[counter] = hsh
    counter+= 1
  end

  conferences_hash

end

def get_workshops_schedule url

  doc = Nokogiri::HTML(open(url))
  table_headers = doc.css('.ui-widget-header');

  headers_array = []
  table_headers.css('td').each do |header|
    headers_array << header.text
  end

  workshops_hash = {}
  counter = 1
  body = doc.css('tbody')
  body.css('tr').each do |conference|
    hsh = {}  
    conference.css('td').each_with_index do |cell, i|
      hsh[headers_array[i]] = cell.text
    end
    workshops_hash[counter] = hsh
    counter+= 1
  end

  workshops_hash  
end