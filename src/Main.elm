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
    firstName
    lastName
    prefName
    jobTitle
    department
    directReports
    division
    email
    location
    imgUrl
    reportsTo
    workPhone
    ext
    personalPhone
    id
    linkedInUrl
    twitterUrl
    facebookUrl
    instagramUrl
    timeOff
    timeOffIcon
    skype
    pinterest
    pronouns



personListDecoder : Decoder (List Person)
personListDecoder =
    Js.list personDecoder