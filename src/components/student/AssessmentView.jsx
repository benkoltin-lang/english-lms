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
