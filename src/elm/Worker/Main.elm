module Worker.Main exposing (..)

import Time
import Rocket exposing ((=>), batchInit, batchUpdate)
import Worker.Types exposing (..)
import Debug


main : Program Never Model Msg
main =
    Platform.program
        { init = init |> batchInit
        , update = update >> batchUpdate
        , subscriptions = subscriptions
        }


init : ( Model, List (Cmd Msg) )
init =
    { content = "hello, electron + elm + worker" } => []


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        NoOp ->
            model => []

        Tick time ->
            let
                _ =
                    Debug.log "time" time
            in
                model => []


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (5 * Time.second) Tick
