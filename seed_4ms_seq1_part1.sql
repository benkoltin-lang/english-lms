-- ============================================
-- 4MS Sequence 01 - PART 1: Lessons 01, 02, 03
-- نفّذ في: Supabase → SQL Editor → New Query → Run
-- ============================================

-- حذف القديم أولاً
DELETE FROM questions WHERE lesson_id IN (
  SELECT id FROM lessons WHERE level = '4MS' AND sequence = 'Sequence 01: Me, Universal Landmarks, and Outstanding Figures'
);
DELETE FROM lessons WHERE level = '4MS' AND sequence = 'Sequence 01: Me, Universal Landmarks, and Outstanding Figures';

-- ============================================
-- LESSON 01: Listen and Do 01 - Sightseeing Tour in London
-- ============================================
WITH l1 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Listen and Do 01 - Sightseeing Tour in London',
    '📍 A group of Algerian middle school students are visiting London.
They are riding an open-top double-decker bus.
Their English tourist guide is showing them London''s most famous landmarks.

🏛️ The Houses of Parliament:
- Located in the city of Westminster, London.
- Originally built in the 11th century.
- On 16th October 1834, most of the building was destroyed by a fire.
- UNESCO designated the building as a World Heritage Site.',
    '',
    '[]'::jsonb,
    1,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'listening', 'easy', 'multiple-choice',
  'Where are the Algerian students visiting?',
  2, true,
  '{"options":["Paris","London","Rome","Madrid"],"answer":"London"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'easy', 'multiple-choice',
  'What are the students riding?',
  2, true,
  '{"options":["A train","A boat","A double-decker bus","A taxi"],"answer":"A double-decker bus"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'easy', 'true-false',
  'The Houses of Parliament are located in Westminster.',
  2, true,
  '{"answer":true}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'medium', 'true-false',
  'The Houses of Parliament were destroyed by an earthquake.',
  2, true,
  '{"answer":false}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'easy', 'fill-blank',
  'The Houses of Parliament were originally built in the ___ century.',
  2, true,
  '{"answer":"11th"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'Most of the building was destroyed by a ___ on 16th October 1834.',
  2, true,
  '{"answer":"fire"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'UNESCO designated the Houses of Parliament as a World ___ Site.',
  2, true,
  '{"answer":"Heritage"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'medium', 'multiple-choice',
  'What does UNESCO do for the Houses of Parliament?',
  2, true,
  '{"options":["Destroys it","Designates it as a World Heritage Site","Rebuilds it","Sells it"],"answer":"Designates it as a World Heritage Site"}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'hard', 'reordering',
  'رتب الكلمات لتكوين جملة صحيحة:',
  3, true,
  '{"tokens":["The students","are riding","a double-decker bus","in London"],"correctOrder":["The students","are riding","a double-decker bus","in London"]}'::jsonb
FROM l1
UNION ALL
SELECT id, 'listening', 'medium', 'matching',
  'صِل كل مكان بوصفه:',
  3, true,
  '{"pairs":[
    {"left":"Houses of Parliament","right":"World Heritage Site"},
    {"left":"Westminster","right":"City in London"},
    {"left":"Double-decker bus","right":"Open-top vehicle"},
    {"left":"Tourist guide","right":"Shows landmarks"}
  ]}'::jsonb
FROM l1;

-- ============================================
-- LESSON 02: I Practise 01 - Simple Past + Passive Voice
-- ============================================
WITH l2 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Practise 01 - Simple Past & Passive Voice',
    '✅ Simple Past:
• Regular: verb + ed → visited / travelled / constructed
• Irregular: go→went / write→wrote / build→built / see→saw
• Negative: did not + base verb
• Question: Did + subject + base verb?

✅ Passive Voice:
• Active: Subject + verb + object
  → Gustave Eiffel designed the Eiffel Tower.
• Passive: Object + was/were + past participle + by + subject
  → The Eiffel Tower was designed by Gustave Eiffel.

