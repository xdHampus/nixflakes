import XMonad
import XMonad.Config.Desktop -- default desktopConfig

import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Hooks.SetWMName

myLauncher = "rofi -show run"
desuTest = "rofi -show drun"


-- Gaps around and between windows
-- Changes only seem to apply if I log out then in again
-- Dimensions are given as (Border top bottom right left)
mySpacing = spacingRaw True           -- Only for >1 window
                       -- The bottom edge seems to look narrower than it is
                       (Border 0 15 10 10) -- Size of screen edge gaps
                       True             -- Enable screen edge gaps
                       (Border 5 5 5 5) -- Size of window gaps
                       True             -- Enable window gaps
myColorMain = "313131"
myColorAccent = "525252"
 



main = xmonad defaultConfig
    { terminal    = "alacritty"
    , borderWidth = 3
    , layoutHook = avoidStruts $  mySpacing $ smartBorders (layoutHook desktopConfig)
    , startupHook = setWMName "LG3D"
    }



