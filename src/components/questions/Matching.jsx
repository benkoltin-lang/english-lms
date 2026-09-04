// data.pairs = [{ left: "Apple", right: "تفاحة" }, ...]
// نسخة أولية: قوائم منسدلة لكل عنصر يسار يختار له التلميذ العنصر المقابل
export default function Matching({ data, value, onChange, disabled }) {
  const answers = value || {}
  const rightOptions = data.pairs.map(p => p.right)

  const setPair = (leftItem, rightItem) => {
    onChange({ ...answers, [leftItem]: rightItem })
  }

  return (
    <div className="q-matching">
      {data.pairs.map((pair, i) => (
        <div key={i} className="q-matching-row">
          <span className="q-matching-left">{pair.left}</span>
          <select
            value={answers[pair.left] || ''}
            onChange={e => setPair(pair.left, e.target.value)}
            disabled={disabled}
          >
            <option value="">اختر...</option>
            {rightOptions.map((r, j) => <option key={j} value={r}>{r}</option>)}
          </select>
        </div>
      ))}
    </div>
  )
}
