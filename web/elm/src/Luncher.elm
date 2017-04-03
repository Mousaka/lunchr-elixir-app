module Luncher exposing (..)

import Html exposing (Html, h1, program, div, button, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (placeholder, value)
import JsonConverter exposing (..)
import RemoteData exposing (RemoteData(..), WebData, map)
import RemoteData.Http
import Types exposing (..)


main : Program Never Model Msg
main =
    program { init = init, subscriptions = (\_ -> Sub.none), update = update, view = view }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        HandlePlacesResponse data ->
            ( { model | places = RemoteData.map .data data }
            , Cmd.none
            )

        HandlePostPlace data ->
            case data of
                Success _ ->
                    let
                        p =
                            Debug.log ("Success..")
                    in
                        ( { model | addPlaceForm = Types.emptyAddPlaceForm, places = Loading }, RemoteData.Http.get "/api/places/" HandlePlacesResponse decodePlacesData )

                Failure err ->
                    let
                        p =
                            Debug.log ("Fail.." ++ toString err)
                    in
                        ( model, Cmd.none )

                Loading ->
                    let
                        p =
                            Debug.log ("Loading..")
                    in
                        ( model, Cmd.none )

                NotAsked ->
                    let
                        p =
                            Debug.log ("Not Asked..")
                    in
                        ( model, Cmd.none )

        GetPlaces ->
            ( { model | places = Loading }
            , RemoteData.Http.get "/api/places/" HandlePlacesResponse decodePlacesData
            )

        AddPlaceFormUpdate addPlaceFormMsg ->
            ( { model | addPlaceForm = updateAddPlaceForm model.addPlaceForm addPlaceFormMsg }, Cmd.none )

        AddPlace ->
            ( model, postNewPlace model.addPlaceForm )


postNewPlace : AddPlaceForm -> Cmd Msg
postNewPlace place =
    let
        convertedPlace =
            placeFormToPlace place
    in
        RemoteData.Http.post "/api/places/" HandlePostPlace decodePlace (encodePlace convertedPlace)


placeFormToPlace : AddPlaceForm -> Place
placeFormToPlace placeForm =
    let
        rating =
            Result.withDefault 0.0 (String.toFloat placeForm.rating)
    in
        { rating = rating, name = placeForm.name, id = 0, cuisine = placeForm.cuisine }


updateAddPlaceForm : AddPlaceForm -> AddPlaceFormMsg -> AddPlaceForm
updateAddPlaceForm addPlaceForm msg =
    case msg of
        Name n ->
            { addPlaceForm | name = n }

        Cuisine c ->
            { addPlaceForm | cuisine = c }

        Rating r ->
            { addPlaceForm | rating = r }


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text "Lunchr" ]
        , addPlaceForm model.addPlaceForm
        , viewPlaces model.places
        ]


addPlaceForm : AddPlaceForm -> Html Msg
addPlaceForm addPlaceForm =
    div []
        [ input [ placeholder "name", value addPlaceForm.name, onInput (addMsg Name) ] []
        , input [ placeholder "cuisine", value addPlaceForm.cuisine, onInput (addMsg Cuisine) ] []
        , input [ placeholder "rating", value addPlaceForm.rating, onInput (addMsg Rating) ] []
        , button [ onClick AddPlace ] [ Html.text "Nytt plejs" ]
        ]


addMsg : (String -> AddPlaceFormMsg) -> String -> Msg
addMsg msg str =
    AddPlaceFormUpdate (msg str)


viewPlaces : WebData (List Place) -> Html Msg
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
