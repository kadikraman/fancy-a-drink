import Html exposing (..)
import Html.Attributes exposing (..)


main =
  div [ id "content" ]
    [
      h1 [ ] [ text "Fancy a drink?" ],
      span [ class "intro"] [ text "Drinks based on your mood. Just select your mood and receive a drink recommendation just for you." ]
    ]
