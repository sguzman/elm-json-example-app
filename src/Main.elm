module Main exposing (..)

import Browser exposing (element)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Js exposing (Decoder, field, string, list)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL
type alias Person
    = {
        firstName : String,
        lastName : String,
        prefName : String,
        jobTitle : String,
        department : String,
        directReports : String,
        division : String,
        email : String,
        location : String,
        imgUrl : String,
        reportsTo : String,
        workPhone : String,
        ext : String,
        personalPhone : String,
        id : String,
        linkedInUrl : String,
        twitterUrl : String,
        facebookUrl : String,
        instagramUrl : String,
        timeOff : String,
        timeOffIcon : String,
        skype : String,
        pinterest : String,
        pronouns : String
    }


type Model
    = Failure
        | Loading
        | Success String


init : () -> (Model, Cmd Msg)
init _ =
    (Loading, getRandomCatGif)



-- UPDATE


type Msg
    = MorePlease
        | GotGif (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        MorePlease ->
            (Loading, getRandomCatGif)

        GotGif result ->
            case result of
                Ok url ->
                    (Success url, Cmd.none)

                Err _ ->
                    (Failure, Cmd.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Random Cats" ]
        , viewGif model
        ]


viewGif : Model -> Html Msg
viewGif model =
    case model of
        Failure ->
            div []
            [ text "I could not load a random cat for some reason. "
            , button [ onClick MorePlease ] [ text "Try Again!" ]
            ]

        Loading ->
            text "Loading..."

        Success url ->
            div []
            [ button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ]
            , img [ src url ] []
            ]



-- HTTP


getRandomCatGif : Cmd Msg
getRandomCatGif =
    Http.get
        { url = "http://localhost:9090/people.json"
        , expect = Http.expectJson GotGif gifDecoder
        }


gifDecoder : Decoder String
gifDecoder =
    Js.field "data" (Js.field "image_url" Js.string)

personDecoder : Decoder Person
personDecoder =
    Js.map3 Person
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



personListDecoder : Decoder (List Person)
personListDecoder =
    Js.list personDecoder