module Decoder exposing (..)

import Json.Decode exposing (Decoder, float, int, list, string)
import Json.Decode.Pipeline exposing (decode, hardcoded, optional, required)
import Types exposing (..)


feed : Decoder Feed
feed =
    decode Feed
        |> required "id" int
        |> required "name" string
        |> required "iconUrl" string


feeds : Decoder (List Feed)
feeds =
    list feed


userFeedEntry : Decoder UserFeedEntry
userFeedEntry =
    decode UserFeedEntry
        |> required "userId" int
        |> required "feedId" int
        |> required "entryId" int
        |> required "title" string
        |> required "summary" string
        |> required "link" string
        |> required "updated" string


userFeedEntries : Decoder (List UserFeedEntry)
userFeedEntries =
    list userFeedEntry



-- date : Decoder date
-- date =
--     Debug.crash "TODO"
