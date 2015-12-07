import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Drinks as Drinks


-- VALUES

type alias MoodItem =
  {
    mood: String,
    drink: String,
    image: String,
    description: String
  }


moodList = Drinks.moodList

defaultMood =
  {
    mood = "question",
    drink = "",
    image = "question.svg",
    description = ""
  }





-- MODEL
type alias Model =
  {
    mood : String,
    description: String
  }

initialModel : Model
initialModel =
  {
    mood = "question",
    description = "What will you have?"
  }






-- UPDATE

type Action = NoOp | NewMood String

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    NewMood value ->
      { model | mood = value }







-- VIEW

renderDrink : Model -> Html
renderDrink model =
  let
    record = moodList
      |> List.filter (\ item -> item.mood == model.mood )
      |> List.head
      |> Maybe.withDefault defaultMood
  in
    div [ class "drink" ]
      [ div [ class "divider" ] [],
        h2 [ class "drink-name" ] [ text record.drink ],
        img [ src ("dist/assets/images/" ++ record.image ) ] [],
        p [] [ text record.description ]
      ]

renderMood : Signal.Address Action -> Model -> MoodItem -> Html
renderMood address model moodItem =
  let
    classes = (if model.mood == moodItem.mood then "selected" else "")
  in
    li [ onClick address (NewMood moodItem.mood), class classes ]
      [ text moodItem.mood ]

renderMoodList : Signal.Address Action -> Model -> Html
renderMoodList address model =
  let
    items = List.map (renderMood address model) moodList
  in
    ul [ class "mood-list" ] items

view : Signal.Address Action -> Model -> Html
view address model =
  div [ id "content" ]
    [
      h1 [ ] [ text "Fancy a drink?" ],
      span [ class "intro"] [ text "Drinks based on your mood. Just select your mood and receive a drink recommendation just for you." ],
      renderMoodList address model,
      renderDrink model
    ]






-- SIGNALS

inbox : Signal.Mailbox Action
inbox =
  Signal.mailbox NoOp


actions : Signal Action
actions =
  inbox.signal


model : Signal Model
model =
  Signal.foldp update initialModel actions


main : Signal Html
main =
  Signal.map (view inbox.address) model

