CREATE TABLE courses
(
    id      Serial PRIMARY KEY,
    name    VARCHAR(200) NOT NULL,
    credits DECIMAL      NOT NULL
);
CREATE TABLE video
(
    id      Serial PRIMARY KEY,
    title    VARCHAR(200) NOT NULL,
    course_id   INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
);

CREATE TABLE students
(
    id    Serial PRIMARY KEY,
    name  VARCHAR(200) NOT NULL,
    email text         NOT NULL
);

CREATE TABLE instructor
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(200) NOT NULL,
    email text         NOT NULL
);

CREATE TABLE enrollments
(
    course_id   INT NOT NULL,
    student_id  INT NOT NULL,
    enrolled_at DATE,

    PRIMARY KEY (course_id, student_id),

    FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE
);

CREATE TABLE quiz
(
    id        SERIAL PRIMARY KEY,
    course_id INT NOT NULL,
    score     DECIMAL,

    FOREIGN KEY (course_id) REFERENCES courses (id) ON DELETE CASCADE
);

CREATE TABLE question
(
    id       SERIAL PRIMARY KEY,
    quiz_id  INT  NOT NULL,
    question TEXT NOT NULL,
    points   DECIMAL,

    FOREIGN KEY (quiz_id) REFERENCES quiz (id) ON DELETE CASCADE
);

CREATE TABLE choice
(
    id          SERIAL PRIMARY KEY,
    question_id INT  NOT NULL,
    choice_text TEXT NOT NULL,
    is_correct  BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (question_id) REFERENCES question (id) ON DELETE CASCADE
);

