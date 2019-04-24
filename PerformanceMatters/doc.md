# Performance Matters Utility

This documentation exists to give developers an idea of how the utility is
structured, so that when something needs to be added to it, it will be known in
advance in what way that new feature is added.

The utility, at the present moment, has four projects. They are

* Service
* SettingsEditor
* Shared
* UserInterface

The **Service** project is what will actually run on the client machine.

The **UserInterface** project is for developers to debug the whole process.

The **Shared** project is the project where both of these things point to. More
detail must be put in to this project, as it is where most of everything
happens (except the users front end, but even that references this [Shared]
project).

The **SettingEditor** project is a front end project for the end user. It will
give the ability to tweak their settings, to change how the utility is run for
them.

# [Shared] Project
The main file of this project is, of course, **Worker.vb**.

Worker.vb was copied from Worker.vb of the Alliant Background worker, and then
adjusted to my needs for this project. There is an underlying timer tick, and
when that tick happens the system will determine if there are jobs that need to
be run. If there are, it will run them in a background thread. When adding a
new job, this file should not need to be modified, and in general, unless an
entirely new feature to the project is added that requires it, this file should
not need to be altered much at all.

Every job that can be performed will extend the **PMJob** class. This abstract
class contains all of the information that is common to all jobs, such as
timings, frequency, and DataCollectionSettings.


## PMJob
### tl;dr
When adding a new job, create a new class which extends PMJob. Override the
abstract methods, and then add some attributes to the PMSettings file.

### About PMJob
The PMJob class will also have some abstract methods which will be the
responibility of the developer to override for every new job that is added. For
instance, if the client wants a job that creates the lost revenue report and
emails it to a list of people, it would be the developers responsibilty to
override GetDataSet to get the Lost Revenue Report, and then you would override
the GetRubric to explicitly layout what sort of information you need for this
report, and then you could create an event handler for the "AfterExport" event,
which would kick off after the DoExport function completes, and would do the
task of actually emailing the relevant parties.

(A word of warning here about extending the PMJob class, the **XMLserializer**
can be picky sometimes with the sorts of properties that it wants to serialize,
so adding properties to a derived PMJob class that are public and do not have
the <XMLIgnore> property should be avoided if possible, but if it's not
avoidable, great care should be taken to ensure that the properties that are
added to the job are themselves XMLSerializable (or else the whole damn project
will fail to write to XML, and no one wants that).

Also, while we're on the topic of the XML serializer, in order to avoid using
some rather questionable techniques in reflection to pull off some rather slick
but ultimately over-complicated automation, there will be a few more places in
the class **PMSettings** that you will have to add Attributes such as

    <XMLArrayItem("PMMyNewJob", GetType(PMMyNewJob))>

These locations are clearly marked with comments in the PMSettings class, and
can be found by searching the file for the keyword '[XMLUpkeep], which I have
placed in the appropiate locations and it will take you right there. There
ought to be pre-existing examples of other classes that have needed to be
added, so use those as a guide.)


# About GetRubric
So all that is neccesary to adding a new job is creating an override for the
GetRubric method in PMJob. However, it might be helpful to understand how this
works in order to write a quality function.

So the GetRubric function returns a PMJobSettingsRubric object. If we look at
the PMRubric, the primary outward facing classes that are concerned
with actually building the Rubric are the AddBooleanOption and AddComboOption
functions (and potentially more such functions in the future when more features
have been added). Both of these functions will take in some strings, and these
strings will be used by both the PMJob class (in DataCollectionSettings) and by
the settings editor (to dynamically generate controls for editing these
options) to populate the settings fields for that job.

So the PMRubric class itself only contains information (in the form of a
dictionary) about what sorts of options the job should have, and what data type
those options should take.

The SettingsEditor can then call the GetRubric function for a job. There is a
function in this project which takes a PMRubric and translates it in to a set
of controls that are dynamically generated on the screen  for the user to
interact with.

When the user is done interacting with the controls, they will save, and the
options that he chooses in those dynamically created controls will save to the
xml. The worker will then read that xml, and it will be able to use that
information to get the dataset or export the files.







