local room = require("src.logic.rooms.room")
local sprite = require("src.graphics.sprite")
local entity = require("src.logic.entity")
local followPlayer = require("src.logic.ai.movement.follow_player")

local map = {}

local draw = function (self)
  love.graphics.push('all')
  love.graphics.setColor(255, 0, 0)
  self.rooms[self.roomIndex]:draw()
  love.graphics.printf(
    "Room " .. self.roomIndex,
    350,
    20,
    100,
    "center"
  )
  love.graphics.pop()
end

local update = function (self, game)
  self.rooms[self.roomIndex]:update(game, self)
end

local _createRoom = function ()
  local slimeSprite = sprite.create("assets/sprites/slime.png")
  local entities = {}

  entities[1] = entity.create(slimeSprite, 400, 300, 0, 4, followPlayer)

  return room.create(entities)
end

local nextRoom = function (self, game)
  if self.roomIndex == #self.rooms then
    table.insert(self.rooms, _createRoom())
  end
  game.player.x = 1
  self.roomIndex = self.roomIndex + 1
end

local previousRoom = function (self, game)
  if self.roomIndex > 1 then
    self.roomIndex = self.roomIndex - 1
    game.player.x = 700
  end
end

map.create = function ()
  local inst = {}

  inst.roomIndex = 1
  inst.rooms = {}
  inst.rooms[1] = room.create({})

  inst.draw = draw
  inst.update = update
  inst.nextRoom = nextRoom
  inst.previousRoom = previousRoom

  return inst
end

return map
