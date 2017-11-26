module Worker.Types exposing (..)

import Time exposing (Time)


type alias Model =
    { content : String }


type Msg
    = NoOp
    | Tick Time
