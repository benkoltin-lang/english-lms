import { useState } from 'react'
import StudentsPanel from './StudentsPanel.jsx'
import LessonsPanel from './LessonsPanel.jsx'
import QuestionsPanel from './QuestionsPanel.jsx'
import AssessmentsPanel from './AssessmentsPanel.jsx'
import GradingPanel from './GradingPanel.jsx'
import ResultsPanel from './ResultsPanel.jsx'

const TABS = [
  { id: 'students', label: '👥 التلاميذ' },
  { id: 'lessons', label: '📚 الدروس' },
  { id: 'questions', label: '❓ الأسئلة' },
  { id: 'assessments', label: '📝 الفروض والامتحانات' },
  { id: 'grading', label: '✅ تصحيح الفروض' },
  { id: 'results', label: '📊 النتائج' }
]

export default function TeacherDashboard({ data, setData, onLogout }) {
  const [tab, setTab] = useState('students')

  return (
    <div className="app">
      <header className="header">
        <h1>👨‍🏫 لوحة تحكم الأستاذ</h1>
        <button className="logout-btn" onClick={onLogout}>خروج</button>
      </header>

      <nav className="tabs">
        {TABS.map(t => (
          <button
            key={t.id}
            className={`tab ${tab === t.id ? 'active' : ''}`}
            onClick={() => setTab(t.id)}
          >
            {t.label}
          </button>
        ))}
      </nav>

      <main className="main">
        {tab === 'students' && <StudentsPanel data={data} setData={setData} />}
        {tab === 'lessons' && <LessonsPanel data={data} setData={setData} />}
        {tab === 'questions' && <QuestionsPanel data={data} setData={setData} />}
        {tab === 'assessments' && <AssessmentsPanel data={data} setData={setData} />}
        {tab === 'grading' && <GradingPanel data={data} setData={setData} />}
        {tab === 'results' && <ResultsPanel data={data} />}
      </main>
    </div>
  )
}
