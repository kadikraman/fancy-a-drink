import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

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

moodList = [ "amused", "bewildered", "dirty", "high" ]

renderDrink address model =
  div [ class "drink" ]
    [ div [ class "divider" ] [],
      img [ src "dist/assets/images/question.svg" ] []
    ]

renderMoodList address model =
  let
    items = List.map (\mood -> li [ onClick address (NewMood mood) ] [ text mood ] ) moodList
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

