-- ============================================
-- 4MS Sequence 01 - PART 2: Lessons 04, 05, 06
-- نفّذ في: Supabase → SQL Editor → New Query → Run
-- ============================================

-- ============================================
-- LESSON 04: I Practise 02 - Comparatives
-- ============================================
WITH l4 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Practise 02 - Comparatives (Equality / Inferiority / Superiority)',
    '✅ Comparative of Equality (المساواة):
as + adjective + as
→ The Eiffel Tower is as famous as Big Ben.

✅ Comparative of Inferiority (الأدنى):
not as + adjective + as
→ Eiffel Tower is not as high as Burj Khalifa.

✅ Comparative of Superiority (التفوق):
• Short adj: adj + er + than
  → Pisa Tower is older than Tower Bridge.
• Long adj: more + adj + than
  → Pisa Tower is more beautiful than Tower Bridge.
• Irregular:
  good→better / bad→worse / many→more / little→less / far→farther',
    '',
    '[]'::jsonb,
    4,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'The Eiffel Tower is ___ famous ___ Big Ben. (equality)',
  2, true,
  '{"options":["as / as","more / than","not as / as","less / than"],"answer":"as / as"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'Eiffel Tower (300m) is ___ high ___ Burj Khalifa (828m). (inferiority)',
  2, true,
  '{"options":["not as / as","as / as","more / than","most / of"],"answer":"not as / as"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'Pisa Tower is ___ (old) than Tower Bridge.',
  2, true,
  '{"options":["older","more old","oldest","old"],"answer":"older"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Pisa Tower is ___ (beautiful) than Tower Bridge.',
  2, true,
  '{"options":["more beautiful","beautifuler","most beautiful","beautifuller"],"answer":"more beautiful"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'This painting is ___ (good) than that one.',
  2, true,
  '{"options":["better","gooder","more good","best"],"answer":"better"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'Windsor Castle (50,000m²) is ___ large ___ Buckingham Palace (73,000m²).',
  2, true,
  '{"answer":"not as / as"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'Burj Khalifa is ___ (tall) than the Eiffel Tower.',
  2, true,
  '{"answer":"taller"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'hard', 'fill-blank',
  'The Great Mosque of Algiers is ___ (impressive) than the old mosque.',
  2, true,
  '{"answer":"more impressive"}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'medium', 'true-false',
  'For long adjectives we use: more + adjective + than.',
  2, true,
  '{"answer":true}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'The comparative of "good" is "gooder".',
  2, true,
  '{"answer":false}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'hard', 'reordering',
  'رتب لتكوين جملة مقارنة صحيحة:',
  3, true,
  '{"tokens":["The Houses of Parliament","is","as spectacular","as","Buckingham Palace"],"correctOrder":["The Houses of Parliament","is","as spectacular","as","Buckingham Palace"]}'::jsonb
FROM l4
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الصفة بصيغة المقارنة الصحيحة:',
  3, true,
  '{"pairs":[
    {"left":"good","right":"better"},
    {"left":"bad","right":"worse"},
    {"left":"many","right":"more"},
    {"left":"far","right":"farther"}
  ]}'::jsonb
FROM l4;

-- ============================================
-- LESSON 05: Listen and Do 03 - Outstanding Figures / Shakespeare
-- ============================================
WITH l5 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Listen and Do 03 - Famous Outstanding Figures',
    '👤 Biography:
A biography is a true story of a famous person''s life written in chronological order.

📋 Biography includes:
Name / Nationality / Date & Place of Birth /
Occupation / Achievements / Family / Education /
Date & Place of Death

🎭 William Shakespeare:
- Date of birth: 23rd April 1564
- Place of birth: Stratford-upon-Avon
- Nationality: English
- Occupation: Actor, playwright and poet
- Famous plays: Romeo and Juliet / Hamlet
- Theatre: The Globe Theatre
- Date of death: 26th April 1616

