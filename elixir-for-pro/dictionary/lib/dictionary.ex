defmodule Dictionary do
  @doc """
  Turn [the provided the word list file][1] into a list of words.

    [1]: https://coding-gnome.com/courses/e4p2/assets/words.txt
  """
  def word_list do
    words = File.read!("assets/words.txt")
    String.split(words, ~r{\n}, trim: true)
  end

  def random_word do
    Enum.random(word_list())
  end
end
