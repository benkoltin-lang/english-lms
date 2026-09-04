export default function TrueFalse({ value, onChange, disabled }) {
  return (
    <div className="q-tf">
      <button
        type="button"
        className={`q-option ${value === true ? 'selected' : ''}`}
        onClick={() => !disabled && onChange(true)}
        disabled={disabled}
      >✅ صح</button>
      <button
        type="button"
        className={`q-option ${value === false ? 'selected' : ''}`}
        onClick={() => !disabled && onChange(false)}
        disabled={disabled}
      >❌ خطأ</button>
    </div>
  )
}
