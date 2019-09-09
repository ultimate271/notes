So this is a document meant to assist new users to python and SQLite who don't
want to run complicated frameworks and instead just want to know the bare bone
essentials required when it comes to connecting to a SQLite database.

The prerequisites are this.

    Python is installed (sqlite3 is a builtin module to pythons core libs)
    sqlite3 is installed (I am not certain this is required, but it certainly won't hurt)

Because that seems too simple for me (python always does) lets throw in some
things that are not required.

    Third party framework (although I'm sure a good ORM is worth learning)
    Existing database (No need to make a db from outside python)
    An internet connection
    Other bullshit

Now that all of these things are set forth, let's get past the nonsense and get
to understanding what is required to create to and connect to a SQLite database
from Python.

The first thing to do is of course import the built in SQLite3 module. This is
quite simply the single line of code

    import sqlite3

Once that is done, the sqlite3 base keyword can be used to reference the
methods used to create and manipulate a database object. The first thing to do
is connect to the database file. If you know the filename (which you should at
this point, this is a sqlite reference, not a file system maintainence one)
then you can say

    conn = sqlite3.connect(filename)

How fucking easy is that shit? Suddenly you have gone from not interoping at
all with any database to getting the full database encapsulated inside of one
object. How neat. As a bonus, if the file doesn't exist, python will create it
for you and pretend as though it always did completely silentely. Awesome!

But is it really that neat? After all, we have no idea how this conn object
behaves. Fear not, because there are only a few things that are relevent.

Firstly, it is possible to extract out cursors and use them to curse through
the database. It seems from reading documentation thought that this is not the
recommeneded or desired way to do things, mostly because there are functions
built in to the connection which handle all of the cursor nonsense for the
programmer in a black box and more efficient way then the idiot developer can.
Since we are that idiot developer, we will not touch cursors.

Unfortunately, it seems as though the functions used for interacting with the
database require the developer to inject strings containing SQL. Fortunately,
the degree to which such nonsense is tolerated is minimal and can be mitigated.

So I have just done some playing. Here is what you need to know.

    Execute does all of the SQL stuff.
    Commit makes the execute statement stuff persist.

I have just experimented with the most pertinant question which I know is on
your mind right now. Here is the results.

When you insert into a database, then select from it without commiting, you
will see the inserted records. If you then close the connection without
commiting (by either using sqlite3.close() or by reseting whatever program you
are running) and reopen it, you won't see the changes. You must use the commit
method for the thing to happen.

The next question becomes... which methods of sqlite3 have calls to commit? Let
me experiment some more.

So to answer that question, it seems as though the execute method does nothing
in the way of commiting anything. It simply does it's own thing.

That is basically everything you need to know about importing sqlite3. I'm not
going to go over how to wrap this nicely for the reason that (one) you should
be learning to use an ORM rather than homebrew your own from this simple
connection and (two) because the topic of this thing is not wrapping, its
connecting to the raw sqlite database.

To recap...

    import sqlite3
    create a connection using sqlite3.connect(filename)
    make sql commands with the conn.execute(query, parameters) function (? is the named parameter by the way, and execute takes an overload with a list of parameters)
    commit those commands with the conn.commit() function
    close the connection with conn.close() when you are finished with it

Easy game easy life

