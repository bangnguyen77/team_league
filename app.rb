require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("sinatra/activerecord")
require("./lib/team")
require("./lib/player")
require("pg")

# Go to homepage
get("/") do
  @teams = Team.all()
  erb(:index)
end

# Click on Go to Teams page, go to Page listing all the team
get("/teams") do
  @teams = Team.all()
  erb(:teams)
end

# Add a new team to list, the list is still in the same page
post("/teams") do
  name = params.fetch("name")
  @team = Team.create({:name => name})
  @teams = Team.all()
  erb(:teams)
end

# Go to an individual team page where you can update, delete and add new player
get("/teams/:id") do
  @team = Team.find(params.fetch("id").to_i())
  erb(:team)
end

# Update the individual team
patch("/teams/:id") do
  name = params.fetch("name")
  @team = Team.find(params.fetch("id").to_i())
  @team.update({:name => name})
  @teams = Team.all()
  erb(:team)
end

# Delete the individual team
delete("/teams/:id") do
  @team = Team.find(params.fetch("id").to_i())
  @team.delete()
  @teams = Team.all()
  erb(:teams)
end

# Add a player name to the individual team
post("/teams/:id/add") do
  @team = Team.find(params.fetch("id").to_i())
  name = params.fetch("name")
  team_id = params.fetch("team_id").to_i()
  @player = Player.create({:name => name, :team_id => team_id})
  @players = Player.all()
  erb(:team)
end

# ------- separate between TEAM and PLAYER ---------------

# Click on Go to Players page, go to Page listing all the player
get("/players") do
  @players = Player.all()
  erb(:players)
end

# Add a new player to list, but the list is still in the same page
post("/players") do
  name = params.fetch("name")
  @player = Player.create({:name => name})
  @players = Player.all()
  erb(:players)
end

# Go to an individual player page where you can update, delete new player
get("/players/:id") do
  @player = Player.find(params.fetch("id").to_i())
  erb(:player)
end

# Update the individual player
patch("/players/:id") do
  name = params.fetch("name")
  @player = Player.find(params.fetch("id").to_i())
  @player.update({:name => name})
  @players = Player.all()
  erb(:player)
end

# Delete the individual player
delete("/players/:id") do
  @player = Player.find(params.fetch("id").to_i())
  @player.delete()
  @players = Player.all()
  erb(:players)
end

# Add a team name where the individual player has played for
post("/players/:id/add") do
  @player = Player.find(params.fetch("id").to_i())
  name = params.fetch("name")
  player_id = params.fetch("player_id").to_i()
  @team = Team.create({:name => name, :player_id => player_id})
  @teams = Team.all()
  erb(:player)
end
