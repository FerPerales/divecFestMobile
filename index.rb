require 'rubygems'
require 'sinatra'
require 'mechanize'
require 'json'
require 'sass'

get '/' do
	@title = "DivecFest 2013"
  haml :index
end

get '/workshops' do
	@title = "DivecFest 2013 : Workshops"
  haml :workshops, :workshops => get_workshops_schedule
end

get '/workshops.json' do
  get_workshops_schedule.to_json
end


get '/conferences/day1' do
end

get '/conferences/day1.json' do
end

get '/conferences/day2' do
end

get '/conferences/day2.json' do
end

get '/*' do
  return "404 ERROR"
end


# Common methods

def get_workshops_schedule

  agent = Mechanize.new
  workshops_page = conference_page = agent.get('http://divecfest.cucei.udg.mx/talleres.html')

  header = workshops_page.search('.ui-widget-header>tr')
  headers_array = []

  header.search('td').each do |x|
    headers_array << x.text
  end	

  body = workshops_page.search('.ui-widget.content>tr')
  workshops_hash = {}
  hash_index = 0

  body.each do |x|
    hsh = {}
    x.search('td').each_with_index do |y, i|
      hsh[headers_array[i]] = y.text
    end
    workshops_hash[hash_index] = hsh
    hash_index += 1
  end

  workshops_hash
end