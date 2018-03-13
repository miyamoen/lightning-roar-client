port module Worker.Channel exposing (pushAllFeeds, pushMyFeed, receiveAllFeedsRequest)

import Types exposing (..)


port pushMyFeed : List UserFeedEntry -> Cmd msg


port pushAllFeeds : List Feed -> Cmd msg


port receiveAllFeedsRequest : (() -> msg) -> Sub msg
