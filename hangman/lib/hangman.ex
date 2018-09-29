defmodule Hangman do
   @moduledoc """
  Documentation for Hangman.
  """

  @doc """
  Hello world.

  ## Examples

    #   iex> Hangman.hello()
    #   :world

  """

  defdelegate new_game(), to: Hangman.Game

  defdelegate make_move(game, guess), to: Hangman.Game

  defdelegate tally(game), to: Hangman.Tally

end