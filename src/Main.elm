module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
--import Json

---- MODEL ----
type alias Model = {
    content : String
    }

init : Model
init = {
    content = ""
    }

---- UPDATE ----
type Msg
    = Change String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Change new -> {
                model | content = new
            }

---- VIEW ----
type Person

view : Model -> Html Msg
view model =
    div []
        [
        img [ src "/logo.svg" ] [],
        h1 [] [ text "Your Elm App is working. Yay!" ],
        h2 [] [ text ("Welcome, Mr " ++ model.content) ],
        input [
            placeholder "enter name here",
            value model.content,
            onInput Change
        ] []
        ]

---- PROGRAM ----
main : Program () Model Msg
main =
    Browser.sandbox
        { view = view
        , init = init
        , update = update
        }
