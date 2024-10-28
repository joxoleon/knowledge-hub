
### Title/Topic:
*Insert the lesson topic here, e.g., “SOLID Principles for iOS Development”*

### Focus:
*Briefly describe the specific focus or goal of this lesson, e.g., “Introduce the SOLID principles and explain how they can be implemented in iOS development with examples.”*

---

### Introduction to AI:

You are creating a structured lesson on software engineering concepts for a learning app. This lesson will help users prepare for interviews and deepen their understanding of iOS development, software engineering, and architecture concepts. While the lesson library will eventually expand to cover advanced topics, the current focus is interview preparation for iOS and software engineering.

---

### Lesson Requirements:

#### Format and Structure:

1. **Output**: Format the final lesson as a **single Markdown file (.md)** that follows a consistent structure for readability and compatibility with Markdown editors. **Each section should have a clear delimiter**.

2. **Follow this Rigid Structure with Delimiters**:

   - **Metadata Section**:
     - Begin with metadata in JSON-like format.
     - Include:
        - `id`: A unique identifier in lowercase, underscore-separated format (e.g., `"solid_principles"`).
        - `title`: The lesson title.
        - `description`: A brief description of the lesson’s purpose.

   - **Sections**:
     - **Definition and Introduction**: 
        - Use the delimiter `=== Section: Title Introduction ===` to start this section (Title is the title of the lesson).
        - Start with a heading (chose the weight you want to present) naming the introduction title the best way it should be named
        - Provide a concise definition and introduction to the topic, emphasizing its purpose and significance.
        - Format it in the most sensible way it should be read, emphasizing the important keywords with bold or other formats.
        - End this section with the delimiter `=== EndSection: Title Introduction ===`.
       
     - **Full Lesson**: 
       - Use the delimiter `=== Section: Title ===` to begin the main content section (Title is the title of the lesson).
       - Start with a heading (chose the weight you want to present) naming the title the most according way
       - Provide an in-depth, comprehensive explanation of the topic. Include necessary details, examples, and best practices.
       - When using code examples, avoid using "```" and instead indent code blocks with spaces to maintain text flow.
       - Split it up into sensible sections and paragraphs, code blocks, quotes, etc.
       - If you think this needs to be broken down into multiple sections then break it down into as many sections as you deem necessary, there can be let's say up to 5-6 sections the full lesson section can be split up in.
            - Do not split it up if what you are explaining isn't necessary to be in multiple sections, but if there are multiple concepts that all deserve their own section, then definitely split it up, although sparingly. 
       - End this section with the delimiter `=== EndSection: Lesson Title ===`.
       
     - **Discussion**: 
       - Use the delimiter `=== Section: Discussion ===` to start the discussion.
       - Cover pros, cons, common use cases, or comparisons with similar concepts to provide broader context for the topic.
       - End this section with the delimiter `=== EndSection: Discussion ===`.
       
     - **Key Takeaways**: 
       - Use the delimiter `=== Section: Key Takeaways ===`.
       - Provide a concise list of essential points that summarize the lesson, suitable for flashcards.
       - End this section with the delimiter `=== EndSection: Key Takeaways ===`.

3. **Questions Section**:
   - At the end of the lesson, include an array of multiple-choice questions in JSON-like format.
   - **Each question should include**:
     - `id`: A unique question identifier based on the lesson ID and question number (e.g., `"solid_principles_q1"`).
     - `type`: Question type (e.g., `"multiple_choice"`).
     - `proficiency`: Difficulty level (e.g., `"basic"`, `"intermediate"`, or `"advanced"`).
     - `question`: The text of the question, presented in a markdown string (you can use code blocks or anything the question needs for formatting).
     - `answers`: An array of possible answers.
     - `correctAnswerIndex`: Index of the correct answer within the `answers` array.
     - `explanation`: A brief explanation that clarifies why the correct answer is right and why other options are incorrect. This should also be in markdown.
   - **Requirements**:
     - Include at least 5 questions with detailed, thoughtful options that cover different aspects of the topic to ensure comprehensive understanding.

4. **Quality and Readability**:
    - Use clear, professional language suitable for an advanced audience.
    - Ensure examples are understandable and demonstrate real-world applicability where possible.
    - Write high-quality, concise key takeaways that are suitable for flashcard-style review.
    - Within the lesson, use bold and different formatting styles to emphasize important keywords in all lesson sections. 
        - But do not highlight keywords like "iOS development", but concepts that need to be emphasized 
            - e.g. if you are talking about SOLID principles, each of the principles need to be bold.
            - e.g. if you are talking about Protocols in Swift, highlight the keywords "contract" or "blueprint", highlight the fact that they can have "properties" and "methods", etc.
        - Be moderate in use of this bold, highlighted, emphasized text, use it sensible but make sure that things that need to be remembered need to be remembered.
    - Do note give out huge blocks of text all in a single paragraph, format the paragraphs explanations you are outputting to make them very professional but also easy to read. Split it up in a sensible way.


---

### Sample Lesson

**Title/Topic**: Dependency Injection in iOS

**Focus**: Introduce Dependency Injection (DI) and demonstrate how it can improve code modularity and testability in iOS development, including practical code examples.

---

**Instructions to AI**:

Generate a markdown lesson with the following structure:

1. Metadata:
    { 
        "id": "dependency_injection", 
        "title": "Dependency Injection in iOS", 
        "description": "An introductory lesson on Dependency Injection and its benefits in iOS applications."
    }

2. Sections:
    - `=== Section: Introduction Title ===`
      Provide a short, concise definition of Dependency Injection, explaining its purpose in software engineering.
      `=== EndSection: Introduction Title ===`

    - `=== Section: Title ===`
      Provide an in-depth explanation of Dependency Injection, covering what it is, why it’s beneficial, and how it can be implemented in iOS. Include examples to show how DI can make code more modular and testable. Avoid using "```" for code blocks; indent instead to maintain text flow.
      `=== EndSection: Title ===`

    - `=== Section: Discussion ===`
      Discuss the pros and cons of Dependency Injection, alternative approaches, and real-world applications where DI is especially useful in iOS development.
      `=== EndSection: Discussion ===`

    - `=== Section: Key Takeaways ===`
      Summarize the main points with concise, flashcard-friendly statements.
      `=== EndSection: Key Takeaways ===`

3. Questions:
    - Create at least 5 multiple-choice questions relevant to Dependency Injection. Include an explanation for each answer to reinforce understanding. Use the following format:
      [
          {
              "id": "dependency_injection_q1",
              "type": "multiple_choice",
              "proficiency": "basic",
              "question": "What is Dependency Injection?",
              "answers": [
                  "A way to protect data within an object",
                  "A method to manage object dependencies",
                  "A programming loop",
                  "A type of data structure"
              ],
              "correctAnswerIndex": 1,
              "explanation": "Dependency Injection is a design pattern that manages dependencies by injecting them, making code more modular and testable."
          },
          // Additional questions following the same structure
      ]

---

Ensure all parts of the lesson are well-structured, informative, and cover the topic from multiple angles. This template is designed to guide AI in generating high-quality, structured content suitable for software engineering and iOS interview preparation.
