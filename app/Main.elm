import Html exposing (..)
import Html.Attributes exposing (..)

moodList = [ "Amused", "Bewildered", "Dirty", "High" ]

renderDrink =
  div [ class "drink" ]
    [ div [ class "divider" ] [],
      img [ src "dist/assets/images/question.svg" ] []
    ]

renderMoodList =
  let
    items = List.map (\mood -> li [ ] [ text mood ] ) moodList
  in
    ul [ class "mood-list" ] items

main =
  div [ id "content" ]
    [
      h1 [ ] [ text "Fancy a drink?" ],
      span [ class "intro"] [ text "Drinks based on your mood. Just select your mood and receive a drink recommendation just for you." ],
      renderMoodList,
      renderDrink
    ]
