-- Triple Trouble: respect the player's Middle Scroll setting.
-- When Middle Scroll is ON, keep the player's strum line centered for
-- the entire song, including the Knuckles and later Sonic sections.
-- When it is OFF, do not alter the song's normal strum placement.

local centerX = {nil, nil, nil, nil}
local centerY = {nil, nil, nil, nil}
local saved = false

function onCountdownStarted()
    -- Psych Engine exposes the final default player strum positions here.
    -- These are the positions generated from the player's Middle Scroll setting.
    for i = 0, 3 do
        centerX[i + 1] = getPropertyFromGroup('playerStrums', i, 'x')
        centerY[i + 1] = getPropertyFromGroup('playerStrums', i, 'y')
    end
    saved = true
end

function onUpdate()
    if not middlescroll or not saved then
        return
    end

    -- Keep the player's receptors/notes on the centered Middle Scroll line.
    for i = 0, 3 do
        setPropertyFromGroup('playerStrums', i, 'x', centerX[i + 1])
        setPropertyFromGroup('playerStrums', i, 'y', centerY[i + 1])
        setPropertyFromGroup('playerStrums', i, 'visible', true)

        -- Hide the opponent receptors only while the player's setting
        -- has Middle Scroll enabled.
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
    end
end

function onDestroy()
    -- Do not change the saved Middle Scroll preference.
    -- With Middle Scroll OFF, this script never changes strum placement.
end
