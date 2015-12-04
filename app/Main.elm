import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- VALUES

moodList = [ "amused", "bewildered", "dirty", "high" ]






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

renderDrink : Signal.Address Action -> Model -> Html
renderDrink address model =
  div [ class "drink" ]
    [ div [ class "divider" ] [],
      img [ src "dist/assets/images/question.svg" ] []
    ]

renderMood : Signal.Address Action -> Model -> String -> Html
renderMood address model mood =
  let
    classes = (if model.mood == mood then "selected" else "")
  in
    li [ onClick address (NewMood mood), class classes ]
      [ text mood ]

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
      h2 [ ] [ text model.mood ],
      span [ class "intro"] [ text "Drinks based on your mood. Just select your mood and receive a drink recommendation just for you." ],
      renderMoodList address model,
      renderDrink address model
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

