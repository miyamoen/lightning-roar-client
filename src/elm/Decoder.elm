module Decoder exposing (..)

import Json.Decode exposing (int, string, float, list, Decoder)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)
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
        |> required "updated" date


userFeedEntries : Decoder (List UserFeedEntry)
userFeedEntries =
    list userFeedEntry


date : Decoder date
date =
    Debug.crash "TODO"
