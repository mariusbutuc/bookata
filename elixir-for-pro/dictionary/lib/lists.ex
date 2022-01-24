defmodule Lists do
  @moduledoc """
  Explore Lists, Pattern Matching, and Recursion
  """

  @doc """
  Calculate the length of a list.
    - the length of an empty list is 0
    - the length of any other list is 1 plus the length of the tail

  ## Examples

      iex> Lists.len([])
      0

      iex> Lists.len([1, 2, 3])
      3

  """
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  @doc """
  Sum the elements of a list.
  The sum of an empty list is 0.

  ## Examples

      iex> Lists.sum([])
      0

      iex> Lists.sum([1, 2, 3])
      6

  """
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)

  @doc """
  Double every element in a list.

  ## Examples

      iex> Lists.double([1, 3, 7])
      [2, 6, 14]

  """
  def double([]), do: []
  def double([head | tail]), do: [head * 2 | double(tail)]

  @doc """
  Square the elements in a list.

  ## Examples

      iex> Lists.square([1, 3, 7])
      [1, 9, 49]

  """
  def square([]), do: []
  def square([head | tail]), do: [head ** 2 | square(tail)]

  @doc """
  Generic function that applies the given function to each element in the given list.

  Decouple
    1. the concept of mapping values (structure) from
    2. the concept of what I do to each value (individual transformation).

  ## Examples

      iex> Lists.map([1, 3, 7], fn (x) -> x * 3 end)
      [3, 9, 21]

      iex> Lists.map([1, 3, 7], &(&1 ** 3))
      [1, 27, 343]

  """
  def map([], _func), do: []
  def map([h | t], func), do: [func.(h) | map(t, func)]

  @doc """
  Take a List and return a List which is half the original length and each element is the sum of two elements in the input.

  ## Examples

      iex> Lists.sum_pairs([1, 2, 3, 4, 5, 6, 7, 8])
      [3, 7, 11, 15]

      iex> Lists.sum_pairs([1, 2, 3, 4, 5, 6, 7])
      [3, 7, 11, 7]

  """
  def sum_pairs([]), do: []
  def sum_pairs([h | []]), do: [h]
  def sum_pairs([h1, h2 | t]), do: [h1 + h2 | sum_pairs(t)]

  @doc """
  Return `false` if the passed in list has an odd number of elements, `true` otherwise.

  ## Examples

      iex> Lists.even_length?([])
      true

      iex> Lists.even_length?([1])
      false

      iex> Lists.even_length?([1, 2])
      true

      iex> Lists.even_length?([1, 2, 3, 4, 5, 6, 7])
      false

      iex> Lists.even_length?([1, 2, 3, 4, 5, 6, 7, 8])
      true

  """
  def even_length?([]), do: true
  def even_length?([_h1, _h2 | t]), do: even_length?(t)
  def even_length?([_h | _t]), do: false
end
