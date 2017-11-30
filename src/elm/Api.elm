module Api exposing (..)

import Http
import HttpBuilder exposing (..)
import Json.Decode
import Decoder
import Types exposing (..)
import Rocket exposing ((=>))
import Task exposing (Task)
import Debug


fetchAllFeeds : Task Http.Error (List Feed)
fetchAllFeeds =
    request Get [ "roar", "feeds" ]
        |> withBase
        |> withDecoder Decoder.feeds
        |> toTask


fetchMyFeeds : Task Http.Error (List UserFeedEntry)
fetchMyFeeds =
    request Get [ "roar", "feed", "all" ]
        |> withBase
        |> withDecoder Decoder.userFeedEntries
        |> toTask


type Method
    = Get
    | Post
    | Put
    | Delete


request : Method -> List String -> RequestBuilder ()
request method paths =
    let
        url_ =
            url paths
    in
        case method of
            Get ->
                HttpBuilder.get url_

            Post ->
                HttpBuilder.post url_

            Put ->
                HttpBuilder.put url_

            Delete ->
                HttpBuilder.delete url_


url : List String -> String
url paths =
    String.join "/" paths
        |> String.cons '/'


withBase : RequestBuilder a -> RequestBuilder a
withBase builder =
    builder
        |> withHeaders [ "Accept" => "application/json" ]
        |> withCredentials


withDecoder : Json.Decode.Decoder a -> RequestBuilder igonore -> RequestBuilder a
withDecoder decoder builder =
    builder
        |> withExpect (Http.expectJson decoder)
