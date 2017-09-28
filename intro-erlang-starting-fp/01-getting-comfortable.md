## Chapter 1: Getting Comfortable

  - Erlang/OTP 20.1
  - `erl`

### First Steps: The Shell
  - `q().` 

  - moving through history:
    + `h().` —see history
    + `e(N).` —execute certain line
    + `v(N).` —reference a given result value

  - moving through files
    + `pwd().`
    + `cd("bookata/intro-erlang-starting-fp").`
    + `ls().`

### Numbers in Erlang

> If you need to keep track of money, integers are going to be a better bet. 
> Use the smallest available unit—cents for US dollars, for instance—and 
> remember that those cents are 1/100 of a dollar. For more complex 
> calculations, though, you’ll want to use floats, and just be aware that the 
> results will be imprecise.

### Working with Variables in the Shell

> Erlang variable names begin with a capital letter or an underscore:
>   - normal variables start with a capital letter, 
>   - whereas underscores start “don’t care” variables.

> Erlang’s _single assignment_ model, where each variable can be assigned a 
> value only once in a given context, imposes discipline whose value you will 
> see in later chapters.

> When you assign a value to a variable, you should make sure all calculations 
> are on the right side of the equal sign (`2 * M = 3 * 4`). 

  - Seeing the bound variables
    + `b().`

  - Clearing bound variables in the shell
    + `f(M).`
    + `f().`
