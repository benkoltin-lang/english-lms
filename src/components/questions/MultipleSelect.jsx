// data = { options: [...], answers: [...] } - أكثر من إجابة صحيحة
export default function MultipleSelect({ data, value, onChange, disabled }) {
  const selected = value || []

  const toggle = (opt) => {
    if (selected.includes(opt)) {
      onChange(selected.filter(o => o !== opt))
    } else {
      onChange([...selected, opt])
    }
  }

  return (
    <div className="q-options">
      {data.options.map((opt, i) => {
        const isCorrect = disabled && data.answers.includes(opt)
        return (
          <button
            key={i}
            type="button"
            className={`q-option ${selected.includes(opt) ? 'selected' : ''} ${isCorrect ? 'correct' : ''}`}
            onClick={() => !disabled && toggle(opt)}
            disabled={disabled}
          >
            {selected.includes(opt) ? '☑ ' : '☐ '}{opt}
          </button>
        )
      })}
    </div>
  )
}
