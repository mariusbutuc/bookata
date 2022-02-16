defmodule Dictionary.Impl.WordList do
  @doc """
  Read the word list file [1] into a list of words.

    [1]: https://coding-gnome.com/courses/e4p2/assets/words.txt
  """
  def start() do
    "assets/words.txt"
    |> File.read!()
    |> String.split(~r{\n}, trim: true)
  end

  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
