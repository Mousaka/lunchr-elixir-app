module Types exposing (..)

import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { places : WebData (List Place)
    , addPlaceForm : AddPlaceForm
    }


type alias PlacesData =
    { data : List Place
    }


type alias Place =
    { rating : Float
    , name : String
    , id : Int
    , cuisine : String
    }


type alias AddPlaceForm =
    { name : String
    , cuisine : String
    , rating : String
    }


init : ( Model, Cmd Msg )
init =
    ( { places = NotAsked
      , addPlaceForm = emptyAddPlaceForm
      }
    , Cmd.none
    )


emptyAddPlaceForm : AddPlaceForm
emptyAddPlaceForm =
    { name = "", cuisine = "", rating = "" }


type Msg
    = GetPlaces
    | HandlePlacesResponse (WebData PlacesData)
    | HandlePostPlace (WebData Place)
    | AddPlaceFormUpdate AddPlaceFormMsg
    | AddPlace


type AddPlaceFormMsg
    = Name String
    | Cuisine String
    | Rating String
