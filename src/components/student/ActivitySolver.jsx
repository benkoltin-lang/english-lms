import { useState } from 'react'
import QuestionRenderer, { gradeAnswer } from '../questions/QuestionRenderer.jsx'

export default function ActivitySolver({ lesson, activity, questions, student, onFinish, onSaveResult }) {
  const [index, setIndex] = useState(0)
  const [answers, setAnswers] = useState({})
  const [showResults, setShowResults] = useState(false)

  const question = questions[index]
  const isLast = index === questions.length - 1

  const setAnswer = (val) => setAnswers({ ...answers, [question.id]: val })

  const totalScore = questions.reduce((acc, q) => acc + q.score, 0)
  const earnedScore = questions.reduce(
    (acc, q) => acc + (gradeAnswer(q, answers[q.id]) ? q.score : 0), 0
  )

  const submit = () => {
    setShowResults(true)
    onSaveResult({
      id: Date.now(),
      studentId: student.id,
      lessonId: lesson.id,
      activity,
      score: earnedScore,
      totalScore,
      answeredAt: new Date().toISOString()
    })
  }

  const activityLabel = activity === 'practice' ? 'تطبيق' : 'مراجعة'

  return (
    <div className="card">
      <div className="question-header" style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '20px' }}>
        <span>{activityLabel} — سؤال {index + 1} / {questions.length}</span>
        <span>💯 {question.score} نقطة</span>
      </div>

      <h3 style={{ marginBottom: '20px' }}>{question.questionText}</h3>

      <QuestionRenderer
        question={question}
        value={answers[question.id]}
        onChange={setAnswer}
        disabled={showResults}
      />

      {!showResults && (
        <div className="form-row" style={{ marginTop: '25px' }}>
          {index > 0 && (
            <button className="btn-secondary" onClick={() => setIndex(i => i - 1)}>← السابق</button>
          )}
          {!isLast ? (
            <button className="btn-primary" onClick={() => setIndex(i => i + 1)}>التالي →</button>
          ) : (
            <button className="btn-primary" onClick={submit}>✅ تسليم</button>
          )}
        </div>
      )}

      {showResults && (
        <div className="results" style={{ textAlign: 'center', marginTop: '30px', padding: '25px', background: '#d1fae5', borderRadius: '12px' }}>
          <h3>🎉 النتيجة</h3>
          <p style={{ fontSize: '32px', fontWeight: 'bold', margin: '15px 0' }}>{earnedScore} / {totalScore}</p>
          <button className="btn-primary" onClick={onFinish}>العودة للدرس</button>
        </div>
      )}
    </div>
  )
}
