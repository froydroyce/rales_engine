# Rales Engine

## About
Rales Engine is Turing Back End Engineering project designed to teach the fundamentals of building an API in Rails. 

## Installation Requirements 
* Ruby 2.4.1
* Rails 5.2.3

### Local Installation 
```
$ git clone https://github.com/froydroyce/rales_engine.git
$ cd rales_engine
$ bundle install
```

### Database Setup
```
rails db:{drop,create,migrate,seed}
rails import:sales_csv
```

### Exploring API Endpoints
* In your terminal, start the rails server with `rails s`. 
* Open a new tab in your terminal and run `rails routes` to see available endpoint URI's. 
* In your browser, visit `http://localhost:3000/` + your desired endpoint URI to retrieve exposed data.

### Testing
* Run `rspec` in your terminal to test models and controllers.
* A spec harness is available to test all functionality of the API [here](https://github.com/turingschool/rales_engine_spec_harness)