📌 Pronoun Reference:
I→me / We→us / They→them / He→him / She→her',
    '',
    '[]'::jsonb,
    2,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'Guernica ___ by Pablo Picasso in 1937.',
  2, true,
  '{"options":["was painted","painted","is painting","paints"],"answer":"was painted"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'The Romans ___ Timgad in Algeria.',
  2, true,
  '{"options":["founded","was founded","were founded","is founded"],"answer":"founded"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Timgad ___ by the Romans.',
  2, true,
  '{"options":["was founded","founded","is founded","were founded"],"answer":"was founded"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Romeo and Juliet ___ by Shakespeare.',
  2, true,
  '{"options":["was written","wrote","is written","write"],"answer":"was written"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  'The Eiffel Tower ___ (design) by Gustave Eiffel.',
  2, true,
  '{"answer":"was designed"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  'Makam El Chahid ___ (construct) by Canadians.',
  2, true,
  '{"answer":"was constructed"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'The students ___ (visit) London last year.',
  2, true,
  '{"answer":"visited"}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'Passive voice: Object + was/were + past participle + by + subject.',
  2, true,
  '{"answer":true}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'The past of "go" is "goed".',
  2, true,
  '{"answer":false}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'hard', 'reordering',
  'رتب لتكوين جملة بالمبني للمجهول:',
  3, true,
  '{"tokens":["The mosque","was built","by","the Romans","in 146 BC"],"correctOrder":["The mosque","was built","by","the Romans","in 146 BC"]}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الفعل بتصريفه في الماضي:',
  3, true,
  '{"pairs":[
    {"left":"go","right":"went"},
    {"left":"write","right":"wrote"},
    {"left":"build","right":"built"},
    {"left":"see","right":"saw"}
  ]}'::jsonb
FROM l2
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الضمير بمفعوله:',
  3, true,
  '{"pairs":[
    {"left":"I","right":"me"},
    {"left":"We","right":"us"},
    {"left":"He","right":"him"},
    {"left":"They","right":"them"}
  ]}'::jsonb
FROM l2;

-- ============================================
-- LESSON 03: Listen and Do 02 - Big Ben
-- ============================================
WITH l3 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Listen and Do 02 - Big Ben',
    '🕰️ Big Ben - London:
- Big Ben is a famous landmark located in London.
- "Big Ben" is the name of the massive bell inside the clock tower.
- Designed by: Edmund Beckett Denison and Edward Dent.
- First chime: 11th July 1859.
- First BBC broadcast: 1932.
- Weight: 13.5 tons
- Height: 96 metres
- Diameter: 27 metres
- Hammer weight: 200 kilos',
    '',
    '[]'::jsonb,
    3,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'listening', 'easy', 'multiple-choice',
  'Where is Big Ben located?',
  2, true,
  '{"options":["Paris","London","Rome","New York"],"answer":"London"}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'medium', 'multiple-choice',
  'What is "Big Ben" actually?',
  2, true,
  '{"options":["The clock tower","The massive bell inside the tower","A famous boxer","A BBC programme"],"answer":"The massive bell inside the tower"}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'easy', 'true-false',
  'Big Ben is not a famous landmark in London.',
  2, true,
  '{"answer":false}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'medium', 'true-false',
  'Big Ben chimed for the first time on 11th July 1859.',
  2, true,
  '{"answer":true}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'easy', 'fill-blank',
  'Big Ben weighs ___ tons.',
  2, true,
  '{"answer":"13.5"}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'Big Ben was designed by Edmund Beckett Denison and Edward ___.',
  2, true,
  '{"answer":"Dent"}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'The first BBC broadcast of Big Ben was in ___.',
  2, true,
  '{"answer":"1932"}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'hard', 'reordering',
  'رتب الكلمات لتكوين جملة صحيحة:',
  3, true,
  '{"tokens":["Big Ben","was designed","by","Edmund Beckett Denison","and Edward Dent"],"correctOrder":["Big Ben","was designed","by","Edmund Beckett Denison","and Edward Dent"]}'::jsonb
FROM l3
UNION ALL
SELECT id, 'listening', 'medium', 'matching',
  'صِل كل معلومة بقيمتها:',
  3, true,
  '{"pairs":[
    {"left":"Weight","right":"13.5 tons"},
    {"left":"Height","right":"96 metres"},
    {"left":"Diameter","right":"27 metres"},
    {"left":"First chime","right":"11th July 1859"}
  ]}'::jsonb
FROM l3;
