# Dway

An elixir project using phoenix framework(1.6.0-rc.0) to find the best driver to delivery an order according to the company Service Level Agreement.

## Libraries used

* [Jason](https://github.com/michalmuskala/jason)
* [Haversine](https://github.com/pkinney/distance)
* [HTTPoison](https://github.com/edgurgel/httpoison)
* [Polyline decoder](https://github.com/pkinney/polyline_ex)

## osrm/osrm-backend
  High performance routing engine written in C++14 designed to run on OpenStreetMap data. This api offers some services but in this project it only uses route service, that finds the fastest route between coordinates

  see more in:

* [OSRM](http://project-osrm.org/docs/v5.5.1/api/#general-options)

* [OSRM-DOCKER](https://hub.docker.com/r/osrm/osrm-backend/)

## Getting started

To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Run `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

  ### Sign up

At the homepage, you can see the main dashboard and the sign up link where you can register your email and get your API key(token) to make requests to Dway API.

 ## REQUEST

  #### Warning

  if you prefer to run this application with osrm-docker, checkout the osrm-backend documentation and download the map at [Geofabrik](http://download.geofabrik.de/)

  using without docker, you can send `one` request per `five` seconds

  Using an api client like Insomnia or Postman make the example request below:

  ### Header

  Key: `authentication`, Value: `YOUR-API-KEY`

  [`localhost:4000/api/routes`](http://localhost:4000/routes)

  ### POST

  ```JSON
  {
    "drivers": [
        {
            "id": "integer(unique)",
            "name": "string",
            "max_distance": "integer",
            "coordinates": {
                "long": "float",
                "lat": "float"
            },
            "modal": "string",
            "index": "integer(unique)",
            "skill": "integer"
        }
    ],
    "order": {
        "id":"string (unique)",
        "customer_name": "string",
        "time_window": "float",
        "skill": "integer",
        "pickup": {
            "coordinates":{
                "long": "float",
                "lat": "float"
            }
            
        },
        "delivery": {
            "coordinates":{
                "long": "float",
                "lat": "float"
            }
        }
    }
}
```
  ### Required fields
 In case that any required field of driver is missing, invalid or nil, the application will not consider this driver.
 Case any required field of delivery is missing or nil, the application will not execute

  ### Drivers

`id`: represents the identification number(unique) of the driver

`name`: driver's name

`max_distance`: the max distance the driver will accept deliveries

`coordinates`: `long` or `longitude` and `lat` or `latitude` are the coordinates of the driver

`modal`: the vehicle type of the driver wich is `"b"` for bike or `"m"` for motocycle

`index`: the position of the driver in the list, case two drivers are in the same space, the chosen driver is the one with the lowest index.

`skill(optional)`: cases where delivery requires something specific, such as high-value products. Driver is able to perform this type of delivery if he has the required skill

  ### Order

`id`: represents the id(unique) of the order

`time_window`: maximum time to pickup and delivery in seconds

`skill(optional)`: cases where order requires something specific, such as high-value products

`pickup`: the coordinates of pickup, same as the `driver` coordinates

`delivery`: the coordinates of delivery

  ### RESPONSE

  ```JSON
  {
    "order_id": "string",
    "driver_id": "integer(unique)",
    "total_time": "float",
    "pickup_time": "float",
    "delivery_time": "float",
    "total_distance": "float",
    "polyline": "string"
  }
```

 ### Route

`order_id`: represent the id(unique) of the order

`driver_id`: represent the id(unique) of the driver

`total_time`: total time(pickup and delivery) in seconds(estimated time)

`pickup_time`: pickup time in seconds(estimated time)

`delivery_time`: delivery time in seconds(estimated time)

`total_distance`: the total distance between driver, pickup and delivery(estimated distance)

`polyline`: an string that represents the polyline

  [polyline on google maps](https://developers.google.com/maps/documentation/utilities/polylineutility)

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
