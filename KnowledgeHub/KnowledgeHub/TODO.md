# TODO List for [Project Name]

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
- [ ] Write unit tests for question, quiz and progres tracking repository implementations
- [ ] Implement MultipleChoiceQuestion UI
- [ ] Implement Quiz UI and navigation flow
- [ ] Once that model is designed and implemented in a basic way, you need to figure out a good way how that content is going to be fed into the app and formatted in a correct way
- [ ] Figure out how the LessonView (entire lesson) is going to fit into the rest of the app - is it going to be embedded into something - it needs to be completely fullscreen in order to have the most space for the text
- [ ] Make that service abstract in such a way that it's API can be used independetly from where the lessons are being fetched, like a LessonService or some shit like that
- [ ] See where those lessons will be transformed into appropriate lesson models
- [ ] Figure out a format in which the lessons are going to be created/stored (maybe json, maybe sections of MD with different annotations that need to be parsed)
- [ ] Create a local respository service that is going to be responsible for holding entire courses, with their roadmaps and lessons.

## Backglog Tasks
- [ ] Autohide the tab indicator at the bottom of the lesson screen

## Ideas 
- [ ] AI Integration for quizzing
- [ ] Create a daily quiz recommendation system
