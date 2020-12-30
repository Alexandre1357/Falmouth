--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety, shiny)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety
    self.shiny = shiny
    self.shineX = -20
    self.shineY = -20
    self.transitionAlpha = 0

    if self.shiny then
        self.shine = Timer.every(2, function()
            self.shineX = -20
            self.shineY = -20
            Timer.tween(0.25, {
                [self] = {shineX = 0, shineY = 0, transitionAlpha = 255}
            })
            :finish(function() 
                Timer.tween(0.25, {
                    [self] = {shineX = 20, shineY = 20, transitionAlpha = 0}
                })
            end)
        end)
    end
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34, 32, 52, 255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
    
    -- draw shiny effect
    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.draw(gTextures['shine'], self.x + x + self.shineX, self.y + y + self.shineY)
end