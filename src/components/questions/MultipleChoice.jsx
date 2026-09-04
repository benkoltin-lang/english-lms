export default function MultipleChoice({ data, value, onChange, disabled }) {
  return (
    <div className="q-options">
      {data.options.map((opt, i) => (
        <button
          key={i}
          type="button"
          className={`q-option ${value === opt ? 'selected' : ''} ${disabled && opt === data.answer ? 'correct' : ''}`}
          onClick={() => !disabled && onChange(opt)}
          disabled={disabled}
        >
          {opt}
        </button>
      ))}
    </div>
  )
}
