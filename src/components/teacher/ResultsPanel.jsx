import { useState } from 'react'
import { LEVELS } from '../../data/constants.js'

export default function ResultsPanel({ data }) {
  const [filterLevel, setFilterLevel] = useState('')
  const [filterStudent, setFilterStudent] = useState('')

  const studentName = (id) => data.students.find(s => s.id === id)?.name || 'غير معروف'
  const studentLevel = (id) => data.students.find(s => s.id === id)?.level || ''
  const lessonTitle = (id) => data.lessons.find(l => l.id === id)?.title || '—'

  const filtered = data.results.filter(r =>
    (!filterLevel || studentLevel(r.studentId) === filterLevel) &&
    (!filterStudent || r.studentId === parseInt(filterStudent))
  ).sort((a, b) => new Date(b.answeredAt) - new Date(a.answeredAt))

  const activityLabel = { practice: 'تطبيق', review: 'مراجعة' }

  return (
    <div className="panel">
      <div className="card">
        <h2>📊 نتائج التلاميذ في الأنشطة</h2>
        <div className="form-row" style={{ marginBottom: '20px' }}>
          <select value={filterLevel} onChange={e => setFilterLevel(e.target.value)}>
            <option value="">كل المستويات</option>
            {LEVELS.map(l => <option key={l.id} value={l.id}>{l.nameAr} ({l.id})</option>)}
          </select>
          <select value={filterStudent} onChange={e => setFilterStudent(e.target.value)}>
            <option value="">كل التلاميذ</option>
            {data.students.map(s => <option key={s.id} value={s.id}>{s.name}</option>)}
          </select>
        </div>

        {filtered.length === 0 ? <p className="empty">لا توجد نتائج بعد</p> : (
          <div className="list">
            {filtered.map(r => {
              const percent = r.totalScore > 0 ? Math.round((r.score / r.totalScore) * 100) : 0
              return (
                <div key={r.id} className="list-item">
                  <div>
                    <strong>{studentName(r.studentId)}</strong>
                    <p>{lessonTitle(r.lessonId)} | {activityLabel[r.activity]} | {r.score}/{r.totalScore} ({percent}%)</p>
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>
    </div>
  )
}
