    { 
        "id": "<lesson_id>",                       // Unique identifier for the lesson, e.g., "encapsulation_basics"
        "title": "<lesson_title>",                 // Title of the lesson, e.g., "Encapsulation in Object-Oriented Programming"
        "description": "<lesson_description>"      // Brief description of the lesson content
    }

## Definition and Introduction
<introduction_content>
Provide a brief definition and introduction of the lesson topic here, using markdown text. This section should explain the concept's purpose and significance.

---

## Full Lesson
<full_lesson_content>
Write the main content of the lesson here in markdown format. This section may contain multiple paragraphs, examples, code snippets, and other explanatory text to cover the topic in depth.

### Example Subsection (Optional)
If additional subsections are necessary, include them as part of the "Full Lesson" section. Subsections can be added as needed with a `###` header.

---

## Discussion
<discussion_content>
Provide discussion points here, such as the pros and cons of the topic, its real-world applications, or comparisons with similar concepts. This section encourages deeper understanding and critical thinking about the topic.

---

## Key Takeaways
- List the essential points or main takeaways of the lesson here.
- Use concise bullet points that highlight the core ideas and should be easy to remember for quick review.

---

    [
        {
            "id": "<lesson_id>_q1",               // Question ID, typically combining lesson ID and question number, e.g., "encapsulation_basics_q1"
            "type": "multiple_choice",            // Type of question, e.g., "multiple_choice"
            "profficiency": "basic",              // Proficiency level, e.g., "basic", "intermediate", or "advanced"
            "question": "<question_text>",        // Text of the question
            "answers": [
                "<answer_1>",                     // Answer option 1
                "<answer_2>",                     // Answer option 2
                // Additional answers as needed
            ],
            "correctAnswerIndex": <index>,        // Index of the correct answer in the "answers" array, starting at 0
            "explanation": "<explanation_text>"   // Explanation for why the answer is correct
        },
        // Additional questions in the same format, with unique IDs (e.g., "<lesson_id>_q2", "<lesson_id>_q3")
    ]
