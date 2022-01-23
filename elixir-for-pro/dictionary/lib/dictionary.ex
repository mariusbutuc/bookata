defmodule Dictionary do
  @doc """
  Compile the word list file [1] into a list of words.

    [1]: https://coding-gnome.com/courses/e4p2/assets/words.txt
  """
  @word_list "assets/words.txt"
             |> File.read!()
             |> String.split(~r{\n}, trim: true)

  def random_word do
    @word_list
    |> Enum.random()
  end
end
