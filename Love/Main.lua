local sprite = require("src.graphics.sprite")
local entity = require("src.logic.entity")

local gamestate = require("src.logic.gamestate")

local keyboardMovement = require("src.logic.ai.movement.keyboard_movement")
local bounce = require("src.logic.ai.movement.bounce")
local followPlayer = require("src.logic.ai.movement.follow_Player")

local game
local testRoom

love.load = function ()
  --love.window.setFullscreen(true, "desktop") ---=Need key to set it to fullscreen wait

  math.randomseed(os.time())
  math.random(); math.random(); math.random();

  local adventurerSprite = sprite.create("assets/sprites/santaSlime.png")
  local player = entity.create(adventurerSprite, 50, 50, 0, 5, keyboardMovement)

  game = gamestate.create(player)
  local slimeSprite = sprite.create("assets/sprites/slime.png")
  local chickenThing = sprite.create("assets/sprites/ChickenThing.png")

  local slime = entity.create(slimeSprite, 50, 300, 0, 3, bounce)
  local slime2 = entity.create(slimeSprite, 250, 300, 0, 3, bounce)
  local chicken = entity.create(chickenThing, 400, 50, 0, 3, bounce)

  for i=1, 4 do
    local randomX = math.random(love.graphics.getWidth())
    local randomY = math.random(love.graphics.getHeight())
    local slime = entity.create(slimeSprite, randomX, randomY, 0, 4, followPlayer)
    game:addEntity(slime)
  end


  game:addEntity(entity.create(chickenThing, 500, 300, 0, 4, followPlayer))

end

love.update = function ()
  game:update()
end

love.draw = function ()
  game:draw()


end
