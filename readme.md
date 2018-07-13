This is a repository where I want to keep all of my cheat sheets,
lists, and notes on whatever I feel like keeping notes for.
Hell, I might even put some embarrassing diary entries.

# A note on reference files
For all of my literature folders, I have written a function in my dotfiles repo
that will do some literary tasks, making it easier to manage who is who and
what is what and what happens to who when, and in order to do that, I have to
have some conventions. So this is what I've got so far.

I want to have a reference file. The reference file and the tags file are
written by the same function, BuildRef or UpdateRef, in my lit.vim file of my
dotfiles repo. A reference file should be structured like so.

#{Most complete name of reference}
##OtherTags
{AnotherTag1}
{AnotherTag2}
{AnotherTagN}
##Commentary
In here will go commentary about the reference that I will create by hand if I
so desire. It can be as long as I like
##References
###Actor
{SourceTag1} Text of the header of the source goes here
{SourceTag2} Etc
###Relationship
{SourceTag5} Name of Relationship {TagToRelationship}
###Ref
{SourceTag3} Text of the header
{SourceTag4} Etc
###Generated

In order for this to work, the reference.md file and the tags file will have to
be written simultaneously, that is in the same function, and any change to the
reference file will have to be made to the tags file.

#
So I have decided to (ab)use the reference tag functionality of markdown to
create a way of annotating my files. I have in my head something like this.

[Actor]: {Aloysha}
