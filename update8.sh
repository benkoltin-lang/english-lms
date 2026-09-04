#!/bin/bash
# تحديث كبير: التحول الكامل من localStorage إلى Supabase
# ⚠️ قبل تشغيله، نفّذ في Termux: npm install @supabase/supabase-js
cat > src/data/supabaseClient.js << 'FILEEOF'
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://panylticaatcdkngdkkg.supabase.co'
const supabaseKey = 'sb_publishable_LquqwGV-VUgVsPRY3d-Ltg_DXoK7TOt'

export const supabase = createClient(supabaseUrl, supabaseKey)
FILEEOF

cat > src/data/supabaseApi.js << 'FILEEOF'
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
FILEEOF

cat > src/App.jsx << 'FILEEOF'
import { useState, useEffect } from 'react'
import { fetchAllData, db } from './data/supabaseApi.js'
import TeacherDashboard from './components/teacher/TeacherDashboard.jsx'
import StudentDashboard from './components/student/StudentDashboard.jsx'
import LessonView from './components/student/LessonView.jsx'
import ActivitySolver from './components/student/ActivitySolver.jsx'
import AssessmentView from './components/student/AssessmentView.jsx'
import { buildDemoData } from './data/demoData.js'

const TEACHER_PASSWORD = 'admin2024' // ⚠️ مؤقت فقط لتجربة الهيكل - يُستبدل لاحقاً بنظام حقيقي

