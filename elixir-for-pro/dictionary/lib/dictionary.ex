defmodule Dictionary do
  alias Dictionary.Impl.WordList

  @opaque state :: list(String.t())

  @spec start() :: state()
  defdelegate start(), to: WordList

  @spec random_word(state()) :: String.t()
  defdelegate random_word(word_list), to: WordList
end
