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
rails import:task
```

### Exploring API Endpoints
* In your terminal, start the rails server with `rails s`. 
* Open a new tab in your terminal and run `rails routes` to see available endpoint URI's. 
* In your browser, visit http://localhost:3000/
