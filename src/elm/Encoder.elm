module Encoder exposing (..)

import Json.Encode as Json exposing (int, string, float, list, bool, null, object)
import Rocket exposing ((=>))
import Types exposing (..)


feed : Feed -> Json.Value
feed { feedId, name, icon } =
    object
        [ "id" => int feedId
        , "name" => string name
        , "iconUrl" => string icon
        ]


feeds : List Feed -> Json.Value
feeds items =
    items
        |> List.map feed
        |> list


userFeedEntry : UserFeedEntry -> Json.Value
userFeedEntry { userId, feedId, entryId, title, summary, link, updated } =
    object
        [ "userId" => int userId
        , "feedId" => int feedId
        , "entryId" => int entryId
        , "title" => string title
        , "summary" => string summary
        , "link" => string link
        , "updated" => string updated
        ]


userFeedEntries : List UserFeedEntry -> Json.Value
userFeedEntries items =
    items
        |> List.map userFeedEntry
        |> list
