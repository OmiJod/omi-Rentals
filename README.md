# qb-rentals



Configured For Qb-spawn 
where player can directly rent vehicle as soon as they first time spawn in the server <3
These Resource is forked And Menus are Changed  its For only "Car" and Not Planes / Boats
Just Plug and Play <3 

# Dependencies 
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-menu](https://github.com/qbcore-framework/qb-menu)

# Installation
- qb-spawn > configh.lua >
```lua
Apartments = {}

Apartments.Starting = true

Apartments.SpawnOffset = 30

Apartments.Locations = {
    ["apartment1"] = {
        name = "apartment1",
        label = "South Rockford Drive",
        coords = {
            enter = vector4(-667.372, -1106.034, 14.629, 65.033),
        }
    },
    ["apartment2"] = {
        name = "apartment2",
        label = "Morningwood Blvd",
        coords = {
            enter = vector4(-1288.046, -430.126, 35.077, 305.348),
        }
    },
    ["apartment3"] = {
        name = "apartment3",
        label = "Pinkage Apartments",
        coords = {
            enter = vector4(325.0117, -229.5926, 54.2172, 342.6726),
        }
    },
    -- ["apartment4"] = {
    --     name = "apartment4",
    --     label = "Tinsel Towers",
    --     coords = {
    --         enter = vector4(-621.016, 46.677, 43.591, 179.36),
    --     }
    -- },
    -- ["apartment5"] = {
    --     name = "apartment5",
    --     label = "Fantastic Plaza",
    --     coords = {
    --         enter = vector4(291.517, -1078.674, 29.405, 270.75),
    --     }
    -- },
}
```

- Find this in qb-target/init.lua
- Put this in "Config.TargetModels" (more reliable to always keep target models in config)
```lua
  -- QB Rental
  ["VehicleRental"] = {
      models = {
          `a_m_y_business_03`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-car",
              label = "Rent Vehicle",
              MenuType = "vehicle"
          },
      },
      distance = 3.0
  },
  ["AircraftRental"] = {
      models = {
          `s_m_y_airworker`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-car",
              label = "Rent Vehicle",
              MenuType = "aircraft"
          },
      },
      distance = 3.0
  },
  ["Boatrental"] = {
      models = {
          `mp_m_boatstaff_01`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-car",
              label = "Rent Vehicle",
              MenuType = "boat"
          },
      },
      distance = 3.0
  },
  ```
 
# Rental Papers Item
 
 ```lua
  ["rentalpapers"]				 = {["name"] = "rentalpapers", 					["label"] = "Rental Papers", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false, 	["combinable"] = nil, 	["description"] = "Yea, this is my car i can prove it!"},
  ```
  # Rental Papers Item Description - qb-inventory/html/js/app.js (Line 577)
  
 ```lua
   } else if (itemData.name == "stickynote") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p>' + itemData.info.label + '</p>');
        } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Name: </strong><span>'+ itemData.info.firstname + '</span></p><p><strong>Last Name: </strong><span>'+ itemData.info.lastname+ '</span></p><p><strong>Plate: </strong><span>'+ itemData.info.plate + '<p><strong>Model: </strong><span>'+ itemData.info.model +'</span></p>');
```
qb-rentals (Enhanced & Forked)
