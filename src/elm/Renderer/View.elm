module Renderer.View exposing (view)

import Html exposing (Html)
import Renderer.Types exposing (..)


view : Model -> Html Msg
view { content, feeds } =
    Html.text <| toString feeds
