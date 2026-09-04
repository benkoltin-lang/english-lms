-- ============================================
-- 4MS Sequence 01 - PART 3: Lessons 07, 08, 09
-- نفّذ في: Supabase → SQL Editor → New Query → Run
-- ============================================

-- ============================================
-- LESSON 07: Listen and Do 04 - Nabila's Cruise + Picasso
-- ============================================
WITH l7 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Listen and Do 04 - Nabila''s Cruise & Pablo Picasso',
    '🚢 Nabila''s Mediterranean Cruise:
First, Nabila took a taxi from Mascara to Oran.
Then, she sailed from Oran to Alicante on a cruise ship.
Next, she visited Marseille.
After that, she sailed to Hammamet with a stopover on Djerba Island.
Finally, she returned to Oran.

🎨 Pablo Picasso ID Card:
- First name: Pablo / Family name: Picasso
- Date of birth: 25th October 1881
- Place of birth: Malaga, Spain
- Nationality: Spanish
- Occupation: Painter
- Date of death: 1973 / Place of death: France
- Famous painting: Guernica

📌 Sequence Connectors:
First / Then / Next / After that / Finally',
    '',
    '[]'::jsonb,
    7,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'listening', 'easy', 'multiple-choice',
  'Where was Picasso born?',
  2, true,
  '{"options":["Malaga","Paris","London","Rome"],"answer":"Malaga"}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'easy', 'multiple-choice',
  'What is Picasso''s famous painting?',
  2, true,
  '{"options":["Guernica","Mona Lisa","The Starry Night","The Scream"],"answer":"Guernica"}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'easy', 'true-false',
  'Nabila sailed from Oran to Alicante.',
  2, true,
  '{"answer":true}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'medium', 'true-false',
  'Nabila''s cruise was boring.',
  2, true,
  '{"answer":false}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'easy', 'fill-blank',
  'Picasso was born on 25th October ___.',
  2, true,
  '{"answer":"1881"}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'Nabila visited ___ after Alicante.',
  2, true,
  '{"answer":"Marseille"}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'easy', 'fill-blank',
  'Picasso''s nationality is ___.',
  2, true,
  '{"answer":"Spanish"}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'hard', 'reordering',
  'رتب محطات رحلة نبيلة بالترتيب الصحيح:',
  4, true,
  '{"tokens":["Mascara","Oran","Alicante","Marseille","Hammamet","Oran"],"correctOrder":["Mascara","Oran","Alicante","Marseille","Hammamet","Oran"]}'::jsonb
FROM l7
UNION ALL
SELECT id, 'listening', 'medium', 'matching',
  'صِل معلومات Picasso:',
  3, true,
  '{"pairs":[
    {"left":"Place of birth","right":"Malaga"},
    {"left":"Nationality","right":"Spanish"},
    {"left":"Occupation","right":"Painter"},
    {"left":"Famous painting","right":"Guernica"}
  ]}'::jsonb
FROM l7;

-- ============================================
-- LESSON 08: I Practise 04 - Sequence Connectors
-- ============================================
WITH l8 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Practise 04 - Sequence Connectors & Trip Itinerary',
    '📌 Sequence Connectors (روابط التسلسل):

1️⃣ First → أولاً
2️⃣ Then → ثم
3️⃣ Next → بعد ذلك
4️⃣ After that → بعدها
5️⃣ Finally → أخيراً

✍️ Example:
First, I took a taxi from Mascara to Oran.
Then, I sailed from Oran to Alicante.
Next, I visited Marseille.
After that, I sailed to Hammamet.
Finally, I returned to Oran.',
    '',
    '[]'::jsonb,
    8,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'What connector do we use to start a sequence?',
  2, true,
  '{"options":["First","Finally","After that","Then"],"answer":"First"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'What connector do we use to end a sequence?',
  2, true,
  '{"options":["Finally","First","Then","Next"],"answer":"Finally"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  '___, I visited Marseille. ___, I sailed to Hammamet.',
  2, true,
  '{"options":["Next / After that","Finally / First","First / Finally","After that / Then"],"answer":"Next / After that"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '___, I took a taxi from Mascara to Oran. (الرابط الأول)',
  2, true,
  '{"answer":"First"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '___, I returned home after a fabulous trip. (الرابط الأخير)',
  2, true,
  '{"answer":"Finally"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'First, I visited Algiers. ___, I went to Oran.',
  2, true,
  '{"answer":"Then"}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'medium', 'true-false',
  'Sequence connectors help us order events in a trip.',
  2, true,
  '{"answer":true}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'hard', 'reordering',
  'رتب الجمل بالترتيب الصحيح للرحلة:',
  4, true,
  '{"tokens":["First, I packed my bags.","Then, I took a bus to Oran.","After that, I boarded the ship.","Finally, I arrived in Spain."],"correctOrder":["First, I packed my bags.","Then, I took a bus to Oran.","After that, I boarded the ship.","Finally, I arrived in Spain."]}'::jsonb
