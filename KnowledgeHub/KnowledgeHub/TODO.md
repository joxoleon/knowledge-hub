# TODO List

## Main Focus Tasks
- [x] Refactor `LessonSectionView` to support new `ColorManager`
- [x] Determine a Lession View Layout
- [x] Create a Lesson View (comprised of LessionSectionViews)
- [x] Create lesson model and business logic
- [x] Make the lesson view configurable by injecting it with the appropriate lesson business model
- [x] Figure out how these are going to be configured and layed out in SwiftUI
- [x] Think of the models that are going to represent the business logic for courses, roadmaps and lessons and how are they going to be interconnected
- [x] Design and think about how Quiz is going to be implemented
- [x] Implement: Question as a protocol, MultipleChoiceQuestion and Quiz models
- [x] Figure out how to have progress tracking done regarding lessons and learning modules
- [x] Implement progress tracking repository
- [x] Implement MultipleChoiceQuestion UI
- [x] Implement Quiz UI and navigation flow
- [x] Once that model is designed and implemented in a basic way, you need to figure out a good way how that content is going to be fed
into the app and formatted in a correct way
- [x] Figure out how the LessonView (entire lesson) is going to fit into the rest of the app - is it going to be embedded into something - it needs to be completely fullscreen in order to have the most space for the text
- [x] Make that service abstract in such a way that it's API can be used independetly from where the lessons are being fetched, like a LessonService or some shit like that
- [x] Implement a feature to read a lesson from the Quiz view
- [x] See where those lessons will be transformed into appropriate lesson models
- [x] Figure out a format in which the lessons are going to be created/stored (maybe json, maybe sections of MD with different annotations that need to be parsed)
- [x] Create a local respository service that is going to be responsible for holding entire courses, with their roadmaps and lessons.
- [x] Write unit tests for question, quiz and progres tracking repository implementations

## Backglog Tasks
- [ ] Autohide the tab indicator at the bottom of the lesson screen

## Ideas 
- [ ] AI Integration for quizzing
- [ ] Create a daily quiz recommendation system


---

### Ideas for progress

It needs to contained the following info:
- Course overview:
    - Course title
    - Read time
    - Lesson Count
    - Question count
    -
- Overall progress:
    - Lessons completed / Lessons Remaining
    - Questions completed / Questions Remaining
- Overall score
    - Score value
    - Lesson count with poor scores
    

The progres view should have the following buttons leading to:
- Starred content
- Improve your score - navigate to a list of lessons that have score not perfect score
- Go to first lesson that you didn't start
- Completed lessons

The screen should present an overview of the achieved data and course details and allow you to navigate to lists of favorited content, lessons with poor scores and lessons that have not been started yet.