CREATE TABLE attempt
(
    id         SERIAL PRIMARY KEY,
    quiz_id    INT NOT NULL,
    student_id INT NOT NULL,
    taken_at   DATE,
    total      DECIMAL,

    UNIQUE (quiz_id, student_id),

    FOREIGN KEY (quiz_id) REFERENCES quiz (id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE
);

CREATE TABLE answer
(
    id              SERIAL PRIMARY KEY,
    attempt_id      INT NOT NULL,
    question_id     INT NOT NULL,
    selected_option TEXT,

    FOREIGN KEY (attempt_id)
        REFERENCES attempt (id)
        ON DELETE CASCADE,

    FOREIGN KEY (question_id)
        REFERENCES question (id)
        ON DELETE CASCADE
);

CREATE TABLE course_instructor
(
    course_id     INT NOT NULL,
    instructor_id INT NOT NULL,

    PRIMARY KEY (course_id, instructor_id),

    FOREIGN KEY (course_id)
        REFERENCES courses (id)
        ON DELETE CASCADE,

    FOREIGN KEY (instructor_id)
        REFERENCES instructor (id)
        ON DELETE CASCADE
);


-- populating
-- courses
INSERT INTO courses (name, credits)
VALUES ('Introduction to Python', 3),
       ('Web Development Basics', 3),
       ('Database Design', 4),
       ('Data Structures', 3);

-- students
INSERT INTO students (name, email)
VALUES ('Alice Johnson', 'alice@email.com'),
       ('Bob Smith', 'bob@email.com'),
       ('Carol White', 'carol@email.com'),
       ('Dave Brown', 'dave@email.com');
INSERT INTO students (name, email)
VALUES ('Noor', 'noor@email.com');

-- instructors
INSERT INTO instructor (name, email)
VALUES ('Dr. Sarah Connor', 'sarah@platform.com'),
       ('Prof. John Wick', 'john@platform.com'),
       ('Dr. Maya Patel', 'maya@platform.com');

-- course_instructor
INSERT INTO course_instructor (course_id, instructor_id)
VALUES (1, 1),
       (2, 1),
       (2, 2),
       (3, 3),
       (4, 2);

-- enrollments
INSERT INTO enrollments (course_id, student_id, enrolled_at)
VALUES (1, 1, '2024-01-10'),
       (1, 2, '2024-01-11'),
       (2, 2, '2024-01-12'),
       (2, 3, '2024-01-13'),
       (3, 1, '2024-01-14'),
       (3, 4, '2024-01-15'),
       (4, 3, '2024-01-16');

-- quiz
INSERT INTO quiz (course_id, score)
VALUES (1, 100),
       (1, 50),
       (2, 100),
       (3, 80);

-- question
INSERT INTO question (quiz_id, question, points)
VALUES (1, 'What is Python?', 25),
       (1, 'What is a variable?', 25),
       (1, 'What is a loop?', 25),
       (1, 'What is a function?', 25),
       (2, 'What is HTML?', 25),
       (2, 'What is CSS?', 25);

-- choice
INSERT INTO choice (question_id, choice_text, is_correct)
VALUES (1, 'A snake', false),
       (1, 'A programming language', true),
       (1, 'A database', false),
       (1, 'An operating system', false),
       (2, 'A container for storing data', true),
       (2, 'A type of loop', false),
       (2, 'A function', false),
       (2, 'A class', false),
       (3, 'A repeating block of code', true),
       (3, 'A variable', false),
       (3, 'A data type', false),
       (3, 'A module', false),
       (4, 'A reusable block of code', true),
       (4, 'A loop', false),
       (4, 'A variable', false),
       (4, 'A database', false),
       (5, 'HyperText Markup Language', true),
       (5, 'A styling language', false),
       (5, 'A programming language', false),
       (5, 'A database query language', false),
       (6, 'Cascading Style Sheets', true),
       (6, 'A markup language', false),
       (6, 'A scripting language', false),
       (6, 'A database language', false);

-- attempt
INSERT INTO attempt (quiz_id, student_id, taken_at, total)
VALUES (1, 1, '2024-02-01', 75),
       (1, 2, '2024-02-02', 100),
       (2, 1, '2024-02-03', 50),
       (3, 2, '2024-02-04', 80),
       (3, 3, '2024-02-05', 60);

INSERT INTO attempt (quiz_id, student_id, taken_at, total)
VALUES (1, 3, '2024-02-01', 75);

INSERT INTO attempt (quiz_id, student_id, taken_at, total)
VALUES (1, 4, '2024-02-01', 65);
-- UPDATE attempt SET total = 65 WHERE quiz_id = 1 AND student_id = 4;


-- answer
INSERT INTO answer (attempt_id, question_id, selected_option)
VALUES (1, 1, 'A programming language'),
       (1, 2, 'A container for storing data'),
       (1, 3, 'A variable'),
       (1, 4, 'A reusable block of code'),
       (2, 1, 'A programming language'),
       (2, 2, 'A container for storing data'),
       (2, 3, 'A repeating block of code'),
       (2, 4, 'A reusable block of code'),
       (3, 5, 'HyperText Markup Language'),
       (3, 6, 'Cascading Style Sheets');


-- Queries
SELECT *
FROM courses;
SELECT *
FROM students;
SELECT *
FROM instructor;
SELECT *
FROM enrollments;
SELECT *
FROM quiz;
SELECT *
FROM question;
SELECT *
FROM choice;
SELECT *
FROM attempt;
SELECT *
FROM answer;
SELECT *
FROM course_instructor;

-- number of students enrolled in each course
SELECT c.name, COUNT(*)
FROM students s
         JOIN enrollments e ON e.student_id = s.id
         JOIN courses c ON c.id = e.course_id
group by c.name;

SELECT a.student_id,
       s.name,
       a.quiz_id,
       a.total,
       RANK() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC)
FROM attempt a
         JOIN Students s ON s.id = a.student_id
;

SELECT a.student_id,
       s.name,
       a.quiz_id,
       a.total,
       DENSE_RANK() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC)
FROM attempt a
         JOIN Students s ON s.id = a.student_id
;

SELECT a.student_id,
       s.name,
       a.quiz_id,
       a.total,
       RANK() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC)       AS rank,
       DENSE_RANK() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC) AS dense_rank,
       ROW_NUMBER() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC) AS row_num
FROM attempt a
         JOIN Students s ON s.id = a.student_id
;


SELECT a.student_id,
       s.name,
       a.quiz_id,
       a.total,
       AVG(a.total) OVER (PARTITION BY a.quiz_id) AS avg_score,   --Aggregate as window
       RANK() OVER (PARTITION BY a.quiz_id ORDER BY a.total DESC) -- if there was a tie, it would skip the number after
FROM attempt a
         JOIN Students s ON s.id = a.student_id
;

SELECT s.id, s.name, e.course_id
FROM students s
         Left JOIN enrollments e ON e.student_id = s.id;

SELECT *
FROM attempt
ORDER BY student_id, quiz_id;

-- attempt scores
SELECT s.id, s.name, q.id, q.score, a.total
FROM students s
         JOIN attempt a ON a.student_id = s.id
         JOIN quiz q ON q.id = a.quiz_id;

SELECT c.name AS course, i.name AS instructor
FROM courses c
         JOIN course_instructor ci ON ci.course_id = c.id
         JOIN instructor i ON i.id = ci.instructor_id;