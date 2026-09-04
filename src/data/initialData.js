// ============================================
// شكل البيانات الكامل (Data Shape) - مرجع توثيقي
// ============================================
//
// Student:
// { id, name, username, password, level, currentTerm, startDate, endDate, status: 'pending'|'approved'|'rejected' }
//
// Lesson:
// { id, level, term, sequence, title, content, videoUrl, images: [], order, isActive }
//
// Question:
// { id, lessonId, activity: 'practice'|'review', type, difficulty, questionText, score, isActive, data: {...} }
//   data يختلف حسب type - انظر أمثلة في questions/*.jsx
//
// Assessment (فرض/امتحان):
// { id, title, type: 'assignment'|'exam', level, term, fileUrl, fileType, totalScore, dueDate, coversSequences: [], isActive }
//
// Submission (إجابة تلميذ على تقييم):
// { id, assessmentId, studentId, answerText, attachmentUrl, status: 'submitted'|'reviewing'|'graded'|'returned', submittedAt, grade, teacherNote }
//
// Result (نتيجة تلميذ في نشاط تطبيق/مراجعة):
// { id, studentId, lessonId, activity, score, totalScore, answeredAt }
//
// ============================================

export const initialData = {
  students: [],
  lessons: [],
  questions: [],
  assessments: [],
  submissions: [],
  results: []
}
