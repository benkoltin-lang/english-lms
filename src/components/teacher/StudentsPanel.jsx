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
