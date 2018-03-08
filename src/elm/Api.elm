module Api exposing (Setting, fetchAllFeeds, fetchEntries)

import Decoder
import Http
import HttpBuilder exposing (..)
import Json.Decode
import Rocket exposing ((=>))
import Task exposing (Task)
import Types exposing (..)


fetchAllFeeds : Setting a -> Task Http.Error (List Feed)
fetchAllFeeds setting =
    request setting Get [ "feeds" ]
        |> withDecoder Decoder.feeds
        |> toTask


fetchEntries : Setting a -> Task Http.Error (List UserFeedEntry)
fetchEntries setting =
    request setting Get [ "feed", "all" ]
        |> withDecoder Decoder.userFeedEntries
        |> toTask


type alias Setting a =
    { a | rootPath : String }


type Method
    = Get
    | Post
    | Put
    | Delete


request : Setting a -> Method -> List String -> RequestBuilder ()
request { rootPath } method paths =
    String.join "/" (rootPath :: paths)
        |> methodBuilder method
        |> withBase


methodBuilder : Method -> String -> RequestBuilder ()
methodBuilder method url =
    case method of
        Get ->
            HttpBuilder.get url

        Post ->
            HttpBuilder.post url

        Put ->
            HttpBuilder.put url

        Delete ->
            HttpBuilder.delete url


withBase : RequestBuilder a -> RequestBuilder a
withBase builder =
    builder
        |> withCredentials
        |> withHeaders [ "Accept" => "application/json" ]


withDecoder : Json.Decode.Decoder a -> RequestBuilder igonore -> RequestBuilder a
withDecoder decoder builder =
    builder
        |> withExpect (Http.expectJson decoder)
