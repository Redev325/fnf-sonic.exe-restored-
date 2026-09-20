-- Triple Trouble: keep middle scroll enabled for the whole song.
-- The stage script runs before the song's notes are generated, so the
-- setting is active when the note lanes and note positions are created.

local previousMiddleScroll = nil

function onCreate()
    previousMiddleScroll = getPropertyFromClass('backend.ClientPrefs', 'data.middleScroll')
    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', true)
end

function onUpdatePost()
    -- Keep it enabled in case another song/stage callback changes it later.
    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', true)
end

function onDestroy()
    if previousMiddleScroll ~= nil then
        setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', previousMiddleScroll)
    end
end
