#  Learning Module Design

I want to create a LearningModule class. It is going to be a container for other learning modules and lessons as well: 
- The contents are all going to be structured in an array, in an ordered fashion. 
- So the a LearningModule contains an array of other learning modules (recursively) and lessons all in an array called contents.
- The lessons that it contains aren't going to be full lessons, but just the lesson id
- It needs to have a title that is very short and descriptive of what that learning module is. Basically it is like a topic for a section of a book describing all of its contents
- It needs to have a short description that explains what this module is comprised of, a couple of sentences max, this should be available in markdown (just a simple string formatted in markdown)
- The learning module is something that can be designed manually or through AI by creating a custom json file (or some other format)


## Learning Module File

There needs to be a clear design and rigid structure how this is supposed to look:
- It needs to be initially defined within a file, such as a JSON file or some other more suitable format
- The top level object of this is a learningModule, with all of its properties (i.e. title, description, etc) and of course the contents array where nested objects are defined
- The other learning modules are going to be nested here and formatted in such a way that it is very easy to read and edit manually (AI generation must be though of as well)
- The lesson is only going to be defined by a lesson id and not the entire lesson content
- Think of the parsing flow of the LearningModule with deserialization (done in Swift) and design this file in such a way that it can be easily parsed using Swift
- Maybe wrap the LearningModule and Lesson in differentObects/enums or whatever is easier for deserialization

## Learning Module Types

There needs to be a set of types (classes/structs) that are going to correspond to this, that can be deserialized/parsed from the file:
- Currently the most important one is the LearningModule type that should contain a the defined properties and the nested content that is present here

## Learning module parser

Parser design:
- The parser needs to exist that is going to be able to deserialize/parse the learning module file into a set of types defined in Swift



