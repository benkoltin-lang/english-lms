export default function StudentDashboard({ data, student, onOpenLesson, onOpenAssessment, onLogout }) {
  const lessons = data.lessons.filter(
    l => l.level === student.level && l.term === student.currentTerm && l.isActive
  )
  const assessments = data.assessments.filter(
    a => a.level === student.level && a.term === student.currentTerm && a.isActive
  )

  const mySubmission = (assessmentId) =>
    data.submissions.find(s => s.assessmentId === assessmentId && s.studentId === student.id)

  const statusLabel = {
    submitted: '📤 تم الإرسال', reviewing: '👀 قيد المراجعة',
    graded: '✅ تم التصحيح', returned: '↩️ تم الإرجاع'
  }

  return (
    <div className="app">
      <header className="header student-header">
        <div>
          <h1>🌐 English Platform</h1>
          <p>مرحباً، {student.name} ({student.level})</p>
        </div>
        <button className="logout-btn" onClick={onLogout}>خروج</button>
      </header>

      <main className="main">
        <div className="card">
          <h2>📚 دروسك المتاحة ({lessons.length})</h2>
          {lessons.length === 0 ? <p className="empty">لا توجد دروس متاحة حالياً</p> : (
            <div className="list">
              {lessons.map(l => (
                <div key={l.id} className="list-item" style={{ cursor: 'pointer' }} onClick={() => onOpenLesson(l)}>
                  <div>
                    <strong>{l.title}</strong>
                    <p>{l.sequence}</p>
                  </div>
                  <span>←</span>
                </div>
              ))}
            </div>
          )}
        </div>

        <div className="card">
          <h2>📝 الفروض والامتحانات ({assessments.length})</h2>
          {assessments.length === 0 ? <p className="empty">لا توجد فروض أو امتحانات حالياً</p> : (
            <div className="list">
              {assessments.map(a => {
                const sub = mySubmission(a.id)
                return (
                  <div key={a.id} className="list-item" style={{ cursor: 'pointer' }} onClick={() => onOpenAssessment(a)}>
                    <div>
                      <strong>{a.title}</strong>
                      <p>تسليم قبل {a.dueDate} {sub ? `| ${statusLabel[sub.status]}` : '| لم يُرسل بعد'}</p>
                    </div>
                    <span>←</span>
                  </div>
                )
              })}
            </div>
          )}
        </div>
      </main>
    </div>
  )
}
