## Chapter 2. The Lay of the Land

> A web server is a natural problem for a functional language to solve.

You can think of any web server as a function: 
    - the URL = a function call to some remote server. 
    - in: your request 
    - out: some response. 

It's all functions. Functions that call functions:
    - whenever it’s possible, we try to limit _side effects_ to the controller.
    - try to keep the functions in our models and views _pure_: calling the same function with the same arguments will always yield the same results.

Data
    - processed in the model
    - read / written through the controller.

Throwaway Project

In Elixir, repetitive tasks that manage the programming cycle will run in Mix.

Check PostgreSQL user: 

```
$ psql postgres -U $(whoami)
```
