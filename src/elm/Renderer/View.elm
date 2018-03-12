module Renderer.View exposing (view)

import Element exposing (..)
import Element.Attributes as Attrs exposing (..)
import Element.Events exposing (on)
import Html exposing (Html)
import Renderer.Styles exposing (Styles(..), styleSheet)
import Renderer.Types exposing (..)
import Rocket exposing ((=>))
import Types exposing (..)


view : Model -> Html Msg
view model =
    Element.viewport styleSheet <|
        frame model


frame : Model -> Element Styles variations Msg
frame model =
    namedGrid None
        [ width Attrs.fill
        , height Attrs.fill
        ]
        { columns = [ px 200, fill ]
        , rows = [ percent 100 => [ span 1 "menu", span 1 "main" ] ]
        , cells =
            [ named "menu" <| menu model
            , named "main" <| mainFrame model
            ]
        }


mainFrame : Model -> Element Styles variations Msg
mainFrame model =
    model.feeds
        |> List.map feedItem
        |> column None []


feedItem : Feed -> Element Styles variations Msg
feedItem feed =
    row None
        []
        [ icon feed.icon
        , text feed.name
        , text "@"
        , text <| toString feed.feedId
        ]


icon : String -> Element Styles variation Msg
icon url =
    decorativeImage None
        [ width <| px 60
        , height <| px 60
        ]
        { src = url }


menu : Model -> Element Styles variations Msg
menu model =
    column None [ paddingXY 10 30 ] [ text "Feeds", text "Feeds" ]
