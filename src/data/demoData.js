// بيانات تجريبية لتجربة النظام بالكامل دفعة واحدة (تلميذ + درس + 6 أنواع أسئلة + فرض)
// يمكن حذف هذا الملف بأمان عند الانتقال لإدخال المحتوى الحقيقي يدوياً
export function buildDemoData() {
  const today = new Date().toISOString().split('T')[0]
  const endDate = new Date()
  endDate.setFullYear(endDate.getFullYear() + 1)

  const student = {
    id: Date.now(),
    name: 'تلميذ تجريبي',
    username: 'test',
    password: '123',
    level: '3PS',
    currentTerm: 1,
    startDate: '2025-01-01',
    endDate: endDate.toISOString().split('T')[0],
    status: 'approved'
  }

  const lesson = {
    id: Date.now() + 1,
    level: '3PS',
    term: 1,
    sequence: 'Sequence 1',
    title: 'درس تجريبي - Greetings',
    content: 'هذا محتوى تجريبي للدرس.\nHello, my name is Ali.\nWhat is your name?',
    videoUrl: '',
    images: [],
    order: 1,
    isActive: true
  }

  const lid = lesson.id
  const questions = [
    {
      id: Date.now() + 10, lessonId: lid, activity: 'practice', difficulty: 'easy',
      type: 'multiple-choice', questionText: 'I ___ a student.', score: 2, isActive: true,
      data: { options: ['am', 'is', 'are'], answer: 'am' }
    },
    {
      id: Date.now() + 11, lessonId: lid, activity: 'practice', difficulty: 'easy',
      type: 'true-false', questionText: 'The sun is cold.', score: 2, isActive: true,
      data: { answer: false }
    },
    {
      id: Date.now() + 12, lessonId: lid, activity: 'practice', difficulty: 'medium',
      type: 'fill-blank', questionText: 'My name ___ Ali.', score: 2, isActive: true,
      data: { answer: 'is' }
    },
    {
      id: Date.now() + 13, lessonId: lid, activity: 'review', difficulty: 'medium',
      type: 'matching', questionText: 'صِل كل كلمة بمعناها', score: 3, isActive: true,
      data: { pairs: [{ left: 'Apple', right: 'تفاحة' }, { left: 'Dog', right: 'كلب' }, { left: 'Book', right: 'كتاب' }] }
    },
    {
      id: Date.now() + 14, lessonId: lid, activity: 'review', difficulty: 'medium',
      type: 'reordering', questionText: 'رتب الكلمات لتكوين جملة صحيحة', score: 3, isActive: true,
      data: { tokens: ['I', 'am', 'a', 'student'], correctOrder: ['I', 'am', 'a', 'student'] }
    },
    {
      id: Date.now() + 15, lessonId: lid, activity: 'review', difficulty: 'hard',
      type: 'picture-word', questionText: 'اختر الكلمة المناسبة للصورة', score: 2, isActive: true,
      data: { imageUrl: 'https://placekitten.com/300/200', options: ['cat', 'dog', 'bird'], answer: 'cat' }
    },
    {
      id: Date.now() + 16, lessonId: lid, activity: 'practice', difficulty: 'medium',
      type: 'multiple-select', questionText: 'اختر كل الحيوانات', score: 3, isActive: true,
      data: { options: ['cat', 'car', 'dog', 'book'], answers: ['cat', 'dog'] }
    },
    {
      id: Date.now() + 17, lessonId: lid, activity: 'practice', difficulty: 'easy',
      type: 'dropdown', questionText: 'She ___ happy.', score: 2, isActive: true,
      data: { options: ['am', 'is', 'are'], answer: 'is' }
    },
    {
      id: Date.now() + 18, lessonId: lid, activity: 'review', difficulty: 'medium',
      type: 'classification', questionText: 'صنّف الكلمات في الفئة الصحيحة', score: 3, isActive: true,
      data: {
        categories: ['Food', 'Animals'],
        items: [{ word: 'Apple', category: 'Food' }, { word: 'Dog', category: 'Animals' }, { word: 'Bread', category: 'Food' }]
      }
    }
  ]

  const assessment = {
    id: Date.now() + 20,
    title: 'فرض تجريبي 1',
    type: 'assignment',
    level: '3PS',
    term: 1,
    fileUrl: 'https://example.com/demo.pdf',
    fileType: 'pdf',
    totalScore: 20,
    dueDate: today,
    coversSequences: [],
    isActive: true
  }

  return { student, lesson, questions, assessment }
}