📌 Relative Pronouns:
• who → for people
• which → for things/places',
    '',
    '[]'::jsonb,
    5,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'listening', 'easy', 'multiple-choice',
  'When was Shakespeare born?',
  2, true,
  '{"options":["23rd April 1564","26th April 1616","23rd April 1616","26th April 1564"],"answer":"23rd April 1564"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'easy', 'multiple-choice',
  'What was Shakespeare''s occupation?',
  2, true,
  '{"options":["Painter and sculptor","Actor, playwright and poet","Scientist and inventor","Writer and politician"],"answer":"Actor, playwright and poet"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'easy', 'true-false',
  'Shakespeare was born in Stratford-upon-Avon.',
  2, true,
  '{"answer":true}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'true-false',
  'Shakespeare built his own theatre called The Royal Theatre.',
  2, true,
  '{"answer":false}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'true-false',
  'A biography is written in chronological order.',
  2, true,
  '{"answer":true}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'easy', 'fill-blank',
  'Shakespeare''s famous play is "___ and Juliet".',
  2, true,
  '{"answer":"Romeo"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'We use "___ " for people in relative clauses.',
  2, true,
  '{"answer":"who"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'fill-blank',
  'We use "___ " for things and places in relative clauses.',
  2, true,
  '{"answer":"which"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'hard', 'reordering',
  'رتب لتكوين جملة صحيحة:',
  3, true,
  '{"tokens":["William Shakespeare","was","an actor","who","wrote","famous plays"],"correctOrder":["William Shakespeare","was","an actor","who","wrote","famous plays"]}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'matching',
  'صِل كل معلومة بقيمتها (Shakespeare):',
  3, true,
  '{"pairs":[
    {"left":"Date of birth","right":"23rd April 1564"},
    {"left":"Place of birth","right":"Stratford-upon-Avon"},
    {"left":"Nationality","right":"English"},
    {"left":"Date of death","right":"26th April 1616"}
  ]}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'multiple-choice',
  'Ibn al-Haythem was a famous Muslim scientist ___ was born in El Basra, Iraq.',
  2, true,
  '{"options":["who","which","where","whose"],"answer":"who"}'::jsonb
FROM l5
UNION ALL
SELECT id, 'listening', 'medium', 'multiple-choice',
  'The Globe Theatre is a famous place ___ Shakespeare built.',
  2, true,
  '{"options":["which","who","where","whose"],"answer":"which"}'::jsonb
FROM l5;

-- ============================================
-- LESSON 06: I Practise 03 - Cause & Consequence + Qualifiers
-- ============================================
WITH l6 AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'I Practise 03 - Cause & Consequence + Qualifiers & Strong Adjectives',
    '✅ Expressing Cause (السبب):
because / as / since
→ Larbi Ben M''hidi was killed because he refused to surrender.

✅ Expressing Consequence (النتيجة):
so / as a result / therefore
→ He refused to surrender, so he was killed.

✅ Qualifiers:
• Absolutely / Extremely → قوي جداً
• Very / So / Really → قوي
• Somehow / A bit → ضعيف

✅ Strong Adjectives:
cold→freezing / tired→exhausted
hungry→starving / beautiful→gorgeous
small→tiny / big→enormous',
    '',
    '[]'::jsonb,
    6,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'I decided to stay at home ___ the weather was awful.',
  2, true,
  '{"options":["because","so","therefore","as a result"],"answer":"because"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'multiple-choice',
  'She prepared for the test, ___ she got an excellent mark.',
  2, true,
  '{"options":["so","because","since","as"],"answer":"so"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'I wanted to see Big Ben. ___, I went to London.',
  2, true,
  '{"options":["Therefore","Because","Since","As"],"answer":"Therefore"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Larbi Ben M''hidi refused to surrender. ___, he was killed.',
  2, true,
  '{"options":["As a result","Because","Since","As"],"answer":"As a result"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '"Tired" → strong adjective: ___',
  2, true,
  '{"answer":"exhausted"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '"Cold" → strong adjective: ___',
  2, true,
  '{"answer":"freezing"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '"Hungry" → strong adjective: ___',
  2, true,
  '{"answer":"starving"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  '"Beautiful" → strong adjective: ___',
  2, true,
  '{"answer":"gorgeous"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'Burj Khalifa is an ___ high tower. (qualifier قوي جداً)',
  2, true,
  '{"answer":"extremely"}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  '"Because" expresses the cause (reason).',
  2, true,
  '{"answer":true}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'true-false',
  '"Therefore" expresses the cause.',
  2, true,
  '{"answer":false}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'hard', 'reordering',
  'رتب لتكوين جملة صحيحة:',
  3, true,
  '{"tokens":["Nadia","was a fan","of Picasso","therefore","she went","to his house"],"correctOrder":["Nadia","was a fan","of Picasso","therefore","she went","to his house"]}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'matching',
  'صِل الصفة العادية بالصفة القوية:',
  3, true,
  '{"pairs":[
    {"left":"cold","right":"freezing"},
    {"left":"tired","right":"exhausted"},
    {"left":"hungry","right":"starving"},
    {"left":"small","right":"tiny"}
  ]}'::jsonb
FROM l6
UNION ALL
SELECT id, 'practice', 'medium', 'classification',
  'صنّف حسب نوعه (cause / consequence):',
  3, true,
  '{"categories":["Cause","Consequence"],"items":[
    {"word":"because","category":"Cause"},
    {"word":"since","category":"Cause"},
    {"word":"as","category":"Cause"},
    {"word":"so","category":"Consequence"},
    {"word":"therefore","category":"Consequence"},
    {"word":"as a result","category":"Consequence"}
  ]}'::jsonb
FROM l6;
