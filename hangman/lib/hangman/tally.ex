defmodule Hangman.Tally do

  defstruct(
    game_state: :initializing, # :won | :lost | :already_used | :good_guess | :bad_guess | :initializing
    turns_left: 7,             # the number of turns left (game starts with 7)
    letters:    [],            # the state of the word the user is trying to guess
    used:       [],            # A sorted list of the letters already guessed
    last_guess: nil            # the last letter guessed by the player  
  )
  
end