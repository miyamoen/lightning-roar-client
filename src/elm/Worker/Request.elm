module Worker.Request exposing (..)

import Task
import Worker.Types exposing (..)
import Api exposing (..)


myFeedRequest : Setting a -> Cmd Msg
myFeedRequest setting =
    fetchMyFeed setting
        |> Task.attempt AcceptMyFeedResponse
