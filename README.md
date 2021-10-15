# Dway

An elixir project using phoenix framework(1.6.0-rc.0) to find the best driver to delivery an order, according to the company Service Level Agreement.

## Libraries used

* [Jason](https://github.com/michalmuskala/jason)
* [Haversine](https://github.com/pkinney/distance)
* [HTTPoison](https://github.com/edgurgel/httpoison)


## Getting started

To start your Phoenix server:
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Run `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

  ## Sign up

At the homepage, you will able to register your email and get your API key(token) to make requests to Dway API.

 ## Requests

Using Insomnia or Postman make the example request below:

  [`localhost:4000/api/YOUR-API-KEY/routes`](http://localhost:4000/YOUR-API-KEY/routes)

  #### POST

  ```JSON
  {
    "drivers": [
        {
            "id": "string (unique)",
            "name": "string",
            "max_distance": "integer",
            "coordinates": {
                "long": "float",
                "lat": "float"
            },
            "modal": "string",
            "index": "integer (unique)",
            "skills": [
                {
                    "skill": "string"
                }
            ]
        }
    ],
    "order": {
        "id":"string (unique)",
        "customer_name": "string",
        "time_window": "float",
        "skill": "string",
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

  ### Drivers Fields

`id`: represent the id(unique) of the driver

`name`: driver name

`max_distance`: the max distance the driver will accept deliveries

`coordinates`: `long` or `longitude` and `lat` or `latitude` are the coordinates of the driver

`modal`: the vehicle type of the driver wich is `"b"` to bike or `"m"` to motocycle

`index`: the position of the driver in the list, case two drivers are in the same position, the chosen driver is the one with the lowest index.

  ### Order Fields

`id`: represent the id(unique) of the order

`time_window`: max time to pickup and delivery in seconds

`pickup`: the coordinates of pickup, same as the `driver` coordinates

`delivery`: the coordinates of delivery

  #### RESPONSE

  ```JSON
  {
    "order_id": "string",
    "driver_id": "string (unique)",
    "total_time": "float",
    "pickup_time": "float",
    "delivery_time": "float",
    "total_distance": "float",
    "polyline": "string"
  }
```

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
