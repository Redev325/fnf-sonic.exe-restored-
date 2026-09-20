-- Triple Trouble: preserve the player's Middle Scroll setting.
-- If Middle Scroll is enabled in settings, keep it enabled throughout
-- the song. If it is disabled, leave it disabled.

local middleScrollSetting = false

function onCreate()
    middleScrollSetting = getPropertyFromClass('backend.ClientPrefs', 'data.middleScroll')
    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', middleScrollSetting)
end

function onUpdatePost()
    -- Keep the player's selected setting for the entire song.
    setPropertyFromClass('backend.ClientPrefs', 'data.middleScroll', middleScrollSetting)
end
