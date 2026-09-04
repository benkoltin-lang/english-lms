// data = { options: [...], answer: "" }
export default function Dropdown({ data, value, onChange, disabled }) {
  return (
    <select
      className="q-dropdown"
      value={value || ''}
      onChange={e => onChange(e.target.value)}
      disabled={disabled}
      style={{ width: '100%', padding: '14px', fontSize: '16px', borderRadius: '10px', border: '2px solid #dfccf1', margin: '15px 0' }}
    >
      <option value="">اختر الإجابة...</option>
      {data.options.map((opt, i) => <option key={i} value={opt}>{opt}</option>)}
    </select>
  )
}
