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

  [book]: https://www.manning.com/books/the-little-elixir-and-otp-guidebook
  [eqc_ex]: https://github.com/Quviq/eqc_ex
