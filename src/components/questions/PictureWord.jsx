// data = { imageUrl, options: ["cat","dog","bird"], answer: "cat" }
export default function PictureWord({ data, value, onChange, disabled }) {
  return (
    <div className="q-picture">
      {data.imageUrl && (
        <div className="q-picture-frame">
          <img src={data.imageUrl} alt="سؤال" />
        </div>
      )}
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
    </div>
  )
}
