#Import Gems
require "http"
require "json"

#Get Location
pp "What's your location? "
location = gets.chomp

#Get Coordinates

URI = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV.fetch("GMAPS_KEY")}"

req = HTTP.get(URI)

#res = JSON.parse(req)

#pp res

coordinates

pp location
