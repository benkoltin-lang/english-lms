export default function FillBlank({ value, onChange, disabled }) {
  return (
    <input
      type="text"
      className="q-fill-input"
      placeholder="اكتب الإجابة هنا..."
      value={value || ''}
      onChange={e => onChange(e.target.value)}
      disabled={disabled}
    />
  )
}
