#ruby-function

[![Build Status](https://travis-ci.org/seadowg/ruby-function.png?branch=master)](https://travis-ci.org/seadowg/ruby-function)

## Description

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
