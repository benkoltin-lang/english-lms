import MultipleChoice from './MultipleChoice.jsx'
import MultipleSelect from './MultipleSelect.jsx'
import TrueFalse from './TrueFalse.jsx'
import FillBlank from './FillBlank.jsx'
import Dropdown from './Dropdown.jsx'
import Matching from './Matching.jsx'
import Reordering from './Reordering.jsx'
import PictureWord from './PictureWord.jsx'
import Classification from './Classification.jsx'

export default function QuestionRenderer({ question, value, onChange, disabled }) {
  switch (question.type) {
    case 'multiple-choice':
      return <MultipleChoice data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'multiple-select':
      return <MultipleSelect data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'true-false':
      return <TrueFalse value={value} onChange={onChange} disabled={disabled} />
    case 'fill-blank':
      return <FillBlank value={value} onChange={onChange} disabled={disabled} />
    case 'dropdown':
      return <Dropdown data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'matching':
      return <Matching data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'reordering':
      return <Reordering data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'picture-word':
      return <PictureWord data={question.data} value={value} onChange={onChange} disabled={disabled} />
    case 'classification':
      return <Classification data={question.data} value={value} onChange={onChange} disabled={disabled} />
    default:
      return <p>⚠️ نوع سؤال غير مدعوم: {question.type}</p>
  }
}

export function gradeAnswer(question, userAnswer) {
  const d = question.data
  switch (question.type) {
    case 'multiple-choice':
    case 'picture-word':
    case 'dropdown':
      return userAnswer === d.answer
    case 'multiple-select': {
      if (!userAnswer) return false
      const a = [...userAnswer].sort()
      const b = [...d.answers].sort()
      return JSON.stringify(a) === JSON.stringify(b)
    }
    case 'true-false':
      return userAnswer === d.answer
    case 'fill-blank':
      return (userAnswer || '').trim().toLowerCase() === (d.answer || '').trim().toLowerCase()
    case 'matching':
      if (!userAnswer) return false
      return d.pairs.every(p => userAnswer[p.left] === p.right)
    case 'reordering':
      if (!userAnswer) return false
      return JSON.stringify(userAnswer) === JSON.stringify(d.correctOrder)
    case 'classification':
      if (!userAnswer) return false
      return d.items.every(item => userAnswer[item.word] === item.category)
    default:
      return false
  }
}
