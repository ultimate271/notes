Because Python is so awesome, support for enums is through OOP. There is an
"Enum" base class in the "enum" module. All an enum is is a simple object that
inherits some methods. It's pretty awesome when you think about it.

So lets get the bullshit nonsense out of the way. The best way to import enum
functionality is to put

    from enum import Enum

Then the "Enum" becomes a base level keyword in your module.

The best way to create an actual Enum then (I'm using peculiar terminolgy
because of my .Net bullshit background. Forgive me.) is

    class Foo(Enum):
        RED = 1
        BLUE = 2
        #etc

What good does this do anyone? After all, there is no reason why I couldn't
create another class "Bar" which is defined exactly like Foo but doesn't extend
Enum.

Firstly, accourding to the docs that I am reading right now, the Enum class is
actually special in some way. In what way I don't know, but I'm sure you can
find the docs yourself if you are really interested.

Secondly, there are some cool things about the way that enums behave that are
not there for regular classes.

When you print an enum member, it will print more nicely.

    print (Foo.RED)   #prints foo.RED rather than 1

More cool than that though it's possible to gather the enum name from its
value. I can say

    Foo(value) #I will get the member which contains that value.

If I get an enum member this way (call it mem) then I can say

    mem.name

and it will give me a string containing the name of the member. Pretty neat if
you ask me.

Another reason to use enums is just for a bit of security. If one attempts to
define two enumeration members with the same name an exception is thrown,
namely a "TypeError". If one attempts to define two enumeration members with
the same value, no error is thrown, but the second value is an alias to the
first. EG

    class Blah(Enum):
        RED = 1
        BLUE = 2
        BURGANDY = 1

Blah.BURGANDY.name will return RED. Neat.

There is a lot more bullshit in regards to some fancy pants nonsense that you
can do if you utilize some lesser known features of the enum class. That shit
is pointless and should be ignored.

The only exception to this, now that I look at it, is the Flag subclass of
Enum, which is an enumerated flag (as one might expect) the bitwise operators
(|, &, ^, ~) can be used to build flag-based enumerations. Fun.
