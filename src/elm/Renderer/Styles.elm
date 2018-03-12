module Renderer.Styles exposing (..)

import Color exposing (Color, rgba)
import Style exposing (..)
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Style.Transition as Transition exposing (Transition)


type Styles
    = None


styleSheet : StyleSheet Styles variations
styleSheet =
    Style.styleSheet
        [ style None []
        ]