function App() {
  const isAdminRoute = window.location.pathname === '/admin'

  const [data, setData] = useState({ students: [], lessons: [], questions: [], assessments: [], submissions: [], results: [] })
  const [loading, setLoading] = useState(true)
  const [loadError, setLoadError] = useState('')

  const reload = async () => {
    try {
      setLoading(true)
      const fresh = await fetchAllData()
      setData(fresh)
      setLoadError('')
    } catch (err) {
      setLoadError('⚠️ تعذّر الاتصال بالخادم: ' + err.message)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => { reload() }, [])

  const [userType, setUserType] = useState(null)
  const [currentStudent, setCurrentStudent] = useState(null)
  const [teacherPass, setTeacherPass] = useState('')
  const [loginError, setLoginError] = useState('')

  const [activeLesson, setActiveLesson] = useState(null)
  const [activeActivity, setActiveActivity] = useState(null)
  const [activeAssessment, setActiveAssessment] = useState(null)

  const today = new Date().toISOString().split('T')[0]

  const handleTeacherLogin = (e) => {
    e.preventDefault()
    if (teacherPass === TEACHER_PASSWORD) {
      setUserType('teacher')
      setTeacherPass('')
    } else {
      setLoginError('كلمة المرور غير صحيحة')
    }
  }

  const handleStudentLogin = (e) => {
    e.preventDefault()
    setLoginError('')
    const username = e.target.username.value
    const password = e.target.password.value

    const student = data.students.find(
      s => s.username === username && s.password === password && s.status === 'approved'
    )

    if (!student) {
      setLoginError('❌ اسم المستخدم أو كلمة المرور غير صحيحة، أو الحساب بانتظار موافقة الأستاذ')
      return
    }
    if (student.startDate > today) { setLoginError('⚠️ الحساب لم يبدأ بعد'); return }
    if (student.endDate < today) { setLoginError('⚠️ انتهت صلاحية الحساب'); return }
    setCurrentStudent(student)
    setUserType('student')
  }

  const handleLogout = () => {
    setUserType(null)
    setCurrentStudent(null)
    setLoginError('')
    setActiveLesson(null)
    setActiveActivity(null)
    setActiveAssessment(null)
  }

  const saveResult = async (result) => {
    const saved = await db.results.add(result)
    setData(prev => ({ ...prev, results: [...prev.results, saved] }))
  }

  const seedDemoData = async () => {
    try {
      const { student, lesson, questions, assessment } = buildDemoData()
      const savedStudent = await db.students.add(student)
      const savedLesson = await db.lessons.add(lesson)
      const savedQuestions = []
      for (const q of questions) {
        savedQuestions.push(await db.questions.add({ ...q, lessonId: savedLesson.id }))
      }
      const savedAssessment = await db.assessments.add(assessment)
      setData(prev => ({
        ...prev,
        students: [...prev.students, savedStudent],
        lessons: [...prev.lessons, savedLesson],
        questions: [...prev.questions, ...savedQuestions],
        assessments: [...prev.assessments, savedAssessment]
      }))
      alert('✅ تمت تعبئة بيانات تجريبية!\nسجّل دخول بـ: test / 123')
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    }
  }

  if (loading) {
    return <div className="app"><main className="main"><p className="empty">⏳ جارٍ تحميل البيانات...</p></main></div>
  }

  if (loadError) {
    return (
      <div className="app"><main className="main">
        <div className="error">{loadError}</div>
        <button className="btn-primary" onClick={reload}>إعادة المحاولة</button>
      </main></div>
    )
  }

  if (userType === 'teacher') {
    return <TeacherDashboard data={data} setData={setData} reload={reload} onLogout={handleLogout} />
  }

  if (isAdminRoute && userType !== 'teacher') {
    return (
      <div className="app">
        <main className="main">
          <div className="login-card" style={{ marginTop: '60px' }}>
            <h2>🔒 منطقة الأستاذ</h2>
            {loginError && <div className="error">{loginError}</div>}
            <form onSubmit={handleTeacherLogin} className="form">
              <input type="password" placeholder="كلمة مرور الأستاذ"
                value={teacherPass} onChange={e => setTeacherPass(e.target.value)} />
              <button type="submit" className="btn-primary">دخول</button>
            </form>
            <a href="/" style={{ display: 'block', marginTop: '20px', color: '#9b7bc4' }}>← العودة للصفحة الرئيسية</a>
          </div>
        </main>
      </div>
    )
  }

  if (userType === 'student' && currentStudent) {
    if (activeActivity && activeLesson) {
      const questions = data.questions.filter(
        q => q.lessonId === activeLesson.id && q.activity === activeActivity && q.isActive
      )
      return (
        <div className="app">
          <header className="header student-header">
            <div><h1>{activeLesson.title}</h1></div>
            <button className="logout-btn" onClick={() => setActiveActivity(null)}>رجوع للدرس</button>
          </header>
          <main className="main">
            <ActivitySolver
              lesson={activeLesson} activity={activeActivity} questions={questions}
              student={currentStudent} onFinish={() => setActiveActivity(null)} onSaveResult={saveResult}
            />
          </main>
        </div>
      )
    }

    if (activeLesson) {
      return (
        <LessonView data={data} lesson={activeLesson}
          onStartActivity={(activity) => setActiveActivity(activity)} onBack={() => setActiveLesson(null)} />
      )
    }

    if (activeAssessment) {
      return (
        <AssessmentView
          data={data} setData={setData} assessment={activeAssessment} student={currentStudent}
          onBack={() => setActiveAssessment(null)}
        />
      )
    }

    return (
      <StudentDashboard data={data} student={currentStudent}
        onOpenLesson={setActiveLesson} onOpenAssessment={setActiveAssessment} onLogout={handleLogout} />
    )
  }

  return (
    <div className="app">
      <header className="header">
        <h1>🌐 English Platform</h1>
        <p className="teacher-name">أستاذ عشي عبد العزيز</p>
        <p className="teacher-location">📍 Tébessa, Algeria</p>
      </header>

      <main className="main">
        <div className="login-card">
          <h2>تسجيل دخول التلميذ</h2>
          {loginError && <div className="error">{loginError}</div>}
          <form onSubmit={handleStudentLogin} className="form">
            <input type="text" name="username" placeholder="اسم المستخدم" required />
            <input type="password" name="password" placeholder="كلمة المرور" required />
            <button type="submit" className="btn-primary">دخول</button>
          </form>

          <div className="test-box" style={{ marginTop: '25px', padding: '20px', background: '#e8f4f8', borderRadius: '12px', border: '2px solid #bee5eb' }}>
            <h3 style={{ marginBottom: '10px', color: '#0c5460' }}>🧪 تجربة سريعة</h3>
            <p style={{ marginBottom: '12px', fontSize: '14px' }}>
              عبّئ درساً + أسئلة + فرضاً + تلميذاً تجريبياً دفعة واحدة، لتجربة الموقع بالكامل فوراً.
            </p>
            <button className="btn-success" onClick={seedDemoData}>➕ تعبئة بيانات تجريبية</button>
          </div>
        </div>
      </main>
    </div>
  )
}

export default App
FILEEOF

cat > src/components/teacher/StudentsPanel.jsx << 'FILEEOF'
import { useState } from 'react'
import { LEVELS, TERMS } from '../../data/constants.js'
import { db } from '../../data/supabaseApi.js'

export default function StudentsPanel({ data, setData }) {
  const today = new Date().toISOString().split('T')[0]
  const [editingId, setEditingId] = useState(null)
  const [busy, setBusy] = useState(false)

  const emptyForm = { name: '', username: '', password: '', level: LEVELS[0].id, term: 1, startDate: today }
  const [form, setForm] = useState(emptyForm)

  const startEdit = (s) => {
    setEditingId(s.id)
    setForm({ name: s.name, username: s.username, password: s.password, level: s.level, term: s.currentTerm, startDate: s.startDate })
  }
  const cancelEdit = () => { setEditingId(null); setForm(emptyForm) }

  const submitForm = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      if (editingId) {
        const patch = { name: form.name, username: form.username, password: form.password, level: form.level, currentTerm: parseInt(form.term), startDate: form.startDate }
        await db.students.update(editingId, patch)
        setData({ ...data, students: data.students.map(s => s.id === editingId ? { ...s, ...patch } : s) })
      } else {
        const endDate = new Date()
        endDate.setFullYear(endDate.getFullYear() + 1)
        const newStudent = {
          name: form.name, username: form.username, password: form.password, level: form.level,
          currentTerm: parseInt(form.term), startDate: form.startDate,
          endDate: endDate.toISOString().split('T')[0], status: 'pending'
        }
        const saved = await db.students.add(newStudent)
        setData({ ...data, students: [...data.students, saved] })
      }
      cancelEdit()
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const setStatus = async (id, status) => {
    await db.students.update(id, { ...data.students.find(s => s.id === id), status })
    setData({ ...data, students: data.students.map(s => s.id === id ? { ...s, status } : s) })
  }

  const deleteStudent = async (id) => {
    if (window.confirm('حذف التلميذ؟')) {
      await db.students.delete(id)
      setData({ ...data, students: data.students.filter(s => s.id !== id) })
      if (editingId === id) cancelEdit()
    }
  }

  const statusLabel = { pending: '⏳ بانتظار الموافقة', approved: '✅ مقبول', rejected: '❌ مرفوض' }

  return (
    <div className="panel">
      <div className="card">
        <h2>{editingId ? '✏️ تعديل تلميذ' : '➕ إضافة تلميذ جديد'}</h2>
        <form onSubmit={submitForm} className="form">
          <div className="form-row">
            <input type="text" placeholder="الاسم الكامل" required
              value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} />
            <select required value={form.level} onChange={e => setForm({ ...form, level: e.target.value })}>
              {LEVELS.map(l => <option key={l.id} value={l.id}>{l.nameAr} ({l.id})</option>)}
            </select>
          </div>
          <div className="form-row">
            <input type="text" placeholder="اسم المستخدم" required
              value={form.username} onChange={e => setForm({ ...form, username: e.target.value })} />
            <input type="text" placeholder="كلمة المرور" required
              value={form.password} onChange={e => setForm({ ...form, password: e.target.value })} />
          </div>
          <div className="form-row">
            <select required value={form.term} onChange={e => setForm({ ...form, term: e.target.value })}>
              {TERMS.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
            </select>
            <input type="date" required value={form.startDate} onChange={e => setForm({ ...form, startDate: e.target.value })} />
          </div>
          <div className="form-row">
            <button type="submit" className="btn-primary" disabled={busy}>{busy ? '...' : (editingId ? 'حفظ التعديل' : 'إضافة')}</button>
            {editingId && <button type="button" className="btn-secondary" onClick={cancelEdit}>إلغاء</button>}
          </div>
        </form>
      </div>

      <div className="card">
        <h2>قائمة التلاميذ ({data.students.length})</h2>
        {data.students.length === 0 ? <p className="empty">لا يوجد تلاميذ بعد</p> : (
          <div className="list">
            {data.students.map(s => (
              <div key={s.id} className="list-item">
                <div>
                  <strong>{s.name}</strong>
                  <p>{s.username} | {s.level} | {statusLabel[s.status]}</p>
                </div>
                <div className="row-actions">
                  {s.status !== 'approved' && <button className="btn-approve" onClick={() => setStatus(s.id, 'approved')}>قبول</button>}
                  {s.status !== 'rejected' && <button className="btn-reject" onClick={() => setStatus(s.id, 'rejected')}>رفض</button>}
                  <button className="btn-secondary" onClick={() => startEdit(s)}>تعديل</button>
                  <button className="btn-delete" onClick={() => deleteStudent(s.id)}>🗑️</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
FILEEOF

cat > src/components/teacher/LessonsPanel.jsx << 'FILEEOF'
import { useState } from 'react'
import { LEVELS, TERMS } from '../../data/constants.js'
import { db } from '../../data/supabaseApi.js'

export default function LessonsPanel({ data, setData }) {
  const [editingId, setEditingId] = useState(null)
  const [busy, setBusy] = useState(false)
  const emptyForm = { level: LEVELS[0].id, term: 1, sequence: '', title: '', content: '', videoUrl: '' }
  const [form, setForm] = useState(emptyForm)

  const startEdit = (l) => {
    setEditingId(l.id)
    setForm({ level: l.level, term: l.term, sequence: l.sequence, title: l.title, content: l.content, videoUrl: l.videoUrl || '' })
  }
  const cancelEdit = () => { setEditingId(null); setForm(emptyForm) }

  const submitForm = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      if (editingId) {
        const existing = data.lessons.find(l => l.id === editingId)
        const patch = { ...existing, level: form.level, term: parseInt(form.term), sequence: form.sequence, title: form.title, content: form.content, videoUrl: form.videoUrl }
        await db.lessons.update(editingId, patch)
        setData({ ...data, lessons: data.lessons.map(l => l.id === editingId ? patch : l) })
      } else {
        const newLesson = {
          level: form.level, term: parseInt(form.term), sequence: form.sequence, title: form.title,
          content: form.content, videoUrl: form.videoUrl, images: [], order: data.lessons.length + 1, isActive: true
        }
        const saved = await db.lessons.add(newLesson)
        setData({ ...data, lessons: [...data.lessons, saved] })
      }
      cancelEdit()
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const toggleActive = async (l) => {
    const patch = { ...l, isActive: !l.isActive }
    await db.lessons.update(l.id, patch)
    setData({ ...data, lessons: data.lessons.map(x => x.id === l.id ? patch : x) })
  }

  const deleteLesson = async (id) => {
    if (window.confirm('حذف الدرس؟ (سيُحذف معه أسئلته تلقائياً)')) {
      await db.lessons.delete(id)
      setData({
        ...data,
        lessons: data.lessons.filter(l => l.id !== id),
        questions: data.questions.filter(q => q.lessonId !== id)
      })
      if (editingId === id) cancelEdit()
    }
  }

  return (
    <div className="panel">
      <div className="card">
        <h2>{editingId ? '✏️ تعديل الدرس' : '📚 إضافة درس جديد'}</h2>
        <form onSubmit={submitForm} className="form">
          <div className="form-row">
            <select required value={form.level} onChange={e => setForm({ ...form, level: e.target.value })}>
              {LEVELS.map(l => <option key={l.id} value={l.id}>{l.nameAr} ({l.id})</option>)}
            </select>
            <select required value={form.term} onChange={e => setForm({ ...form, term: e.target.value })}>
              {TERMS.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
            </select>
            <input type="text" placeholder="اسم التسلسل (مثال: Sequence 1)" required
              value={form.sequence} onChange={e => setForm({ ...form, sequence: e.target.value })} />
          </div>
          <input type="text" placeholder="عنوان الدرس" required
            value={form.title} onChange={e => setForm({ ...form, title: e.target.value })} />
          <textarea placeholder="محتوى الدرس" rows="4" required
            value={form.content} onChange={e => setForm({ ...form, content: e.target.value })} />
          <input type="url" placeholder="رابط فيديو يوتيوب (اختياري)"
            value={form.videoUrl} onChange={e => setForm({ ...form, videoUrl: e.target.value })} />
          <div className="form-row">
            <button type="submit" className="btn-primary" disabled={busy}>{busy ? '...' : (editingId ? 'حفظ التعديل' : 'حفظ الدرس')}</button>
            {editingId && <button type="button" className="btn-secondary" onClick={cancelEdit}>إلغاء</button>}
          </div>
        </form>
      </div>

      <div className="card">
        <h2>الدروس المضافة ({data.lessons.length})</h2>
        {data.lessons.length === 0 ? <p className="empty">لا توجد دروس بعد</p> : (
          <div className="list">
            {data.lessons.map(l => (
              <div key={l.id} className="list-item">
                <div>
                  <strong>{l.title}</strong>
                  <p>{l.level} - {TERMS.find(t => t.id === l.term)?.nameAr} - {l.sequence} {l.isActive ? '' : '(معطّل)'}</p>
                </div>
                <div className="row-actions">
                  <button className="btn-secondary" onClick={() => toggleActive(l)}>{l.isActive ? 'تعطيل' : 'تفعيل'}</button>
                  <button className="btn-secondary" onClick={() => startEdit(l)}>تعديل</button>
                  <button className="btn-delete" onClick={() => deleteLesson(l.id)}>🗑️</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
FILEEOF

cat > src/components/teacher/QuestionsPanel.jsx << 'FILEEOF'
import { useState } from 'react'
import { QUESTION_TYPES, LESSON_ACTIVITY_TYPES, DIFFICULTY_LEVELS } from '../../data/constants.js'
import { db } from '../../data/supabaseApi.js'

const emptyForm = {
  lessonId: '', activity: 'practice', difficulty: 'easy', type: 'multiple-choice',
  questionText: '', score: 2,
  opt1: '', opt2: '', opt3: '', opt4: '', correctAnswer: '', imageUrl: '',
  tfAnswer: 'true', matchLeft: '', matchRight: '', tokens: '',
  multiOptions: '', multiAnswers: '',
  categories: '', classifyItems: ''
}

export default function QuestionsPanel({ data, setData }) {
  const [editingId, setEditingId] = useState(null)
  const [busy, setBusy] = useState(false)
  const [form, setForm] = useState(emptyForm)
  const set = (patch) => setForm({ ...form, ...patch })

  const startEdit = (q) => {
    setEditingId(q.id)
    const base = { lessonId: q.lessonId, activity: q.activity, difficulty: q.difficulty, type: q.type, questionText: q.questionText, score: q.score }
    if (q.type === 'multiple-choice' || q.type === 'picture-word') {
      setForm({ ...emptyForm, ...base, opt1: q.data.options[0] || '', opt2: q.data.options[1] || '', opt3: q.data.options[2] || '', opt4: q.data.options[3] || '', correctAnswer: q.data.answer, imageUrl: q.data.imageUrl || '' })
    } else if (q.type === 'multiple-select') {
      setForm({ ...emptyForm, ...base, multiOptions: q.data.options.join(', '), multiAnswers: q.data.answers.join(', ') })
    } else if (q.type === 'true-false') {
      setForm({ ...emptyForm, ...base, tfAnswer: String(q.data.answer) })
    } else if (q.type === 'fill-blank') {
      setForm({ ...emptyForm, ...base, correctAnswer: q.data.answer })
    } else if (q.type === 'dropdown') {
      setForm({ ...emptyForm, ...base, multiOptions: q.data.options.join(', '), correctAnswer: q.data.answer })
    } else if (q.type === 'matching') {
      setForm({ ...emptyForm, ...base, matchLeft: q.data.pairs.map(p => p.left).join(', '), matchRight: q.data.pairs.map(p => p.right).join(', ') })
    } else if (q.type === 'reordering') {
      setForm({ ...emptyForm, ...base, tokens: q.data.tokens.join(', ') })
    } else if (q.type === 'classification') {
      setForm({ ...emptyForm, ...base, categories: q.data.categories.join(', '), classifyItems: q.data.items.map(it => `${it.word}=${it.category}`).join(', ') })
    }
  }
  const cancelEdit = () => { setEditingId(null); setForm(emptyForm) }

  const buildData = () => {
    switch (form.type) {
      case 'multiple-choice':
      case 'picture-word':
        return { options: [form.opt1, form.opt2, form.opt3, form.opt4].filter(Boolean), answer: form.correctAnswer, ...(form.type === 'picture-word' ? { imageUrl: form.imageUrl } : {}) }
      case 'multiple-select':
        return { options: form.multiOptions.split(',').map(s => s.trim()).filter(Boolean), answers: form.multiAnswers.split(',').map(s => s.trim()).filter(Boolean) }
      case 'true-false':
        return { answer: form.tfAnswer === 'true' }
      case 'fill-blank':
        return { answer: form.correctAnswer }
      case 'dropdown':
        return { options: form.multiOptions.split(',').map(s => s.trim()).filter(Boolean), answer: form.correctAnswer }
      case 'matching': {
        const lefts = form.matchLeft.split(',').map(s => s.trim())
        const rights = form.matchRight.split(',').map(s => s.trim())
        return { pairs: lefts.map((l, i) => ({ left: l, right: rights[i] || '' })) }
      }
      case 'reordering': {
        const tokens = form.tokens.split(',').map(s => s.trim())
        return { tokens: [...tokens], correctOrder: tokens }
      }
      case 'classification': {
        const categories = form.categories.split(',').map(s => s.trim()).filter(Boolean)
        const items = form.classifyItems.split(',').map(pair => {
          const [word, category] = pair.split('=').map(s => s.trim())
          return { word, category }
        }).filter(it => it.word)
        return { categories, items }
      }
      default: return {}
    }
  }

  const submitForm = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      const payload = {
        lessonId: parseInt(form.lessonId), activity: form.activity, difficulty: form.difficulty,
        type: form.type, questionText: form.questionText, score: parseInt(form.score) || 2, data: buildData()
      }
      if (editingId) {
        const patch = { ...payload, isActive: true }
        await db.questions.update(editingId, patch)
        setData({ ...data, questions: data.questions.map(q => q.id === editingId ? { ...q, ...payload } : q) })
      } else {
        const saved = await db.questions.add({ ...payload, isActive: true })
        setData({ ...data, questions: [...data.questions, saved] })
      }
      cancelEdit()
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const deleteQuestion = async (id) => {
    if (window.confirm('حذف السؤال؟')) {
      await db.questions.delete(id)
      setData({ ...data, questions: data.questions.filter(q => q.id !== id) })
      if (editingId === id) cancelEdit()
    }
  }

  return (
    <div className="panel">
      <div className="card">
        <h2>{editingId ? '✏️ تعديل السؤال' : '❓ إضافة سؤال جديد'}</h2>
        <form onSubmit={submitForm} className="form">
          <div className="form-row">
            <select required value={form.lessonId} onChange={e => set({ lessonId: e.target.value })}>
              <option value="">اختر الدرس</option>
              {data.lessons.map(l => <option key={l.id} value={l.id}>{l.title} ({l.level})</option>)}
            </select>
            <select required value={form.activity} onChange={e => set({ activity: e.target.value })}>
              {LESSON_ACTIVITY_TYPES.map(a => <option key={a.id} value={a.id}>{a.nameAr}</option>)}
            </select>
            <select required value={form.difficulty} onChange={e => set({ difficulty: e.target.value })}>
              {DIFFICULTY_LEVELS.map(d => <option key={d.id} value={d.id}>{d.nameAr}</option>)}
            </select>
          </div>

          <select value={form.type} onChange={e => set({ type: e.target.value })}>
            {QUESTION_TYPES.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
          </select>

          <textarea placeholder="نص السؤال" required value={form.questionText} onChange={e => set({ questionText: e.target.value })} />

          {(form.type === 'multiple-choice' || form.type === 'picture-word') && (
            <>
              {form.type === 'picture-word' && <input placeholder="رابط الصورة" value={form.imageUrl} onChange={e => set({ imageUrl: e.target.value })} />}
              <div className="form-row">
                <input placeholder="الخيار 1" required value={form.opt1} onChange={e => set({ opt1: e.target.value })} />
                <input placeholder="الخيار 2" required value={form.opt2} onChange={e => set({ opt2: e.target.value })} />
                <input placeholder="الخيار 3" value={form.opt3} onChange={e => set({ opt3: e.target.value })} />
                <input placeholder="الخيار 4" value={form.opt4} onChange={e => set({ opt4: e.target.value })} />
              </div>
              <input placeholder="الإجابة الصحيحة (مطابقة لأحد الخيارات)" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
            </>
          )}

          {form.type === 'multiple-select' && (
            <>
              <input placeholder="كل الخيارات مفصولة بفاصلة: cat, dog, car, book" required value={form.multiOptions} onChange={e => set({ multiOptions: e.target.value })} />
              <input placeholder="الإجابات الصحيحة (أكثر من واحدة): cat, dog" required value={form.multiAnswers} onChange={e => set({ multiAnswers: e.target.value })} />
            </>
          )}

          {form.type === 'true-false' && (
            <select required value={form.tfAnswer} onChange={e => set({ tfAnswer: e.target.value })}>
              <option value="true">صح</option>
              <option value="false">خطأ</option>
            </select>
          )}

          {form.type === 'fill-blank' && (
            <input placeholder="الإجابة الصحيحة" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
          )}

          {form.type === 'dropdown' && (
            <>
              <input placeholder="كل الخيارات مفصولة بفاصلة: am, is, are" required value={form.multiOptions} onChange={e => set({ multiOptions: e.target.value })} />
              <input placeholder="الإجابة الصحيحة" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
            </>
          )}

          {form.type === 'matching' && (
            <div className="form-row">
              <input placeholder="العناصر اليسرى: Apple, Dog" required value={form.matchLeft} onChange={e => set({ matchLeft: e.target.value })} />
              <input placeholder="المقابل بنفس الترتيب: تفاحة, كلب" required value={form.matchRight} onChange={e => set({ matchRight: e.target.value })} />
            </div>
          )}

          {form.type === 'reordering' && (
            <input placeholder="الكلمات مرتبة صحيحة: I, am, a, student" required value={form.tokens} onChange={e => set({ tokens: e.target.value })} />
          )}

          {form.type === 'classification' && (
            <>
              <input placeholder="الفئات مفصولة بفاصلة: Food, Animals" required value={form.categories} onChange={e => set({ categories: e.target.value })} />
              <input placeholder="العناصر=الفئة مفصولة بفاصلة: Apple=Food, Dog=Animals" required value={form.classifyItems} onChange={e => set({ classifyItems: e.target.value })} />
            </>
          )}

          <div className="form-row">
            <input type="number" placeholder="الدرجة" min="1" value={form.score} onChange={e => set({ score: e.target.value })} />
          </div>

          <div className="form-row">
            <button type="submit" className="btn-primary" disabled={busy}>{busy ? '...' : (editingId ? 'حفظ التعديل' : 'إضافة السؤال')}</button>
            {editingId && <button type="button" className="btn-secondary" onClick={cancelEdit}>إلغاء</button>}
          </div>
        </form>
      </div>

      <div className="card">
        <h2>الأسئلة المضافة ({data.questions.length})</h2>
        {data.questions.length === 0 ? <p className="empty">لا توجد أسئلة بعد</p> : (
          <div className="list">
            {data.questions.map(q => (
              <div key={q.id} className="list-item">
                <div>
                  <strong>{q.questionText}</strong>
                  <p>{QUESTION_TYPES.find(t => t.id === q.type)?.nameAr} | {q.activity} | {q.difficulty} | {q.score} نقاط</p>
                </div>
                <div className="row-actions">
                  <button className="btn-secondary" onClick={() => startEdit(q)}>تعديل</button>
                  <button className="btn-delete" onClick={() => deleteQuestion(q.id)}>🗑️</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
FILEEOF

cat > src/components/teacher/AssessmentsPanel.jsx << 'FILEEOF'
import { useState } from 'react'
import { LEVELS, TERMS, ASSESSMENT_TYPES } from '../../data/constants.js'
import { db, uploadFile } from '../../data/supabaseApi.js'

const emptyForm = { title: '', type: 'assignment', level: LEVELS[0].id, term: 1, totalScore: 20, dueDate: '' }

export default function AssessmentsPanel({ data, setData }) {
  const [editingId, setEditingId] = useState(null)
  const [form, setForm] = useState(emptyForm)
  const [file, setFile] = useState(null)
  const [busy, setBusy] = useState(false)
  const set = (patch) => setForm({ ...form, ...patch })

  const startEdit = (a) => {
    setEditingId(a.id)
    setFile(null)
    setForm({ title: a.title, type: a.type, level: a.level, term: a.term, totalScore: a.totalScore, dueDate: a.dueDate })
  }
  const cancelEdit = () => { setEditingId(null); setForm(emptyForm); setFile(null) }

  const submitForm = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      let fileUrl = editingId ? data.assessments.find(a => a.id === editingId)?.fileUrl : ''
      let fileType = editingId ? data.assessments.find(a => a.id === editingId)?.fileType : 'pdf'

      if (file) {
        fileUrl = await uploadFile(file)
        fileType = file.type === 'application/pdf' ? 'pdf' : 'image'
      }

      if (!fileUrl) {
        alert('⚠️ يجب رفع ملف (PDF أو صورة)')
        setBusy(false)
        return
      }

      const payload = {
        title: form.title, type: form.type, level: form.level, term: parseInt(form.term),
        fileUrl, fileType, totalScore: parseInt(form.totalScore) || 20, dueDate: form.dueDate
      }

      if (editingId) {
        const existing = data.assessments.find(a => a.id === editingId)
        const patch = { ...existing, ...payload }
        await db.assessments.update(editingId, patch)
        setData({ ...data, assessments: data.assessments.map(a => a.id === editingId ? patch : a) })
      } else {
        const saved = await db.assessments.add({ ...payload, coversSequences: [], isActive: true })
        setData({ ...data, assessments: [...data.assessments, saved] })
      }
      cancelEdit()
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const deleteAssessment = async (id) => {
    if (window.confirm('حذف التقييم؟')) {
      await db.assessments.delete(id)
      setData({ ...data, assessments: data.assessments.filter(a => a.id !== id) })
      if (editingId === id) cancelEdit()
    }
  }

  const submissionsFor = (assessmentId) => data.submissions.filter(s => s.assessmentId === assessmentId)

  return (
    <div className="panel">
      <div className="card">
        <h2>{editingId ? '✏️ تعديل التقييم' : '📝 إضافة فرض / امتحان'}</h2>
        <form onSubmit={submitForm} className="form">
          <input type="text" placeholder="العنوان (مثال: فرض 1 - Sequence 2)" required
            value={form.title} onChange={e => set({ title: e.target.value })} />
          <div className="form-row">
            <select required value={form.type} onChange={e => set({ type: e.target.value })}>
              {ASSESSMENT_TYPES.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
            </select>
            <select required value={form.level} onChange={e => set({ level: e.target.value })}>
              {LEVELS.map(l => <option key={l.id} value={l.id}>{l.nameAr} ({l.id})</option>)}
            </select>
            <select required value={form.term} onChange={e => set({ term: e.target.value })}>
              {TERMS.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
            </select>
          </div>

          <label style={{ fontSize: '14px', color: '#6a4c93', fontWeight: 'bold' }}>
            📎 ملف الفرض/الامتحان (PDF أو صورة){editingId ? ' - اترك فارغاً للإبقاء على الملف الحالي' : ''}
          </label>
          <input type="file" accept="application/pdf,image/*" onChange={e => setFile(e.target.files[0])} />

          <div className="form-row">
            <input type="number" placeholder="الدرجة الكلية" min="1" value={form.totalScore} onChange={e => set({ totalScore: e.target.value })} />
            <input type="date" required value={form.dueDate} onChange={e => set({ dueDate: e.target.value })} />
          </div>
          <div className="form-row">
            <button type="submit" className="btn-primary" disabled={busy}>{busy ? 'جارٍ الرفع...' : (editingId ? 'حفظ التعديل' : 'حفظ')}</button>
            {editingId && <button type="button" className="btn-secondary" onClick={cancelEdit}>إلغاء</button>}
          </div>
        </form>
      </div>

      <div className="card">
        <h2>التقييمات ({data.assessments.length})</h2>
        {data.assessments.length === 0 ? <p className="empty">لا توجد فروض أو امتحانات بعد</p> : (
          <div className="list">
            {data.assessments.map(a => (
              <div key={a.id} className="list-item">
                <div>
                  <strong>{a.title}</strong>
                  <p>{a.level} | تسليم قبل {a.dueDate} | أُرسل {submissionsFor(a.id).length} إجابة</p>
                </div>
                <div className="row-actions">
                  <button className="btn-secondary" onClick={() => startEdit(a)}>تعديل</button>
                  <button className="btn-delete" onClick={() => deleteAssessment(a.id)}>🗑️</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
FILEEOF

cat > src/components/teacher/GradingPanel.jsx << 'FILEEOF'
import { useState } from 'react'
import { db } from '../../data/supabaseApi.js'

const STATUS_LABELS = {
  submitted: '📤 تم الإرسال', reviewing: '👀 قيد المراجعة',
  graded: '✅ تم التصحيح', returned: '↩️ تم الإرجاع'
}

export default function GradingPanel({ data, setData }) {
  const [filterAssessment, setFilterAssessment] = useState('')
  const [filterStatus, setFilterStatus] = useState('')
  const [openId, setOpenId] = useState(null)
  const [gradeForm, setGradeForm] = useState({ grade: '', teacherNote: '', status: 'graded' })
  const [busy, setBusy] = useState(false)

  const studentName = (id) => data.students.find(s => s.id === id)?.name || 'غير معروف'
  const assessmentTitle = (id) => data.assessments.find(a => a.id === id)?.title || '—'

  const filtered = data.submissions.filter(s =>
    (!filterAssessment || s.assessmentId === parseInt(filterAssessment)) &&
    (!filterStatus || s.status === filterStatus)
  )

  const openSubmission = (s) => {
    setOpenId(s.id)
    setGradeForm({ grade: s.grade ?? '', teacherNote: s.teacherNote || '', status: 'graded' })
  }

  const saveGrade = async (submission) => {
    setBusy(true)
    try {
      const patch = { ...submission, grade: parseFloat(gradeForm.grade) || 0, teacherNote: gradeForm.teacherNote, status: gradeForm.status }
      await db.submissions.update(submission.id, patch)
      setData({ ...data, submissions: data.submissions.map(s => s.id === submission.id ? patch : s) })
      setOpenId(null)
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const setStatusOnly = async (submission, status) => {
    const patch = { ...submission, status }
    await db.submissions.update(submission.id, patch)
    setData({ ...data, submissions: data.submissions.map(s => s.id === submission.id ? patch : s) })
  }

  return (
    <div className="panel">
      <div className="card">
        <h2>📋 مراجعة إجابات الفروض والامتحانات</h2>
        <div className="form-row" style={{ marginBottom: '20px' }}>
          <select value={filterAssessment} onChange={e => setFilterAssessment(e.target.value)}>
            <option value="">كل التقييمات</option>
            {data.assessments.map(a => <option key={a.id} value={a.id}>{a.title}</option>)}
          </select>
          <select value={filterStatus} onChange={e => setFilterStatus(e.target.value)}>
            <option value="">كل الحالات</option>
            {Object.entries(STATUS_LABELS).map(([k, v]) => <option key={k} value={k}>{v}</option>)}
          </select>
        </div>

        {filtered.length === 0 ? <p className="empty">لا توجد إجابات مطابقة</p> : (
          <div className="list">
            {filtered.map(s => (
              <div key={s.id} className="list-item" style={{ flexDirection: 'column', alignItems: 'stretch' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', width: '100%', flexWrap: 'wrap', gap: '10px' }}>
                  <div>
                    <strong>{studentName(s.studentId)}</strong>
                    <p>{assessmentTitle(s.assessmentId)} | {STATUS_LABELS[s.status]} {s.grade != null ? `| الدرجة: ${s.grade}` : ''}</p>
                  </div>
                  <div className="row-actions">
                    {s.status === 'submitted' && (
                      <button className="btn-secondary" onClick={() => setStatusOnly(s, 'reviewing')}>بدء المراجعة</button>
                    )}
                    <button className="btn-secondary" onClick={() => openSubmission(s)}>فتح وتصحيح</button>
                  </div>
                </div>

                {openId === s.id && (
                  <div style={{ marginTop: '15px', padding: '15px', background: '#fdfbff', borderRadius: '10px' }}>
                    <p style={{ marginBottom: '10px' }}><strong>إجابة التلميذ:</strong> {s.answerText || '(لا يوجد نص)'}</p>
                    {s.attachmentUrl && (
                      <p style={{ marginBottom: '10px' }}>
                        <a href={s.attachmentUrl} target="_blank" rel="noreferrer">📎 عرض الملف المرفق</a>
                      </p>
                    )}
                    <div className="form-row">
                      <input type="number" placeholder="الدرجة" value={gradeForm.grade} onChange={e => setGradeForm({ ...gradeForm, grade: e.target.value })} />
                      <select value={gradeForm.status} onChange={e => setGradeForm({ ...gradeForm, status: e.target.value })}>
                        <option value="graded">✅ تم التصحيح</option>
                        <option value="returned">↩️ تم الإرجاع</option>
                      </select>
                    </div>
                    <textarea placeholder="ملاحظة للتلميذ (اختياري)" rows="2" value={gradeForm.teacherNote} onChange={e => setGradeForm({ ...gradeForm, teacherNote: e.target.value })} />
                    <div className="form-row" style={{ marginTop: '10px' }}>
                      <button className="btn-primary" disabled={busy} onClick={() => saveGrade(s)}>{busy ? '...' : 'حفظ الدرجة'}</button>
                      <button className="btn-secondary" onClick={() => setOpenId(null)}>إغلاق</button>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
FILEEOF

cat > src/components/student/AssessmentView.jsx << 'FILEEOF'
import { useState } from 'react'
import { db, uploadFile } from '../../data/supabaseApi.js'

const STATUS_LABELS = {
  submitted: '📤 تم الإرسال - بانتظار المراجعة', reviewing: '👀 قيد المراجعة',
  graded: '✅ تم التصحيح', returned: '↩️ تم الإرجاع'
}

export default function AssessmentView({ data, setData, assessment, student, onBack }) {
  const existing = data.submissions.find(s => s.assessmentId === assessment.id && s.studentId === student.id)
  const [answerText, setAnswerText] = useState(existing?.answerText || '')
  const [file, setFile] = useState(null)
  const [busy, setBusy] = useState(false)

  const submit = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      let attachmentUrl = existing?.attachmentUrl || ''
      if (file) {
        attachmentUrl = await uploadFile(file, `submissions/${student.id}_`)
      }

      const submission = {
        id: existing?.id, assessmentId: assessment.id, studentId: student.id,
        answerText, attachmentUrl, status: 'submitted',
        grade: existing?.grade ?? null, teacherNote: existing?.teacherNote ?? ''
      }

      const saved = await db.submissions.upsert(submission)
      setData({
        ...data,
        submissions: existing
          ? data.submissions.map(s => s.id === existing.id ? { ...s, ...submission, id: existing.id } : s)
          : [...data.submissions, saved]
      })
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  return (
    <div className="app">
      <header className="header student-header">
        <div>
          <h1>{assessment.title}</h1>
          <p>تسليم قبل {assessment.dueDate} | الدرجة الكلية {assessment.totalScore}</p>
        </div>
        <button className="logout-btn" onClick={onBack}>رجوع</button>
      </header>

      <main className="main">
        <div className="card">
          <h2>📄 الملف</h2>
          <div className="form-row">
            <a href={assessment.fileUrl} target="_blank" rel="noreferrer" className="btn-primary" style={{ textAlign: 'center' }}>👁️ معاينة</a>
            <a href={assessment.fileUrl} download className="btn-secondary" style={{ textAlign: 'center' }}>⬇️ تحميل</a>
          </div>
        </div>

        <div className="card">
          <h2>✍️ إجابتك</h2>
          {existing && <p style={{ marginBottom: '15px', fontWeight: 'bold' }}>{STATUS_LABELS[existing.status]}</p>}
          {existing?.status === 'graded' && (
            <div style={{ background: '#d1fae5', padding: '15px', borderRadius: '10px', marginBottom: '15px' }}>
              <p>الدرجة: {existing.grade} / {assessment.totalScore}</p>
              {existing.teacherNote && <p>ملاحظة الأستاذ: {existing.teacherNote}</p>}
            </div>
          )}
          <form onSubmit={submit} className="form">
            <textarea rows="5" placeholder="اكتب إجابتك المختصرة هنا..." value={answerText} onChange={e => setAnswerText(e.target.value)} />
            <label style={{ fontSize: '14px', color: '#6a4c93', fontWeight: 'bold' }}>📎 إرفاق ملف (اختياري)</label>
            <input type="file" onChange={e => setFile(e.target.files[0])} />
            {existing?.attachmentUrl && !file && (
              <p style={{ fontSize: '13px' }}>ملف مرفق حالياً: <a href={existing.attachmentUrl} target="_blank" rel="noreferrer">عرضه</a></p>
            )}
            <button type="submit" className="btn-primary" disabled={busy}>
              {busy ? 'جارٍ الإرسال...' : (existing ? 'تحديث الإجابة' : 'إرسال الإجابة')}
            </button>
          </form>
        </div>
      </main>
    </div>
  )
}
FILEEOF

echo "✅ تم التحويل الكامل لـ Supabase - شغّل: npm run dev"
