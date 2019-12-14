module My.App.Company exposing
    ( Company
    , companyEncoder
    , companyDecoder
    , encodeCompany
    , decodeCompany
    , companyListEncoder
    , companyListDecoder
    , encodeCompanyList
    , decodeCompanyList
    )

import Json.Decode
import Json.Decode.Pipeline
import Json.Encode


-- elm install elm/json
-- elm install NoRedInk/elm-json-decode-pipeline

type alias Company = 
    { name : String
    }


companyEncoder : Company -> Json.Encode.Value
companyEncoder company = 
    Json.Encode.object
        [ ( "name", Json.Encode.string company.name )
        ]


companyDecoder : Json.Decode.Decoder Company
companyDecoder = 
    Json.Decode.succeed Company
        |> Json.Decode.Pipeline.required "name" Json.Decode.string


encodeCompany : Company -> Int -> String
encodeCompany company indent = 
    companyEncoder company |> Json.Encode.encode indent


decodeCompany : String -> Result Json.Decode.Error Company
decodeCompany = 
    Json.Decode.decodeString companyDecoder


companyListEncoder : List Company -> Json.Encode.Value
companyListEncoder companyList = 
    Json.Encode.list companyEncoder companyList


companyListDecoder : Json.Decode.Decoder (List Company)
companyListDecoder = 
    Json.Decode.list companyDecoder


encodeCompanyList : List Company -> Int -> String
encodeCompanyList companyList indent = 
    companyListEncoder companyList |> Json.Encode.encode indent


decodeCompanyList : String -> Result Json.Decode.Error (List Company)
decodeCompanyList = 
    Json.Decode.decodeString companyListDecoder
