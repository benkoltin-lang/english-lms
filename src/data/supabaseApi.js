import { supabase } from './supabaseClient.js'

// ============================================
// تحويل الأسماء بين JS (camelCase) و SQL (snake_case)
// ============================================

const studentFromDb = (r) => ({
  id: r.id, name: r.name, username: r.username, password: r.password,
  level: r.level, currentTerm: r.current_term, startDate: r.start_date,
  endDate: r.end_date, status: r.status
})
const studentToDb = (s) => ({
  name: s.name, username: s.username, password: s.password, level: s.level,
  current_term: s.currentTerm, start_date: s.startDate, end_date: s.endDate, status: s.status
})

const lessonFromDb = (r) => ({
  id: r.id, level: r.level, term: r.term, sequence: r.sequence, title: r.title,
  content: r.content, videoUrl: r.video_url, images: r.images || [],
  order: r.order_num, isActive: r.is_active
})
const lessonToDb = (l) => ({
  level: l.level, term: l.term, sequence: l.sequence, title: l.title, content: l.content,
  video_url: l.videoUrl, images: l.images || [], order_num: l.order, is_active: l.isActive
})

const questionFromDb = (r) => ({
  id: r.id, lessonId: r.lesson_id, activity: r.activity, difficulty: r.difficulty,
  type: r.type, questionText: r.question_text, score: r.score, isActive: r.is_active, data: r.data
})
const questionToDb = (q) => ({
  lesson_id: q.lessonId, activity: q.activity, difficulty: q.difficulty, type: q.type,
  question_text: q.questionText, score: q.score, is_active: q.isActive ?? true, data: q.data
})

const assessmentFromDb = (r) => ({
  id: r.id, title: r.title, type: r.type, level: r.level, term: r.term,
  fileUrl: r.file_url, fileType: r.file_type, totalScore: r.total_score,
  dueDate: r.due_date, coversSequences: r.covers_sequences || [], isActive: r.is_active
})
const assessmentToDb = (a) => ({
  title: a.title, type: a.type, level: a.level, term: a.term, file_url: a.fileUrl,
  file_type: a.fileType, total_score: a.totalScore, due_date: a.dueDate,
  covers_sequences: a.coversSequences || [], is_active: a.isActive ?? true
})

const submissionFromDb = (r) => ({
  id: r.id, assessmentId: r.assessment_id, studentId: r.student_id, answerText: r.answer_text,
  attachmentUrl: r.attachment_url, status: r.status, submittedAt: r.submitted_at,
  grade: r.grade, teacherNote: r.teacher_note
})
const submissionToDb = (s) => ({
  assessment_id: s.assessmentId, student_id: s.studentId, answer_text: s.answerText,
  attachment_url: s.attachmentUrl, status: s.status, grade: s.grade, teacher_note: s.teacherNote
})

const resultFromDb = (r) => ({
  id: r.id, studentId: r.student_id, lessonId: r.lesson_id, activity: r.activity,
  score: r.score, totalScore: r.total_score, answeredAt: r.answered_at
})
const resultToDb = (r) => ({
  student_id: r.studentId, lesson_id: r.lessonId, activity: r.activity,
  score: r.score, total_score: r.totalScore
})

// ============================================
// جلب كل البيانات دفعة واحدة (يُستخدم عند فتح التطبيق)
// ============================================
export async function fetchAllData() {
  const [students, lessons, questions, assessments, submissions, results] = await Promise.all([
    supabase.from('students').select('*').order('created_at'),
    supabase.from('lessons').select('*').order('created_at'),
    supabase.from('questions').select('*').order('created_at'),
    supabase.from('assessments').select('*').order('created_at'),
    supabase.from('submissions').select('*').order('submitted_at'),
    supabase.from('results').select('*').order('answered_at')
  ])

  return {
    students: (students.data || []).map(studentFromDb),
    lessons: (lessons.data || []).map(lessonFromDb),
    questions: (questions.data || []).map(questionFromDb),
    assessments: (assessments.data || []).map(assessmentFromDb),
    submissions: (submissions.data || []).map(submissionFromDb),
    results: (results.data || []).map(resultFromDb)
  }
}

// ============================================
// عمليات CRUD لكل جدول
// ============================================

export const db = {
  students: {
    add: async (s) => {
      const { data, error } = await supabase.from('students').insert(studentToDb(s)).select().single()
      if (error) throw error
      return studentFromDb(data)
    },
    update: async (id, patch) => {
      const { error } = await supabase.from('students').update(studentToDb(patch)).eq('id', id)
      if (error) throw error
    },
    delete: async (id) => {
      const { error } = await supabase.from('students').delete().eq('id', id)
      if (error) throw error
    }
  },
  lessons: {
    add: async (l) => {
      const { data, error } = await supabase.from('lessons').insert(lessonToDb(l)).select().single()
      if (error) throw error
      return lessonFromDb(data)
    },
    update: async (id, patch) => {
      const { error } = await supabase.from('lessons').update(lessonToDb(patch)).eq('id', id)
      if (error) throw error
    },
    delete: async (id) => {
      const { error } = await supabase.from('lessons').delete().eq('id', id)
      if (error) throw error
    }
  },
  questions: {
    add: async (q) => {
      const { data, error } = await supabase.from('questions').insert(questionToDb(q)).select().single()
      if (error) throw error
      return questionFromDb(data)
    },
    update: async (id, patch) => {
      const { error } = await supabase.from('questions').update(questionToDb(patch)).eq('id', id)
      if (error) throw error
    },
    delete: async (id) => {
      const { error } = await supabase.from('questions').delete().eq('id', id)
      if (error) throw error
    }
  },
  assessments: {
    add: async (a) => {
      const { data, error } = await supabase.from('assessments').insert(assessmentToDb(a)).select().single()
      if (error) throw error
      return assessmentFromDb(data)
    },
    update: async (id, patch) => {
      const { error } = await supabase.from('assessments').update(assessmentToDb(patch)).eq('id', id)
      if (error) throw error
    },
    delete: async (id) => {
      const { error } = await supabase.from('assessments').delete().eq('id', id)
      if (error) throw error
    }
  },
  submissions: {
    upsert: async (s) => {
      // إن كان لديها id موجود سابقاً في القائمة نحدّث، وإلا ندرج
      if (s.id && s.id < 100000000000) {
        // ids صغيرة = قادمة من قاعدة البيانات فعلاً (وليس Date.now() المؤقت من الواجهة)
        const { error } = await supabase.from('submissions').update(submissionToDb(s)).eq('id', s.id)
        if (error) throw error
        return s
      }
      const { data, error } = await supabase.from('submissions').insert(submissionToDb(s)).select().single()
      if (error) throw error
      return submissionFromDb(data)
    },
    update: async (id, patch) => {
      const { error } = await supabase.from('submissions').update(submissionToDb(patch)).eq('id', id)
      if (error) throw error
    }
  },
  results: {
    add: async (r) => {
      const { data, error } = await supabase.from('results').insert(resultToDb(r)).select().single()
      if (error) throw error
      return resultFromDb(data)
    }
  }
}

// ============================================
// رفع ملف إلى Supabase Storage (bucket: assessments)
// ============================================
export async function uploadFile(file, pathPrefix = '') {
  const fileName = `${pathPrefix}${Date.now()}_${file.name}`
  const { error } = await supabase.storage.from('assessments').upload(fileName, file)
  if (error) throw error
  const { data } = supabase.storage.from('assessments').getPublicUrl(fileName)
  return data.publicUrl
}
