module Types exposing (..)

import Date exposing (Date)


type alias Id =
    Int


type alias Feed =
    { feedId : Id
    , name : String
    , icon : String
    }


type alias UserFeedEntry =
    { userId : Id
    , feedId : Id
    , entryId : Id
    , title : String
    , summary : String
    , link : String
    , updated : String
    }
