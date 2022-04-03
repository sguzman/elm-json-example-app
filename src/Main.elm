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
type Person = {
        "firstName": "Jacqueline",
    "lastName": "Aceves",
    "prefName": null,
    "jobTitle": "Special Education Teacher",
    "department": "Special Education",
    "directReports": [],
    "division": null,
    "email": "jaaceves@growpublicschools.org",
    "location": "Arvin",
    "imgUrl": "https://images7.bamboohr.com/43869/photos/42-0-4.jpg?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9pbWFnZXM3LmJhbWJvb2hyLmNvbS80Mzg2OS8qIiwiQ29uZGl0aW9uIjp7IkRhdGVHcmVhdGVyVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNjQ1NDU1MzQzfSwiRGF0ZUxlc3NUaGFuIjp7IkFXUzpFcG9jaFRpbWUiOjE2NDgwNDczNTN9fX1dfQ__&Signature=fQhaSvVrR1ULTa7qbG6-IUKZg0ybwFd5aDljVOSvW6t19c8E2WwGvRCB3oLwR4GybTeN2LmbSCfrMFWjRZhBc3baygrMyeaiDJeLThVK4lurpGqwjORrMl7zaHqJVfp~W~iaa1j2lACf8aesteNeAQeo3glwsRmH6SxT9y9ws3ig2IXbUY28xIP8FRQouIJ-MX0h062IQGlFDb7HWlmF6lYNt0ZMzh510McbiGFZMmznS8S3wMz8ZZpSx7-l0IU4icdr38WhLaF33ZyFQsk~DR7PBua676hOm~wBEwzWEK47KP9ypPHFnx9mYkYKyi2q5tXlhXTz5XGx2bhIfJ7zWQ__&Key-Pair-Id=APKAIZ7QQNDH4DJY7K4Q",
    "reportsTo": null,
    "workPhone": null,
    "ext": null,
    "personalPhone": null,
    "id": 42,
    "linkedInUrl": null,
    "twitterUrl": null,
    "facebookUrl": null,
    "instagramUrl": null,
    "timeOff": null,
    "timeOffIcon": null,
    "skype": null,
    "pinterest": null,
    "pronouns": null
}

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
