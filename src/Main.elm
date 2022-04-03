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


type Model
    = Failure
    | Loading
    | Success String
type Msg = GotItems (Result Http.Error (List String))

decode : Decoder (List String)
decode =
    D.list ((D.field "firstName" D.string))

get : Cmd Msg
get =
    Http.get
    { 
        url = jsonUrl,
        expect = Http.expectJson GotItems decode
    }

init : () -> (Model, Cmd Msg)
init _ =
  ( Loading
  , Http.get
      { url = "https://elm-lang.org/assets/public-opinion.txt"
      , expect = Http.expectString GotText
      }
  )



---- UPDATE ----


update : Msg -> Model -> Model
update msg model =
    case msg of
        GotItems result ->
            case result of
                Ok json ->
                    (Success json, Cmd.none)



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
            [] ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }
