module JsonConverter exposing (..)

import Json.Encode
import Json.Decode
import Json.Decode.Pipeline


type alias PlacesData =
    { data : List Place
    }


decodePlacesData : Json.Decode.Decoder PlacesData
decodePlacesData =
    Json.Decode.Pipeline.decode PlacesData
        |> Json.Decode.Pipeline.required "data" (Json.Decode.list decodePlace)


encodePlaces : PlacesData -> Json.Encode.Value
encodePlaces record =
    Json.Encode.object
        [ ( "data", Json.Encode.list <| List.map encodePlace <| record.data )
        ]


type alias Place =
    { rating : Float
    , name : String
    , id : Int
    , cuisine : String
    }


decodePlace : Json.Decode.Decoder Place
decodePlace =
    Json.Decode.Pipeline.decode Place
        |> Json.Decode.Pipeline.required "rating" (Json.Decode.float)
        |> Json.Decode.Pipeline.required "name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "id" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "cuisine" (Json.Decode.string)


encodePlace : Place -> Json.Encode.Value
encodePlace record =
    Json.Encode.object
        [ ( "rating", Json.Encode.float <| record.rating )
        , ( "name", Json.Encode.string <| record.name )
        , ( "id", Json.Encode.int <| record.id )
        , ( "cuisine", Json.Encode.string <| record.cuisine )
        ]
