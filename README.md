#ruby-function

[![Build Status](https://travis-ci.org/seadowg/ruby-function.png?branch=master)](https://travis-ci.org/seadowg/ruby-function)

## Description

This library provides extensions to Ruby's Proc to allow for some functional goodness.

### Recursive

Recursive calls are pretty easy in Ruby: lambdas, Procs and methods can
all reference themselves. However, these recursive calls will deepen the
Ruby call stack. Enter the `recursive` method:

    recursive { |this|
      this.call
    }

Blocks passed to `recursive` will unroll returning recursive calls so
that the recursion can execute without eating up the Ruby call stack.
This allows for infinitely recursive operations. Here's a quick example:

    inf_marco = recursive { |this, shout|
      puts shout

      if shout == "Marco"
        this.call("Polo")
      else
        this.call("Marco")
      end
    end

    recursive.call("Marco") # => "Marco"
    # => "Polo"
    # => "Marco"
    # => "Polo"
    # ...
    
### Composition

So we can pretend we are coding in Haskell we use the `<<` operator for composition on Procs:

    sort = proc { |array| array.sort }
    reverse = proc { |array| array.reverse }
    reverese_order = sort << reverse
    reverese_order.call [3,1,4,8] #=> [8,4,3,1]
    
When we combine two Procs using `<<` we create a new Proc that will first execute the receiver Proc and
then pass the result to the argument Proc. This provides an expressive and modular approach to creating complex 
high order functons in Ruby.
