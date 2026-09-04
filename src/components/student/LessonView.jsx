export default function LessonView({ data, lesson, onStartActivity, onBack }) {
  const lessonQuestions = data.questions.filter(q => q.lessonId === lesson.id && q.isActive)
  const practiceCount = lessonQuestions.filter(q => q.activity === 'practice').length
  const reviewCount = lessonQuestions.filter(q => q.activity === 'review').length

  return (
    <div className="app">
      <header className="header student-header">
        <div>
          <h1>{lesson.title}</h1>
          <p>{lesson.sequence} - {lesson.level}</p>
        </div>
        <button className="logout-btn" onClick={onBack}>رجوع</button>
      </header>

      <main className="main">
        <div className="card">
          <h2>📝 محتوى الدرس</h2>
          <div style={{ whiteSpace: 'pre-wrap', lineHeight: 1.8 }}>{lesson.content}</div>
        </div>

        {lesson.videoUrl && (
          <div className="card">
            <h2>🎥 فيديو</h2>
            <iframe
              width="100%" height="280"
              src={`https://www.youtube.com/embed/${lesson.videoUrl.split('v=')[1] || lesson.videoUrl.split('/').pop()}`}
              frameBorder="0" allowFullScreen title="lesson video"
              style={{ borderRadius: '12px' }}
            />
          </div>
        )}

        <div className="card">
          <h2>🎯 اختر النشاط</h2>
          <div className="form-row">
            <button className="btn-primary" onClick={() => onStartActivity('practice')} disabled={practiceCount === 0}>
              تطبيق ({practiceCount} سؤال)
            </button>
            <button className="btn-primary" onClick={() => onStartActivity('review')} disabled={reviewCount === 0}>
              مراجعة ({reviewCount} سؤال)
            </button>
          </div>
          {practiceCount === 0 && reviewCount === 0 && (
            <p className="empty">لا توجد أسئلة لهذا الدرس بعد</p>
          )}
        </div>
      </main>
    </div>
  )
}
