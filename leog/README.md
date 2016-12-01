# The Little Elixir & OTP Guidebook <sup>[book][book]</sup>

1. **Chapter 11**. Property-based and concurrency testing
  + Main
    * Property-based testing with [QuickCheck][eqc_ex]
    * Detecting concurrency errors with Concuerror
  + Property-based testing with [QuickCheck][eqc_ex]
    * Turns unit testing on its head
      - instead of writing specific test cases, as with traditional unit testing, property-based testing forces you to express test cases in terms of general specifications
      - once you have these specifications in place, the tool can generate as many test cases as your heart desires
    * How do you go about designing your own properties?
        - inverse functions
            + Encoding and decoding
            + Serializing and deserializing
            + Splitting and joining
            + Setting and getting
        - exploiting invariants
            + a `sort` function always sorts elements in order
            + a monotonically increasing function is always such that the former element is less than or equal to the next element
        - test against an existing implementation
            + compare a (custom) implementation with [one from Erlang][thomas-arts-2015]
        - using a simpler implementation to test a more complicated one
        - performing operations in different orders
        - idempotent operations
    * Custom generators
        - `string_with_commas`
            + it has to be 1–10 characters long
            + the string should contain lowercase letters
            + the string should contain commas
            + commas should appear less frequently than letters
        - `collect` reports statistics for the generated data
        - `:eqc.classify/3` used to check the distribution of test data
        - exercise for the reader
            + a DNA sequence consisting of only As, Ts, Gs, and Cs. An example is ACGTGGTCTTAA.
            + a hexadecimal sequence including only the numbers 0–9 and the letters A–F. Two examples are 0FF1CE and CAFEBEEF.
            + a sorted and unique sequence of numbers, such as -4, 10, 12, 35, 100.


  [book]: https://www.manning.com/books/the-little-elixir-and-otp-guidebook
  [eqc_ex]: https://github.com/Quviq/eqc_ex
  [thomas-arts-2015]: http://www.erlang-factory.com/static/upload/media/144897884167052thomasartserlangfactoryberlin2015.pdf
