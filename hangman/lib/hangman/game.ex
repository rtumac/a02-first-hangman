defmodule Hangman.Game do
    
  def new_game() do
    %Hangman.Tally{}
      |> Map.put(:letters, get_word())
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,                
      letters:    game.letters |> format_letters(),              
      used:       game.used,   
      last_guess: game.last_guess           
    }
  end

  def make_move(game, guess) do

  end

  defp get_word do
    Dictionary.random_word 
      |> String.codepoints()
      |> Enum.map(&( "_#{&1}" ))
  end

  defp format_letters(list) do
    list 
      |> Enum.map(&( String.replace(&1, ~r/_./, "_") ))
  end

end