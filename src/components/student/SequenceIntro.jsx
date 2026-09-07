export default function SequenceIntro({ onStart, student }) {
  const is3MS = student && student.level === "3MS"
  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '0 auto', fontFamily: 'sans-serif' }}>
      
      {/* العنوان */}
      <div style={{ background: 'linear-gradient(135deg, #6a4c93, #9b59b6)', borderRadius: '15px', padding: '20px', textAlign: 'center', color: 'white', marginBottom: '20px' }}>
        <h1 style={{ margin: 0, fontSize: '20px' }}>📚 Sequence 01</h1>
        <p style={{ margin: '8px 0 0', fontSize: '14px', opacity: 0.9 }}>{is3MS ? "Me, My Abilities, My Interests, and My Personality" : "Me, Universal Landmarks & Outstanding Figures"}</p>
        <p style={{ margin: '4px 0 0', fontSize: '12px', opacity: 0.8 }}>{is3MS ? "3ème Année Moyenne" : "in History, Literature & Arts"}</p>
      </div>

      {/* الوضعية الانطلاقية */}
      <div style={{ background: '#e8f4f8', borderRadius: '12px', padding: '15px', marginBottom: '15px', borderRight: '4px solid #3498db' }}>
        <h3 style={{ color: '#2980b9', margin: '0 0 8px' }}>🌍 الوضعية الانطلاقية</h3>
        <p style={{ margin: 0, fontSize: '14px', lineHeight: 1.6 }}>
          سائح إنجليزي يبحث عن معلومات حول الجزائر. فكّر في المعالم والشخصيات البارزة التي زرتها وحوّل هذه المعلومات إلى <strong>Travel Brochure</strong>.
        </p>
      </div>

      {/* ملخص الدروس */}
      <div style={{ background: '#fff', borderRadius: '12px', padding: '15px', marginBottom: '15px', boxShadow: '0 2px 8px rgba(0,0,0,0.1)' }}>
        <h3 style={{ color: '#6a4c93', margin: '0 0 12px' }}>📋 ستتعلم في هذا المحور</h3>
        
        {[
          { icon: '🏛️', title: 'Describing a Landmark', ar: 'وصف معلم سياحي', color: '#e74c3c' },
          { icon: '👤', title: 'Outstanding Figure / Biography', ar: 'السيرة الذاتية', color: '#e67e22' },
          { icon: '🗺️', title: 'Trip Itinerary', ar: 'مسار الرحلة + الروابط الزمنية', color: '#27ae60' },
          { icon: '🔊', title: 'Pronunciation /eɪ/ vs /aɪ/', ar: 'الأصوات المركبة', color: '#2980b9' },
          { icon: '🔤', title: 'Silent Letters', ar: 'الحروف الصامتة', color: '#8e44ad' },
        ].map((item, i) => (
          <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '10px', padding: '8px', marginBottom: '6px', background: '#f8f9fa', borderRadius: '8px' }}>
            <span style={{ fontSize: '20px' }}>{item.icon}</span>
            <div>
              <div style={{ fontWeight: 'bold', fontSize: '13px', color: item.color }}>{item.title}</div>
              <div style={{ fontSize: '12px', color: '#666' }}>{item.ar}</div>
            </div>
          </div>
        ))}
      </div>

      {/* القواعد المختصرة */}
      <div style={{ background: '#fffbea', borderRadius: '12px', padding: '15px', marginBottom: '15px', border: '2px solid #f0d060' }}>
        <h3 style={{ color: '#b8860b', margin: '0 0 12px' }}>💡 ملخص القواعد</h3>
        
        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#e74c3c' }}>🏛️ Landmark Paragraph:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            [Name] is a famous landmark in [Country].<br/>
            It was designed by [Architect]. It is [Height] meters high.<br/>
            It was opened on [Date].
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#e67e22' }}>👤 Biography:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            [Name] is an outstanding figure in [Field].<br/>
            He/She was born on [Date] in [Place].<br/>
            He/She was a [Occupation]. He/She died on [Date].
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#27ae60' }}>🗺️ Chronological Markers:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            <strong>First,</strong> → <strong>Then,</strong> → <strong>Next,</strong> → <strong>After that,</strong> → <strong>Finally,</strong>
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#2980b9' }}>🔊 Diphthongs:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            /eɪ/: day, make, play, famous, train<br/>
            /aɪ/: eye, like, life, child, write, height
          </p>
        </div>

        <div>
          <strong style={{ color: '#8e44ad' }}>🔤 Silent Letters:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            K: <em>knife, know, knee</em> | W: <em>write, wrong, who</em><br/>
            L: <em>should, walk, calm</em> | B: <em>climb, lamb, doubt</em><br/>
            N: <em>autumn, column</em>
          </p>
        </div>
      </div>

      {/* زر البدء */}
      <button
        onClick={onStart}
        style={{ width: '100%', padding: '15px', background: 'linear-gradient(135deg, #6a4c93, #9b59b6)', color: 'white', border: 'none', borderRadius: '12px', fontSize: '16px', fontWeight: 'bold', cursor: 'pointer' }}
      >
        🚀 ابدأ الدروس
      </button>
    </div>
  )
}