FROM l8
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الرابط بمعناه:',
  3, true,
  '{"pairs":[
    {"left":"First","right":"أولاً"},
    {"left":"Then","right":"ثم"},
    {"left":"After that","right":"بعدها"},
    {"left":"Finally","right":"أخيراً"}
  ]}'::jsonb
FROM l8;

-- ============================================
-- LESSON 09: I Read and Do - Great Mosque + Burj Khalifa
-- ============================================
WITH l9 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Read and Do - The Great Mosque of Algiers & Burj Khalifa',
    '🕌 The Great Mosque of Algiers:
- Located in Algiers, Algeria.
- Third biggest mosque in the world.
- Construction: August 2012 → April 2019.
- Cost: 898 million Euros.
- Designed by: German architect KSP Jurgen Engel Architekten.
- Constructed by: a Chinese company.
- Minaret: 265 metres (world''s tallest minaret).
- Capacity: 120,000 worshippers.
- Opened: 28th October 2020.

🏙️ Burj Khalifa - Dubai:
- Location: Dubai, UAE.
- Construction started: 6 January 2004.
- Completed: 1 October 2009.
- Height: 829.8 metres.
- Architect: Adrian Smith.',
    '',
    '[]'::jsonb,
    9,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'reading', 'easy', 'multiple-choice',
  'Where is the Great Mosque of Algiers located?',
  2, true,
  '{"options":["Oran","Algiers","Constantine","Tlemcen"],"answer":"Algiers"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'multiple-choice',
  'The Great Mosque of Algiers is the ___ biggest mosque in the world.',
  2, true,
  '{"options":["first","second","third","fourth"],"answer":"third"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'easy', 'true-false',
  'The Great Mosque was designed by a German architect.',
  2, true,
  '{"answer":true}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'true-false',
  'The minaret of the Great Mosque is 200 metres high.',
  2, true,
  '{"answer":false}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'easy', 'fill-blank',
  'The Great Mosque was constructed by a ___ company.',
  2, true,
  '{"answer":"Chinese"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'fill-blank',
  'The minaret of the Great Mosque is ___ metres high.',
  2, true,
  '{"answer":"265"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'easy', 'fill-blank',
  'Burj Khalifa is located in ___, UAE.',
  2, true,
  '{"answer":"Dubai"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'fill-blank',
  'Burj Khalifa was designed by architect ___ Smith.',
  2, true,
  '{"answer":"Adrian"}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'matching',
  'صِل كل معلومة بالمعلم الصحيح:',
  3, true,
  '{"pairs":[
    {"left":"265m minaret","right":"Great Mosque of Algiers"},
    {"left":"829.8m height","right":"Burj Khalifa"},
    {"left":"German architect","right":"Great Mosque of Algiers"},
    {"left":"Adrian Smith","right":"Burj Khalifa"}
  ]}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'medium', 'matching',
  'صِل الكلمة بمرادفها:',
  3, true,
  '{"pairs":[
    {"left":"located","right":"situated"},
    {"left":"construct","right":"build"},
    {"left":"outstanding","right":"famous"},
    {"left":"enormous","right":"very big"}
  ]}'::jsonb
FROM l9
UNION ALL
SELECT id, 'reading', 'hard', 'reordering',
  'رتب الكلمات لتكوين جملة صحيحة:',
  3, true,
  '{"tokens":["The Great Mosque","was designed","by","a German architect"],"correctOrder":["The Great Mosque","was designed","by","a German architect"]}'::jsonb
FROM l9;
