-- ============================================
-- Sequence 01 (4MS): Me, Universal Landmarks, and Outstanding Figures
-- درسان + 22 سؤالاً - نفّذ هذا كاملاً عبر: psql -f seed_4ms_seq1_combined.sql
-- ============================================

-- ============================================
-- Sequence 01 (4MS): Me, Universal Landmarks, and Outstanding Figures
-- نفّذ هذا في: Supabase Dashboard → SQL Editor → New Query → Run
-- ============================================

WITH new_lesson AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Qualifiers & The Comparative of Superiority',
    '✅ Qualifiers (المعدّلات):
كلمات تُوضع قبل الصفة (adjective) لتقليل أو تقوية معناها.
- للتقليل: a bit / quite / a little / kind of / sort of / just / slightly
- للتقوية: very / a lot / many / so / too / really / extremely / completely / totally / pretty
القاعدة: Qualifier + Adjective + Rest of the sentence
مثال: Granada is quite small, but the places are totally fascinating.

✅ The Comparative of Superiority (درجة التفوق في المقارنة):
- الصفات القصيرة (مقطع واحد): Adjective + -er + than
  مثال: The Ketchaoua Mosque is older than The Marty''s Monument.
- الصفات الطويلة (مقطعين فأكثر): more + Adjective + than
  مثال: The Eiffel Tower is more attractive than the old tower.

هذا الدرس يربط بين استعمال المعدّلات ودرجة المقارنة أثناء وصف معالم عالمية وجزائرية مشهورة وشخصيات بارزة.',
    '',
    '[]'::jsonb,
    1,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'easy', 'multiple-choice',
  'The Eiffel Tower is ___ (tall) than the Ketchaoua Mosque.', 2, true,
  '{"options":["taller","more tall","tallest","tall"],"answer":"taller"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'The Taj Mahal is ___ (beautiful) than the building we visited yesterday.', 2, true,
  '{"options":["more beautiful","beautifuller","most beautiful","beautiful"],"answer":"more beautiful"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  'El Tassili N''jer has ___ interesting ruins. (quite / so / many / very)', 2, true,
  '{"answer":"many"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'easy', 'fill-blank',
  'Ketchaoua Mosque is a ___ important Ottoman Heritage. (quite / so / many / very)', 2, true,
  '{"answer":"very"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'The city of Giza is ___ mysterious. (quite / so / many / very)', 2, true,
  '{"answer":"quite"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'medium', 'fill-blank',
  'I was ___ happy to visit the Alhambra Palace. (quite / so / many / very)', 2, true,
  '{"answer":"so"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'reordering',
  'رتب لتكوين جملة صحيحة (مقارنة تفوق)', 3, true,
  '{"tokens":["Big Ben","is","more attractive","than","The Marty''s Monument"],"correctOrder":["Big Ben","is","more attractive","than","The Marty''s Monument"]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'easy', 'true-false',
  'The Pyramids of Giza were built around 1560 BC.', 2, true,
  '{"answer":false}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'hard', 'classification',
  'صنّف الكلمات حسب النطق: /ei/ أو /ai/', 4, true,
  '{"categories":["/ei/","/ai/"],"items":[
     {"word":"train","category":"/ei/"},
     {"word":"day","category":"/ei/"},
     {"word":"plane","category":"/ei/"},
     {"word":"break","category":"/ei/"},
     {"word":"eight","category":"/ei/"},
     {"word":"climb","category":"/ai/"},
     {"word":"time","category":"/ai/"},
     {"word":"height","category":"/ai/"},
     {"word":"Nile","category":"/ai/"},
     {"word":"flight","category":"/ai/"},
     {"word":"sky","category":"/ai/"},
     {"word":"guide","category":"/ai/"}
   ]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'matching',
  'صِل كل معلم جزائري بمدينته', 3, true,
  '{"pairs":[
     {"left":"Casbah of Algiers","right":"Algiers"},
     {"left":"Djemila","right":"Sétif"},
     {"left":"Tassili n''Ajjer","right":"Illizi"},
     {"left":"Santa Cruz","right":"Oran"}
   ]}'::jsonb
FROM new_lesson;


-- ============================================
-- Sequence 01 (4MS) - الدفعة الثانية: Passive Voice + Comparative of Equality + مفردات
-- نفّذ هذا في: Supabase Dashboard → SQL Editor → New Query → Run
-- ============================================

