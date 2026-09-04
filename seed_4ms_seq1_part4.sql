-- ============================================
-- 4MS Sequence 01 - PART 4: Lessons 10, 11
-- نفّذ في: Supabase → SQL Editor → New Query → Run
-- ============================================

-- ============================================
-- LESSON 10: Phonetics - Diphthongs /eɪ/ and /aɪ/
-- ============================================
WITH l10 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Phonetics - Diphthongs /eɪ/ and /aɪ/',
    '🔊 Diphthongs (الأصوات المركبة):
مزيج من صوتين متتاليين في نفس المقطع.

📌 /eɪ/ → مثل: say / stay / name
كلمات: famous / name / great / amazing / later
made / located / weight / eight / day / train

📌 /aɪ/ → مثل: like / my / high
كلمات: life / writer / like / height / high
island / guide / sight / time / fly / mine',
    '',
    '[]'::jsonb,
    10,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'The word "name" contains which diphthong?',
  2, true,
  '{"options":["/eɪ/","/aɪ/","/ɔɪ/","/aʊ/"],"answer":"/eɪ/"}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'The word "height" contains which diphthong?',
  2, true,
  '{"options":["/aɪ/","/eɪ/","/ɔɪ/","/aʊ/"],"answer":"/aɪ/"}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'The word "guide" contains the /aɪ/ sound.',
  2, true,
  '{"answer":true}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'The word "great" contains the /aɪ/ sound.',
  2, true,
  '{"answer":false}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'medium', 'true-false',
  'The word "amazing" contains the /eɪ/ sound.',
  2, true,
  '{"answer":true}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'hard', 'classification',
  'صنّف الكلمات حسب الصوت:',
  4, true,
  '{"categories":["/eɪ/ (name/say)","/aɪ/ (high/like)"],"items":[
    {"word":"famous","category":"/eɪ/ (name/say)"},
    {"word":"great","category":"/eɪ/ (name/say)"},
    {"word":"amazing","category":"/eɪ/ (name/say)"},
    {"word":"later","category":"/eɪ/ (name/say)"},
    {"word":"weight","category":"/eɪ/ (name/say)"},
    {"word":"made","category":"/eɪ/ (name/say)"},
    {"word":"height","category":"/aɪ/ (high/like)"},
    {"word":"life","category":"/aɪ/ (high/like)"},
    {"word":"guide","category":"/aɪ/ (high/like)"},
    {"word":"island","category":"/aɪ/ (high/like)"},
    {"word":"high","category":"/aɪ/ (high/like)"},
    {"word":"time","category":"/aɪ/ (high/like)"}
  ]}'::jsonb
FROM l10
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الكلمة بصوتها الصحيح:',
  3, true,
  '{"pairs":[
    {"left":"train","right":"/eɪ/"},
    {"left":"sight","right":"/aɪ/"},
    {"left":"day","right":"/eɪ/"},
    {"left":"mine","right":"/aɪ/"}
  ]}'::jsonb
FROM l10;

-- ============================================
-- LESSON 11: I Write + My First Term Project
-- ============================================
WITH l11 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Write - Landmark / Biography / Trip + My First Term Project',
    '✍️ 1. Famous Landmark Paragraph:
• Introduction: name + location
• Body: dimensions / date / architect
• Conclusion: importance

Example:
Big Ben is a famous landmark located in London.
It was designed by Edmund Beckett Denison and Edward Dent.
It chimed for the first time on 11th July 1859.
Big Ben is a spectacular landmark which lots of tourists visit each year.

✍️ 2. Biography Paragraph:
• Introduction: name + field
• Body: birth / achievements
• Conclusion: death / legacy

Example:
William Shakespeare was a famous English poet and playwright.
He was born on 23rd April 1564 in Stratford-upon-Avon.
He wrote Romeo and Juliet and Hamlet.
He died on 26th April 1616.

✍️ 3. Trip Itinerary:
Use: First / Then / Next / After that / Finally

📁 My First Term Project:
Last summer, you went on a trip around Algeria.
Write your itinerary including landmarks and figures you visited.',
    '',
    '[]'::jsonb,
    11,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'writing', 'medium', 'multiple-choice',
  'A biography is written in ___ order.',
  2, true,
  '{"options":["chronological","alphabetical","random","reverse"],"answer":"chronological"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'easy', 'multiple-choice',
  'Which connector starts a trip itinerary?',
  2, true,
  '{"options":["First","Finally","After that","Next"],"answer":"First"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'multiple-choice',
  'A landmark paragraph must include:',
  2, true,
  '{"options":["Location + dimensions + importance","Only the name","Only the date","Random facts"],"answer":"Location + dimensions + importance"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'true-false',
  'A landmark paragraph includes: location, dimensions and importance.',
  2, true,
  '{"answer":true}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'true-false',
  'A biography can be written in any random order.',
  2, true,
  '{"answer":false}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'easy', 'fill-blank',
  'Big Ben is a famous landmark ___ in London. (located/built/designed)',
  2, true,
  '{"answer":"located"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'fill-blank',
  'Shakespeare ___ born on 23rd April 1564. (was/is/were)',
  2, true,
  '{"answer":"was"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'fill-blank',
  'First, I visited Algiers. ___, I went to Tlemcen.',
  2, true,
  '{"answer":"Then"}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'hard', 'reordering',
  'رتب جمل فقرة المعلم بالترتيب الصحيح:',
  4, true,
  '{"tokens":[
    "Big Ben is a famous landmark located in London.",
    "It was designed by Edmund Beckett Denison and Edward Dent.",
    "It chimed for the first time on 11th July 1859.",
    "Big Ben is a spectacular landmark which lots of tourists visit each year."
  ],"correctOrder":[
    "Big Ben is a famous landmark located in London.",
    "It was designed by Edmund Beckett Denison and Edward Dent.",
    "It chimed for the first time on 11th July 1859.",
    "Big Ben is a spectacular landmark which lots of tourists visit each year."
  ]}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'hard', 'reordering',
  'رتب جمل فقرة السيرة الذاتية بالترتيب الصحيح:',
  4, true,
  '{"tokens":[
    "William Shakespeare was a famous English poet and playwright.",
    "He was born on 23rd April 1564 in Stratford-upon-Avon.",
    "He wrote his best plays like Romeo and Juliet.",
    "He died on 26th April 1616."
  ],"correctOrder":[
    "William Shakespeare was a famous English poet and playwright.",
    "He was born on 23rd April 1564 in Stratford-upon-Avon.",
    "He wrote his best plays like Romeo and Juliet.",
    "He died on 26th April 1616."
  ]}'::jsonb
FROM l11
UNION ALL
SELECT id, 'writing', 'medium', 'matching',
  'صِل نوع الفقرة بعناصرها:',
  3, true,
  '{"pairs":[
    {"left":"Landmark paragraph","right":"Location + dimensions + importance"},
    {"left":"Biography paragraph","right":"Birth + achievements + death"},
    {"left":"Trip itinerary","right":"First + Then + Finally"}
  ]}'::jsonb
FROM l11;
