defmodule Hangman.Game do
    
  def new_game() do
    %Hangman.Tally{}
      |> Map.put(:letters, get_word())
  end

  defp get_word() do
    Dictionary.random_word 
      |> String.codepoints()
      |> Enum.map(&( "_#{&1}" ))
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

  defp format_letters(list) do
    list 
      |> Enum.map(&( String.replace(&1, ~r/_./, "_") ))
  end

  def make_move(game, guess) do
    guess_used? = game |> Enum.member?(guess)

    game 
      |> Map.put(:last_guess, guess)
      |> check_used(guess_used?)

  end

  defp check_used(game, true) do
    game
      |> Map.put(:game_state, :already_used)
  end

  defp check_used(game, false) do
    game
  end

  # defp check_guess(%{game_state: :initializing} = game, guess) do
    
  # end
end