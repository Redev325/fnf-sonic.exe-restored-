-- Triple Trouble: respect the player's Middle Scroll setting.
-- When Middle Scroll is ON, keep the player's strum line centered for
-- the entire song, including the Knuckles and later Sonic sections.
-- When it is OFF, do not alter the song's normal strum placement.

local centerX = {nil, nil, nil, nil}
local centerY = {nil, nil, nil, nil}
local saved = false
local lastDadCharacter = nil
local lastBoyfriendCharacter = nil

function onCountdownStarted()
    for i = 0, 3 do
        centerX[i + 1] = getPropertyFromGroup('playerStrums', i, 'x')
        centerY[i + 1] = getPropertyFromGroup('playerStrums', i, 'y')
    end
    saved = true
end

function syncSoulTailsIcon()
    local dadCharacter = getProperty('dad.curCharacter')
    if dadCharacter ~= lastDadCharacter then
        lastDadCharacter = dadCharacter
        if dadCharacter == 'TailsSoul' then
            runHaxeCode("game.iconP2.changeIcon('mechbf');")
        else
            runHaxeCode("game.iconP2.changeIcon(game.dad.healthIcon);")
        end
    end

    local boyfriendCharacter = getProperty('boyfriend.curCharacter')
    if boyfriendCharacter ~= lastBoyfriendCharacter then
        lastBoyfriendCharacter = boyfriendCharacter
        if boyfriendCharacter == 'TailsSoul' then
            runHaxeCode("game.iconP1.changeIcon('mechbf');")
        else
            runHaxeCode("game.iconP1.changeIcon(game.boyfriend.healthIcon);")
        end
    end
end

function onUpdate()
    if middlescroll and saved then
        for i = 0, 3 do
            setPropertyFromGroup('playerStrums', i, 'x', centerX[i + 1])
            setPropertyFromGroup('playerStrums', i, 'y', centerY[i + 1])
            setPropertyFromGroup('playerStrums', i, 'visible', true)
            setPropertyFromGroup('opponentStrums', i, 'visible', false)
        end
    end

    syncSoulTailsIcon()
end
