// data.tokens = ["is", "Ali", "a", "student"]
// نسخة أولية: التلميذ يضغط الكلمات بالترتيب الذي يريده
export default function Reordering({ data, value, onChange, disabled }) {
  const selected = value || []
  const remaining = data.tokens.filter(t => !selected.includes(t))

  const addToken = (token) => {
    onChange([...selected, token])
  }
  const reset = () => onChange([])

  return (
    <div className="q-reorder">
      <div className="q-reorder-answer">
        {selected.length === 0 && <span className="q-reorder-placeholder">اضغط الكلمات بالترتيب...</span>}
        {selected.map((t, i) => <span key={i} className="q-token placed">{t}</span>)}
      </div>
      <div className="q-reorder-bank">
        {remaining.map((t, i) => (
          <button key={i} type="button" className="q-token" onClick={() => !disabled && addToken(t)} disabled={disabled}>
            {t}
          </button>
        ))}
      </div>
      {!disabled && selected.length > 0 && (
        <button type="button" className="q-reset-btn" onClick={reset}>↺ إعادة</button>
      )}
    </div>
  )
}
