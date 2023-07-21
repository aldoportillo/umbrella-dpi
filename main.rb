#Import Gems
require "http"
require "json"

#Get Location
pp "What's your location? "
location = gets.chomp

#Get Coordinates using Maps API

GMAPS_URI = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV.fetch("GMAPS_KEY")}"

gmaps_req = HTTP.get(GMAPS_URI)

gmaps_res = JSON.parse(gmaps_req)

lat = gmaps_res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
lng = gmaps_res.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
 
## Get weather using Pirate API
PIRATE_URI = "https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{lat},#{lng}" #Might need to swap coordinates

pirate_req = HTTP.get(PIRATE_URI) ##If I were to further this app with a UI, I would write a function for these two to modulate the app...not dry at all
pirate_res = JSON.parse(pirate_req) 



current_temp = pirate_res.fetch("currently").fetch("temperature")

pp "It is currently #{current_temp} F"
