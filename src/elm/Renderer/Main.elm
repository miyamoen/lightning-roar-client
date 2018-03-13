module Renderer.Main exposing (..)

import Html exposing (Html)
import Renderer.Channel as Channel
import Renderer.Types exposing (..)
import Renderer.View exposing (view)
import Rocket exposing ((=>), batchInit, batchUpdate)


main : Program Never Model Msg
main =
    Html.program
        { init = init |> batchInit
        , view = view
        , update = update >> batchUpdate
        , subscriptions = subscriptions
        }


init : ( Model, List (Cmd Msg) )
init =
    { content = "hello, electron + elm"
    , feeds = []
    }
        => []


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        NoOp ->
            model => []

        ReceiveAllFeeds feeds ->
            { model | feeds = feeds } => []

        ReloadFeeds ->
            model => [ Channel.requestAllFeeds () ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Channel.receiveAllFeeds ReceiveAllFeeds ]
