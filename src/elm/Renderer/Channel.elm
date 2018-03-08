port module Renderer.Channel exposing (..)

import Types exposing (..)


port receiveAllFeeds : (List Feed -> msg) -> Sub msg
