module JsonConverter exposing (..)

import Json.Encode
import Json.Decode
import Json.Decode.Pipeline
import Types exposing (..)


decodePlacesData : Json.Decode.Decoder PlacesData
decodePlacesData =
    Json.Decode.Pipeline.decode PlacesData
        |> Json.Decode.Pipeline.required "data" (Json.Decode.list decodePlace1)


encodePlaces : PlacesData -> Json.Encode.Value
encodePlaces record =
    Json.Encode.object
        [ ( "data", Json.Encode.list <| List.map encodePlace <| record.data )
        ]


<<<<<<< HEAD:web/elm/src/JsonConverter.elm
decodePlace : Json.Decode.Decoder PlaceData
decodePlace =
    Json.Decode.Pipeline.decode PlaceData
        |> Json.Decode.Pipeline.required "data" decodePlace1


decodePlace1 : Json.Decode.Decoder Place
decodePlace1 =
=======
decodePlace : Json.Decode.Decoder Place
decodePlace =
>>>>>>> 27e8458ea0e91520f272895ef60fe6e738c8fff3:web/elm/src/JsonConverter.elm
    Json.Decode.Pipeline.decode Place
        |> Json.Decode.Pipeline.required "rating" (Json.Decode.float)
        |> Json.Decode.Pipeline.required "name" (Json.Decode.string)
        |> Json.Decode.Pipeline.required "id" (Json.Decode.int)
        |> Json.Decode.Pipeline.required "cuisine" (Json.Decode.string)


encodePlace1 : Place -> Json.Encode.Value
encodePlace1 record =
    Json.Encode.object
        [ ( "rating", Json.Encode.float <| record.rating )
        , ( "name", Json.Encode.string <| record.name )
          --        , ( "id", Json.Encode.int <| record.id )
        , ( "cuisine", Json.Encode.string <| record.cuisine )
        ]


encodePlace : Place -> Json.Encode.Value
encodePlace record =
    Json.Encode.object
        [ ( "place", encodePlace1 <| record )
        ]
