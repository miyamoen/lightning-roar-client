module Worker.Request exposing (..)

import Api exposing (..)
import Task
import Worker.Types exposing (..)


myFeed : Setting a -> Cmd Msg
myFeed setting =
    fetchEntries setting
        |> Task.attempt AcceptEntriesResponse


allFeeds : Setting a -> Cmd Msg
allFeeds setting =
    fetchAllFeeds setting
        |> Task.attempt AcceptFeedsResponse
