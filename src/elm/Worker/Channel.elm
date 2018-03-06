port module Worker.Channel exposing (pushAllFeeds, pushMyFeed)

import Types exposing (..)


port pushMyFeed : List UserFeedEntry -> Cmd msg


port pushAllFeeds : List Feed -> Cmd msg
