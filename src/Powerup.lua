--[[
    Author: Alex Vreeland
    Breakout Remake

    This class drops an upgrade for the player to 
    pick up using the paddle.
]]

Powerup = Class{}

--[[ 
    the upgrade will spawn in a random spot above 
    the paddle and fall towards it.
]]

function Powerup:init(version)
    --can spawn at any x value on the screen
    self.x = math.random(8, VIRTUAL_HEIGHT - 24)

    --spawns at a significant distance above the paddle
    self.y = VIRTUAL_HEIGHT / 3 - 8

    --it will fall slowly towards the paddle
    self.dy = 60

    --determines if the powerup should be rendered
    self.inPlay = false

    --dimensions
    self.width = 16
    self.height = 16

    --dictates what what the power up does
    self.version = version
end    

function Powerup:collides(target)
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    return true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt
end

function Powerup:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][self.version], self.x, self.y)
    end
end