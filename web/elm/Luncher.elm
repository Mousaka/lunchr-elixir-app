module Luncher exposing (..)

import Html exposing (Html, program, div, button)
import Html.Events exposing (onClick)
import JsonConverter exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import RemoteData.Http


main : Program Never Model Msg
main =
    program { init = init, subscriptions = (\_ -> Sub.none), update = update, view = view }


type alias Model =
    { places : WebData PlacesData
    }


init : ( Model, Cmd Msg )
init =
    ( { places = NotAsked }
    , Cmd.none
    )


type Msg
    = GetPlaces
    | HandlePlacesResponse (WebData PlacesData)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePlacesResponse data ->
            ( { model | places = data }
            , Cmd.none
            )

        GetPlaces ->
            ( { model | places = Loading }
            , RemoteData.Http.get "/api/places/" HandlePlacesResponse decodePlacesData
            )


view : Model -> Html Msg
view model =
    div []
        [ Html.text "From elm. "
        , viewPlaces model.places
        ]


viewPlaces : WebData PlacesData -> Html Msg
viewPlaces places =
    case places of
        Loading ->
            Html.text "Fetching places..."

        Success data ->
            Html.text ("Recieved places: " ++ toString data)

        Failure error ->
            Html.text ("This went wrong: " ++ toString error)

        NotAsked ->
            button [ onClick GetPlaces ] [ Html.text "Get places data from the server" ]