WITH new_lesson AS (
  INSERT INTO lessons (level, term, sequence, title, content, video_url, images, order_num, is_active)
  VALUES (
    '4MS', 1,
    'Sequence 01: Me, Universal Landmarks, and Outstanding Figures',
    'Passive Voice & Comparative of Equality',
    '✅ Active / Passive Form:
- المبني للمعلوم: Subject + verb (past/present) + Object
  مثال: Gustave Eiffel designed the Eiffel Tower.
- المبني للمجهول: Object + was/were (is/are) + Past Participle + by + Subject
  مثال: The Eiffel Tower was designed by Gustave Eiffel.
نستعمل المبني للمجهول عندما يكون التركيز على الفعل والنتيجة أهم من الفاعل نفسه (مفيد جداً عند وصف المعالم التاريخية).

✅ Comparative of Equality / Inequality (المساواة وعدم المساواة):
- المساواة: Subject + verb + as + adjective + as
  مثال: This car is as fast as that motorbike.
- عدم المساواة: Subject + verb + not as + adjective + as
  مثال: This book is not as interesting as that documentary.

✅ مفردات مرتبطة بالمعالم والشخصيات البارزة:
مرادفات: outstanding = famous, construct = build, protect = save, situated = located
أضداد: was born ≠ died, first ≠ later, many ≠ few, arrival ≠ departure',
    '',
    '[]'::jsonb,
    2,
    true
  )
  RETURNING id
)
INSERT INTO questions (lesson_id, activity, difficulty, type, question_text, score, is_active, data)
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Guernica ___ by Pablo Picasso.', 2, true,
  '{"options":["was painted","painted","is painting","paints"],"answer":"was painted"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'medium', 'multiple-choice',
  'Big Ben ___ by Edmund Beckett Denison and Edward Dent.', 2, true,
  '{"options":["was designed","designed","designs","is designed"],"answer":"was designed"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'hard', 'reordering',
  'رتب لتكوين جملة صحيحة بالمبني للمجهول', 3, true,
  '{"tokens":["The tickets","were booked","by","Salim"],"correctOrder":["The tickets","were booked","by","Salim"]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'practice', 'easy', 'true-false',
  'The Statue of Liberty was built by a famous artist.', 2, true,
  '{"answer":true}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'fill-blank',
  'Chaima is 1.55 m / Razane is 1.55 m. (tall) → Chaima is ___ Razane. (اكتب فقط الأداة: as tall as)', 2, true,
  '{"answer":"as tall as"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'fill-blank',
  'Mona Lisa''s price is $100 million. Guernica''s price is $200 million. (expensive) → Mona Lisa is ___ Guernica. (اكتب الأداة الصحيحة)', 2, true,
  '{"answer":"not as expensive as"}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'matching',
  'صِل كل كلمة بمرادفها', 3, true,
  '{"pairs":[
     {"left":"outstanding","right":"famous"},
     {"left":"construct","right":"build"},
     {"left":"protect","right":"save"},
     {"left":"situated","right":"located"}
   ]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'matching',
  'صِل كل كلمة بضدها', 3, true,
  '{"pairs":[
     {"left":"was born","right":"died"},
     {"left":"first","right":"later"},
     {"left":"many","right":"few"},
     {"left":"arrival","right":"departure"}
   ]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'hard', 'classification',
  'صنّف الكلمات حسب صوت العلة المختلف', 4, true,
  '{"categories":["/eɪ/ (say/stay)","/aɪ/ (like/my)"],"items":[
     {"word":"pie","category":"/aɪ/ (like/my)"},
     {"word":"say","category":"/eɪ/ (say/stay)"},
     {"word":"pray","category":"/eɪ/ (say/stay)"},
     {"word":"sight","category":"/aɪ/ (like/my)"},
     {"word":"eyes","category":"/aɪ/ (like/my)"},
     {"word":"located","category":"/eɪ/ (say/stay)"},
     {"word":"weight","category":"/eɪ/ (say/stay)"},
     {"word":"height","category":"/aɪ/ (like/my)"},
     {"word":"mine","category":"/aɪ/ (like/my)"},
     {"word":"cry","category":"/aɪ/ (like/my)"},
     {"word":"play","category":"/eɪ/ (say/stay)"},
     {"word":"write","category":"/aɪ/ (like/my)"}
   ]}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'easy', 'true-false',
  'Mohammed Dib wrote stories only for kids.', 2, true,
  '{"answer":false}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'true-false',
  'Mohammed Dib was expelled from Algeria by the French authorities in 1959.', 2, true,
  '{"answer":true}'::jsonb
FROM new_lesson
UNION ALL
SELECT id, 'review', 'medium', 'fill-blank',
  'Emir Abdelkader was forced to surrender on 21 ___ 1847. (اكتب الشهر بالإنجليزية)', 2, true,
  '{"answer":"December"}'::jsonb
FROM new_lesson;
