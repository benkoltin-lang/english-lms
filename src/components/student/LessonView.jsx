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
      {lesson.vocabHelp && lesson.vocabHelp.length > 0 && (
        <div style={{ marginTop: '20px', padding: '15px', background: '#fffbea', borderRadius: '12px', border: '2px solid #f0d060' }}>
          <h3 style={{ color: '#b8860b', marginBottom: '12px' }}>📖 مساعدة لغوية</h3>
          {lesson.vocabHelp.map((item, i) => (
            <div key={i} style={{ marginBottom: '10px', padding: '10px', background: '#fff', borderRadius: '8px', borderRight: '4px solid #f0d060' }}>
              <strong style={{ color: '#333', fontSize: '16px' }}>{item.word}</strong>
              <span style={{ color: '#6a4c93', marginRight: '8px', marginLeft: '8px' }}>←</span>
              <span style={{ color: '#e63946', fontWeight: 'bold' }}>{item.arabic}</span>
              {item.synonyms && item.synonyms.length > 0 && (
                <div style={{ marginTop: '4px', fontSize: '13px', color: '#555' }}>
                  <span style={{ color: '#2d6a4f', fontWeight: 'bold' }}>= </span>
                  {item.synonyms.join(' / ')}
                </div>
              )}
              {item.opposites && item.opposites.length > 0 && (
                <div style={{ fontSize: '13px', color: '#555' }}>
                  <span style={{ color: '#e63946', fontWeight: 'bold' }}>≠ </span>
                  {item.opposites.join(' / ')}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
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
