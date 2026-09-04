import { useState } from 'react'
import { QUESTION_TYPES, LESSON_ACTIVITY_TYPES, DIFFICULTY_LEVELS } from '../../data/constants.js'
import { db } from '../../data/supabaseApi.js'

const emptyForm = {
  lessonId: '', activity: 'practice', difficulty: 'easy', type: 'multiple-choice',
  questionText: '', score: 2,
  opt1: '', opt2: '', opt3: '', opt4: '', correctAnswer: '', imageUrl: '',
  tfAnswer: 'true', matchLeft: '', matchRight: '', tokens: '',
  multiOptions: '', multiAnswers: '',
  categories: '', classifyItems: ''
}

export default function QuestionsPanel({ data, setData }) {
  const [editingId, setEditingId] = useState(null)
  const [busy, setBusy] = useState(false)
  const [form, setForm] = useState(emptyForm)
  const set = (patch) => setForm({ ...form, ...patch })

  const startEdit = (q) => {
    setEditingId(q.id)
    const base = { lessonId: q.lessonId, activity: q.activity, difficulty: q.difficulty, type: q.type, questionText: q.questionText, score: q.score }
    if (q.type === 'multiple-choice' || q.type === 'picture-word') {
      setForm({ ...emptyForm, ...base, opt1: q.data.options[0] || '', opt2: q.data.options[1] || '', opt3: q.data.options[2] || '', opt4: q.data.options[3] || '', correctAnswer: q.data.answer, imageUrl: q.data.imageUrl || '' })
    } else if (q.type === 'multiple-select') {
      setForm({ ...emptyForm, ...base, multiOptions: q.data.options.join(', '), multiAnswers: q.data.answers.join(', ') })
    } else if (q.type === 'true-false') {
      setForm({ ...emptyForm, ...base, tfAnswer: String(q.data.answer) })
    } else if (q.type === 'fill-blank') {
      setForm({ ...emptyForm, ...base, correctAnswer: q.data.answer })
    } else if (q.type === 'dropdown') {
      setForm({ ...emptyForm, ...base, multiOptions: q.data.options.join(', '), correctAnswer: q.data.answer })
    } else if (q.type === 'matching') {
      setForm({ ...emptyForm, ...base, matchLeft: q.data.pairs.map(p => p.left).join(', '), matchRight: q.data.pairs.map(p => p.right).join(', ') })
    } else if (q.type === 'reordering') {
      setForm({ ...emptyForm, ...base, tokens: q.data.tokens.join(', ') })
    } else if (q.type === 'classification') {
      setForm({ ...emptyForm, ...base, categories: q.data.categories.join(', '), classifyItems: q.data.items.map(it => `${it.word}=${it.category}`).join(', ') })
    }
  }
  const cancelEdit = () => { setEditingId(null); setForm(emptyForm) }

  const buildData = () => {
    switch (form.type) {
      case 'multiple-choice':
      case 'picture-word':
        return { options: [form.opt1, form.opt2, form.opt3, form.opt4].filter(Boolean), answer: form.correctAnswer, ...(form.type === 'picture-word' ? { imageUrl: form.imageUrl } : {}) }
      case 'multiple-select':
        return { options: form.multiOptions.split(',').map(s => s.trim()).filter(Boolean), answers: form.multiAnswers.split(',').map(s => s.trim()).filter(Boolean) }
      case 'true-false':
        return { answer: form.tfAnswer === 'true' }
      case 'fill-blank':
        return { answer: form.correctAnswer }
      case 'dropdown':
        return { options: form.multiOptions.split(',').map(s => s.trim()).filter(Boolean), answer: form.correctAnswer }
      case 'matching': {
        const lefts = form.matchLeft.split(',').map(s => s.trim())
        const rights = form.matchRight.split(',').map(s => s.trim())
        return { pairs: lefts.map((l, i) => ({ left: l, right: rights[i] || '' })) }
      }
      case 'reordering': {
        const tokens = form.tokens.split(',').map(s => s.trim())
        return { tokens: [...tokens], correctOrder: tokens }
      }
      case 'classification': {
        const categories = form.categories.split(',').map(s => s.trim()).filter(Boolean)
        const items = form.classifyItems.split(',').map(pair => {
          const [word, category] = pair.split('=').map(s => s.trim())
          return { word, category }
        }).filter(it => it.word)
        return { categories, items }
      }
      default: return {}
    }
  }

  const submitForm = async (e) => {
    e.preventDefault()
    setBusy(true)
    try {
      const payload = {
        lessonId: parseInt(form.lessonId), activity: form.activity, difficulty: form.difficulty,
        type: form.type, questionText: form.questionText, score: parseInt(form.score) || 2, data: buildData()
      }
      if (editingId) {
        const patch = { ...payload, isActive: true }
        await db.questions.update(editingId, patch)
        setData({ ...data, questions: data.questions.map(q => q.id === editingId ? { ...q, ...payload } : q) })
      } else {
        const saved = await db.questions.add({ ...payload, isActive: true })
        setData({ ...data, questions: [...data.questions, saved] })
      }
      cancelEdit()
    } catch (err) {
      alert('❌ خطأ: ' + err.message)
    } finally {
      setBusy(false)
    }
  }

  const deleteQuestion = async (id) => {
    if (window.confirm('حذف السؤال؟')) {
      await db.questions.delete(id)
      setData({ ...data, questions: data.questions.filter(q => q.id !== id) })
      if (editingId === id) cancelEdit()
    }
  }

  return (
    <div className="panel">
      <div className="card">
        <h2>{editingId ? '✏️ تعديل السؤال' : '❓ إضافة سؤال جديد'}</h2>
        <form onSubmit={submitForm} className="form">
          <div className="form-row">
            <select required value={form.lessonId} onChange={e => set({ lessonId: e.target.value })}>
              <option value="">اختر الدرس</option>
              {data.lessons.map(l => <option key={l.id} value={l.id}>{l.title} ({l.level})</option>)}
            </select>
            <select required value={form.activity} onChange={e => set({ activity: e.target.value })}>
              {LESSON_ACTIVITY_TYPES.map(a => <option key={a.id} value={a.id}>{a.nameAr}</option>)}
            </select>
            <select required value={form.difficulty} onChange={e => set({ difficulty: e.target.value })}>
              {DIFFICULTY_LEVELS.map(d => <option key={d.id} value={d.id}>{d.nameAr}</option>)}
            </select>
          </div>

          <select value={form.type} onChange={e => set({ type: e.target.value })}>
            {QUESTION_TYPES.map(t => <option key={t.id} value={t.id}>{t.nameAr}</option>)}
          </select>

          <textarea placeholder="نص السؤال" required value={form.questionText} onChange={e => set({ questionText: e.target.value })} />

          {(form.type === 'multiple-choice' || form.type === 'picture-word') && (
            <>
              {form.type === 'picture-word' && <input placeholder="رابط الصورة" value={form.imageUrl} onChange={e => set({ imageUrl: e.target.value })} />}
              <div className="form-row">
                <input placeholder="الخيار 1" required value={form.opt1} onChange={e => set({ opt1: e.target.value })} />
                <input placeholder="الخيار 2" required value={form.opt2} onChange={e => set({ opt2: e.target.value })} />
                <input placeholder="الخيار 3" value={form.opt3} onChange={e => set({ opt3: e.target.value })} />
                <input placeholder="الخيار 4" value={form.opt4} onChange={e => set({ opt4: e.target.value })} />
              </div>
              <input placeholder="الإجابة الصحيحة (مطابقة لأحد الخيارات)" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
            </>
          )}

          {form.type === 'multiple-select' && (
            <>
              <input placeholder="كل الخيارات مفصولة بفاصلة: cat, dog, car, book" required value={form.multiOptions} onChange={e => set({ multiOptions: e.target.value })} />
              <input placeholder="الإجابات الصحيحة (أكثر من واحدة): cat, dog" required value={form.multiAnswers} onChange={e => set({ multiAnswers: e.target.value })} />
            </>
          )}

          {form.type === 'true-false' && (
            <select required value={form.tfAnswer} onChange={e => set({ tfAnswer: e.target.value })}>
              <option value="true">صح</option>
              <option value="false">خطأ</option>
            </select>
          )}

          {form.type === 'fill-blank' && (
            <input placeholder="الإجابة الصحيحة" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
          )}

          {form.type === 'dropdown' && (
            <>
              <input placeholder="كل الخيارات مفصولة بفاصلة: am, is, are" required value={form.multiOptions} onChange={e => set({ multiOptions: e.target.value })} />
              <input placeholder="الإجابة الصحيحة" required value={form.correctAnswer} onChange={e => set({ correctAnswer: e.target.value })} />
            </>
          )}

          {form.type === 'matching' && (
            <div className="form-row">
              <input placeholder="العناصر اليسرى: Apple, Dog" required value={form.matchLeft} onChange={e => set({ matchLeft: e.target.value })} />
              <input placeholder="المقابل بنفس الترتيب: تفاحة, كلب" required value={form.matchRight} onChange={e => set({ matchRight: e.target.value })} />
            </div>
          )}

          {form.type === 'reordering' && (
            <input placeholder="الكلمات مرتبة صحيحة: I, am, a, student" required value={form.tokens} onChange={e => set({ tokens: e.target.value })} />
          )}

          {form.type === 'classification' && (
            <>
              <input placeholder="الفئات مفصولة بفاصلة: Food, Animals" required value={form.categories} onChange={e => set({ categories: e.target.value })} />
              <input placeholder="العناصر=الفئة مفصولة بفاصلة: Apple=Food, Dog=Animals" required value={form.classifyItems} onChange={e => set({ classifyItems: e.target.value })} />
            </>
          )}

          <div className="form-row">
            <input type="number" placeholder="الدرجة" min="1" value={form.score} onChange={e => set({ score: e.target.value })} />
          </div>

          <div className="form-row">
            <button type="submit" className="btn-primary" disabled={busy}>{busy ? '...' : (editingId ? 'حفظ التعديل' : 'إضافة السؤال')}</button>
            {editingId && <button type="button" className="btn-secondary" onClick={cancelEdit}>إلغاء</button>}
          </div>
        </form>
      </div>

      <div className="card">
        <h2>الأسئلة المضافة ({data.questions.length})</h2>
        {data.questions.length === 0 ? <p className="empty">لا توجد أسئلة بعد</p> : (
          <div className="list">
            {data.questions.map(q => (
              <div key={q.id} className="list-item">
                <div>
                  <strong>{q.questionText}</strong>
                  <p>{QUESTION_TYPES.find(t => t.id === q.type)?.nameAr} | {q.activity} | {q.difficulty} | {q.score} نقاط</p>
                </div>
                <div className="row-actions">
                  <button className="btn-secondary" onClick={() => startEdit(q)}>تعديل</button>
                  <button className="btn-delete" onClick={() => deleteQuestion(q.id)}>🗑️</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
