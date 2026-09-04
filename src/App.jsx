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
