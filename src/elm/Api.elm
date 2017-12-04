module Api exposing (fetchAllFeeds, fetchMyFeed, Setting)

import Http
import HttpBuilder exposing (..)
import Json.Decode
import Decoder
import Types exposing (..)
import Rocket exposing ((=>))
import Task exposing (Task)
import Debug


fetchAllFeeds : Setting a -> Task Http.Error (List Feed)
fetchAllFeeds setting =
    request setting Get [ "roar", "feeds" ]
        |> withDecoder Decoder.feeds
        |> toTask


fetchMyFeed : Setting a -> Task Http.Error (List UserFeedEntry)
fetchMyFeed setting =
    request setting Get [ "roar", "feed", "all" ]
        |> withDecoder Decoder.userFeedEntries
        |> toTask


type alias Setting a =
    { a
        | rootPath : String
        , token : String
    }


type Method
    = Get
    | Post
    | Put
    | Delete


request : Setting a -> Method -> List String -> RequestBuilder ()
request { rootPath, token } method paths =
    String.join "/" (rootPath :: paths)
        |> methodBuilder method
        |> withBase token


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


withBase : String -> RequestBuilder a -> RequestBuilder a
withBase token builder =
    builder
        |> withCredentials
        |> withHeaders
            [ "Accept" => "application/json"
            ]


withDecoder : Json.Decode.Decoder a -> RequestBuilder igonore -> RequestBuilder a
withDecoder decoder builder =
    builder
        |> withExpect (Http.expectJson decoder)
