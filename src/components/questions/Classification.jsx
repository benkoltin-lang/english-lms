// data = { categories: ["Food","Animals"], items: [{ word: "Apple", category: "Food" }, ...] }
export default function Classification({ data, value, onChange, disabled }) {
  const answers = value || {}

  const setCategory = (word, category) => {
    onChange({ ...answers, [word]: category })
  }

  return (
    <div className="q-classification">
      {data.items.map((item, i) => (
        <div key={i} className="q-matching-row">
          <span className="q-matching-left">{item.word}</span>
          <select
            value={answers[item.word] || ''}
            onChange={e => setCategory(item.word, e.target.value)}
            disabled={disabled}
          >
            <option value="">اختر الفئة...</option>
            {data.categories.map((c, j) => <option key={j} value={c}>{c}</option>)}
          </select>
        </div>
      ))}
    </div>
  )
}
