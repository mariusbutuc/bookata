## Chapter 2: Functions and Modules

### Fun with `fun`

  - use `fun` to create functions
    + e.g., calculate the velocity of a falling object based on the distance it drops in meters
      ```erlang
      FallVelocity = fun(Distance) -> math:sqrt(2 * 9.8 * Distance) end.
      ```
