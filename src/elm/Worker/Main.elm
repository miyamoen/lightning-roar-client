port module Worker.Main exposing (..)

import Time
import Rocket exposing ((=>), batchInit, batchUpdate)
import Worker.Types exposing (..)
import Worker.Request exposing (..)
import Json.Decode
import Debug exposing (log)


port acceptToken : (String -> msg) -> Sub msg


main : Program Flags Model Msg
main =
    Platform.programWithFlags
        { init = init >> batchInit
        , update = update >> batchUpdate
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, List (Cmd Msg) )
init { rootPath } =
    { rootPath = rootPath
    , token = ""
    , entries = []
    }
        => []


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        NoOp ->
            model => []

        AcceptToken token ->
            { model | token = Debug.log "token mya-" token } => []

        UpdateFeed ->
            log "dedede" model => [ myFeedRequest model ]

        AcceptMyFeedResponse (Ok entries) ->
            { model | entries = Debug.log "mya-" entries } => []

        AcceptMyFeedResponse (Err error) ->
            let
                _ =
                    Debug.log "error nya" error
            in
                model => []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ acceptToken AcceptToken
        , Time.every (20 * Time.second) <| always UpdateFeed
        ]
