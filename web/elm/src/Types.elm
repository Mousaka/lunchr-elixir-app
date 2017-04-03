module Types exposing (..)

import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { places : WebData (List Place)
    , addPlaceForm : AddPlaceForm
    }


type alias PlacesData =
    { data : List Place
    }


<<<<<<< HEAD
type alias PlaceData =
    { data : Place
    }


=======
>>>>>>> 27e8458ea0e91520f272895ef60fe6e738c8fff3
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
<<<<<<< HEAD
    | HandlePostPlace (WebData PlaceData)
=======
    | HandlePostPlace (WebData Place)
>>>>>>> 27e8458ea0e91520f272895ef60fe6e738c8fff3
    | AddPlaceFormUpdate AddPlaceFormMsg
    | AddPlace


type AddPlaceFormMsg
    = Name String
    | Cuisine String
    | Rating String
