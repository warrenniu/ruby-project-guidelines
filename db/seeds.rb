require 'rest-client'
require 'json'
require 'pry'

api_response_one = RestClient.get("https://swapi.dev/api/planets")
planets = JSON.parse(api_response_one)

planets["results"].each do |category|
    Planet.create(
        name: category["name"],
        population: category["population"],
        terrain: category["terrain"]
    )
end





       