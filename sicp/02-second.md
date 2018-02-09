- Craig: History of Hip-Hop » Brooklin Radio something
- DrRacket
    + Waterloo: taught as intro to computing
    + Realm of Racket
- using Racket as opposed to Scheme
- macro: code that writes code
- 1.1.6 Conditional Expressions and Predicates
    + conds
    + form versus procedure
        * procedures are normal forms?
        * evaluation rules: evaluate each expression in the parens
    + what does define return?
        * everything evaluates to something
        * everything has a return value
- exercise 1.4
    + define: set this shit in global scope for me
    + curry-ing versus partial application of functions
        * not the same thing?
- ex 1.5
    + applicative versus normal-order-evaluation
        * different ways of evaluating
            - (define (cube x) (* x x x))
            - …

            - (define (p) (p))

            - (define (test x y) 
                  (if (= x 0) 
                      0 
                      y))

            - (test 0 (p))

        * applicative-order-evaluation
            - section 1.1.3
            - **evaluate the arguments and then apply**
            - method that the interpreter actually uses

            - replace the body first
            - resolve left-most first
            
        * normal-order-evaluation
            - section 1.1.5
            - alternative
            - **fully expand and then reduce**

            - text substitution 
                + until you are left with only primitive operators
            - evaluate
                + apply the operator to the operands

- boulevardier
    + https://crntaylor.wordpress.com/2011/07/07/sicp-1-1-exercises/
    + https://en.wikipedia.org/wiki/Fl%C3%A2neur
    + https://en.wiktionary.org/wiki/boulevardier

- 1.1.7
    + procedures vs mathematical functions
        * procedures 
            - must be effective
                + https://www.google.ca/search?q=define%3Aeffective
                + produces an effect
                    * https://www.google.ca/search?q=define%3Aeffect
                    * in the call chain
                + effect versus side-effect
            - describe how to do things
        * mathematical function
            - describe properties of things
            - a declarative mapping between two sets: 
                + given value X out of the first set, match value Y from the second set
- slack bot: 
    + make me a sidebar channel
    + invite me all people that are on the @sicp channel

- left off: exercise 1.7
