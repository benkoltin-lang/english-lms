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
