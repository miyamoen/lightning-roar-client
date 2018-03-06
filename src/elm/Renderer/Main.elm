module Renderer.Main exposing (..)

import Html exposing (Html)
import Renderer.Types exposing (..)
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
    { content = "hello, electron + elm" } => []


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        NoOp ->
            model => []


view : Model -> Html Msg
view { content } =
    Html.text content


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
