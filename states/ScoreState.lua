--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local bronzeTrophy = love.graphics.newImage('bronze_trophy.png')
local silverTrophy = love.graphics.newImage('silver_trophy.png')
local goldTrophy = love.graphics.newImage('gold_trophy.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(smallFont)
    if self.score >= 15 then
        love.graphics.draw(goldTrophy, VIRTUAL_WIDTH / 2 - 16, VIRTUAL_HEIGHT / 2 - 20)
        love.graphics.printf('You Earned a Gold Trophy', 0, 160, VIRTUAL_WIDTH, 'center')
    elseif self.score >= 10 then
        love.graphics.draw(silverTrophy, VIRTUAL_WIDTH / 2 - 16, VIRTUAL_HEIGHT / 2 - 20)
        love.graphics.printf('You Earned a Silver Trophy', 0, 160, VIRTUAL_WIDTH, 'center')
    elseif self.score >= 5 then
        love.graphics.draw(bronzeTrophy, VIRTUAL_WIDTH / 2 - 16, VIRTUAL_HEIGHT / 2 - 20)
        love.graphics.printf('You Earned a Bronze Trophy', 0, 160, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end