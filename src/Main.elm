module Main exposing (..)

import Browser
import Http
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as D exposing (Decoder, field, string)

-- MODEL ----
jsonUrl : String
jsonUrl =
    "http://127.0.0.1:9090/people.json"

type Payload = GotItems (Result Http.Error (List Person))

decode : Decoder (List Person)
decode = (D.list (
    (D.field "firstName" D.string),
    (D.field "lastName" D.string),
    (D.field "prefName" D.string),
    (D.field "jobTitle" D.string),
    (D.field "department" D.string),
    (D.field "directReports" D.string),
    (D.field "division" D.string),
    (D.field "email" D.string),
    (D.field "location" D.string),
    (D.field "imgUrl" D.string),
    (D.field "reportsTo" D.string),
    (D.field "workPhone" D.string),
    (D.field "ext" D.string),
    (D.field "personalPhone" D.string),
    (D.field "id" D.string),
    (D.field "linkedInUrl" D.string),
    (D.field "twitterUrl" D.string),
    (D.field "facebookUrl" D.string),
    (D.field "instagramUrl" D.string),
    (D.field "timeOff" D.string),
    (D.field "timeOffIcon" D.string),
    (D.field "skype" D.string),
    (D.field "pinterest" D.string),
    (D.field "pronouns" D.string))
    )

get : Cmd Payload
get =
    Http.get
    { 
        url = jsonUrl,
        expect = Http.expectJson GotItems (D.list (Person {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        }))
    }


type alias Model =
    { content : String
    }


init : Model
init =
    { content = ""
    }



---- UPDATE ----


type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change new ->
            { model
                | content = new
            }



---- VIEW ----


type alias Person =
    { firstName : String
    , lastName : String
    , prefName : Maybe String
    , jobTitle : String
    , department : String
    , directReports : List String
    , division : Maybe String
    , email : String
    , location : String
    , imgUrl : String
    , reportsTo : Maybe String
    , workPhone : Maybe String
    , ext : Maybe String
    , personalPhone : Maybe String
    , id : Int
    , linkedInUrl : Maybe String
    , twitterUrl : Maybe String
    , facebookUrl : Maybe String
    , instagramUrl : Maybe String
    , timeOff : Maybe String
    , timeOffIcon : Maybe String
    , skype : Maybe String
    , pinterest : Maybe String
    , pronouns : Maybe String
    }


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working. Yay!" ]
        , h2 [] [ text ("Welcome, Mr " ++ model.content) ]
        , input
            [ placeholder "enter name here"
            , value model.content
            , onInput Change
            ]
            []
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }
