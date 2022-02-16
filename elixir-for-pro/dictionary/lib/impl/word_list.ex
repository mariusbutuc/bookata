defmodule Dictionary.Impl.WordList do
  @type t :: list(String.t())

  @doc """
  Read the word list file [1] into a list of words.

    [1]: https://coding-gnome.com/courses/e4p2/assets/words.txt
  """
  @spec word_list() :: t
  def word_list() do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r{\n}, trim: true)
  end

  @spec random_word(t) :: String.t()
  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
