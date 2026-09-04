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
