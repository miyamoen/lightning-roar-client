module Worker.Main exposing (..)

import Rocket exposing ((=>), batchInit, batchUpdate)
import Time
import Worker.Channel as Channel
import Worker.Request as Request
import Worker.Types exposing (..)


main : Program Flags Model Msg
main =
    Platform.programWithFlags
        { init = init >> batchInit
        , update = update >> batchUpdate
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, List (Cmd Msg) )
init { rootPath } =
    let
        model =
            { rootPath = rootPath
            , entries = []
            , feeds = []
            }
    in
    model => [ Request.allFeeds model, Request.myFeed model ]


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        NoOp ->
            model => []

        UpdateMyFeed ->
            model => [ Request.myFeed model ]

        UpdateFeeds ->
            model => [ Request.allFeeds model ]

        AcceptEntriesResponse (Ok entries) ->
            { model | entries = Debug.log "entriesだよ" entries }
                => [ Channel.pushMyFeed entries ]

        AcceptEntriesResponse (Err error) ->
            let
                _ =
                    Debug.log "AcceptEntriesResponse error" error
            in
            model => []

        AcceptFeedsResponse (Ok feeds) ->
            { model | feeds = Debug.log "feedsだよ" feeds }
                => [ Channel.pushAllFeeds feeds ]

        AcceptFeedsResponse (Err error) ->
            let
                _ =
                    Debug.log "AcceptFeedsResponse error" error
            in
            model => []

        ReceiveAllFeedsRequest ->
            model => [ Request.allFeeds model, Channel.pushAllFeeds model.feeds ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ -- Time.every (30 * Time.second) <| always UpdateMyFeed
          Channel.receiveAllFeedsRequest (always ReceiveAllFeedsRequest)
        ]
