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
