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
    guess_used? = game.used |> Enum.member?(guess)
    
    new_state = game 
      |> Map.put(:last_guess, guess)
      |> check_used(guess_used?)
      |> check_guess()
      |> update_turns()
      |> check_won_or_lost()

    { new_state, tally(new_state) }
  end

  defp check_used(game, true) do
    game
      |> Map.put(:game_state, :already_used)
  end

  defp check_used(game, false) do
    game
      |> Map.put(:game_state, :initializing)
      |> Map.put(:used, game.used ++ [ game.last_guess ] |> Enum.sort())
  end

  defp check_guess(%{ game_state: :already_used } = game) do
    game
  end

  defp check_guess(game) do
    new_letters = game.letters |> Enum.map(fn x -> 
      String.replace(x, ~r/_(#{game.last_guess})/, "\\1")
    end)

    game |>
      check_guess(game.letters, new_letters)
  end

  defp check_guess(game, letters, letters) do
    game
      |> Map.put(:game_state, :bad_guess)
  end

  defp check_guess(game, _letters, new_letters) do
    game
      |> Map.put(:game_state, :good_guess)
      |> Map.put(:letters, new_letters)
  end

  defp update_turns(%{ game_state: :bad_guess } = game) do
    game
      |> Map.put(:turns_left, game.turns_left - 1)
  end

  defp update_turns(game) do
    game
  end

  defp check_won_or_lost(%{ turns_left: 0 } = game) do
    game
      |> Map.put(:game_state, :lost)
      |> Map.put(:letters, game.letters |> reveal_all_letters())
  end

  defp check_won_or_lost(game) do
    if( Enum.find(game.letters, fn x -> String.at(x, 0) == "_" end) ) do
      game
    else
      game
        |> Map.put(:game_state, :won)
    end
  end

  defp reveal_all_letters(letters) do
    letters |> Enum.map(fn x -> String.replace(x, ~r/_(.)/, "\\1") end)
  end

end