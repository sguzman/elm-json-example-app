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

get : Cmd Payload
get =
    Http.get
    { 
        url = jsonUrl,
        expect = Http.expectJson GotItems (D.list (Person {
        firstName = (D.field "firstName" D.string),
        lastName = (D.field "lastName" D.string),
        prefName = (D.field "prefName" D.string),
        jobTitle = (D.field "jobTitle" D.string),
        department = (D.field "department" D.string),
        directReports = (D.field "directReports" D.string),
        division = (D.field "division" D.string),
        email = (D.field "email" D.string),
        location = (D.field "location" D.string),
        imgUrl = (D.field "imgUrl" D.string),
        reportsTo = (D.field "reportsTo" D.string),
        workPhone = (D.field "workPhone" D.string),
        ext = (D.field "ext" D.string),
        personalPhone = (D.field "personalPhone" D.string),
        id = (D.field "id" D.string),
        linkedInUrl = (D.field "linkedInUrl" D.string),
        twitterUrl = (D.field "twitterUrl" D.string),
        facebookUrl = (D.field "facebookUrl" D.string),
        instagramUrl = (D.field "instagramUrl" D.string),
        timeOff = (D.field "timeOff" D.string),
        timeOffIcon = (D.field "timeOffIcon" D.string),
        skype = (D.field "skype" D.string),
        pinterest = (D.field "pinterest" D.string),
        pronouns = (D.field "pronouns" D.string),
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
