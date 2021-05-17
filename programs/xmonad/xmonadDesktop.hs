import XMonad
-- skipped
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = do
    xmonad $ defaultConfig {
        -- skipped
        } `additionalKeysP` myKeys

modm = mod4Mask

myKeys =
    [
    -- other additional keys
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [1,0,2] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]
