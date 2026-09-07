export default function SequenceIntro3MS({ onStart }) {
  return (
    <div style={{ padding: '20px', maxWidth: '600px', margin: '0 auto', fontFamily: 'sans-serif' }}>

      {/* العنوان */}
      <div style={{ background: 'linear-gradient(135deg, #27ae60, #2ecc71)', borderRadius: '15px', padding: '20px', textAlign: 'center', color: 'white', marginBottom: '20px' }}>
        <h1 style={{ margin: 0, fontSize: '20px' }}>📚 Sequence 01 - 3MS</h1>
        <p style={{ margin: '8px 0 0', fontSize: '14px', opacity: 0.9 }}>Me, My Abilities, My Interests, and My Personality</p>
        <p style={{ margin: '4px 0 0', fontSize: '12px', opacity: 0.8 }}>السنة الثالثة متوسط</p>
      </div>

      {/* الوضعية الانطلاقية */}
      <div style={{ background: '#e8f8f0', borderRadius: '12px', padding: '15px', marginBottom: '15px', borderRight: '4px solid #27ae60' }}>
        <h3 style={{ color: '#27ae60', margin: '0 0 8px' }}>🌍 الوضعية الانطلاقية</h3>
        <p style={{ margin: 0, fontSize: '14px', lineHeight: 1.6 }}>
          مجلة المدرسة تطلب منك كتابة مقال للتعريف بنفسك: شخصيتك، اهتماماتك، قدراتك. اكتب <strong>Self Introduction</strong> لتنشره في المجلة المدرسية.
        </p>
      </div>

      {/* ملخص الدروس */}
      <div style={{ background: '#fff', borderRadius: '12px', padding: '15px', marginBottom: '15px', boxShadow: '0 2px 8px rgba(0,0,0,0.1)' }}>
        <h3 style={{ color: '#27ae60', margin: '0 0 12px' }}>📋 ستتعلم في هذا المحور</h3>
        {[
          { icon: '❤️', title: 'Likes & Interests', ar: 'التعبير عن الاهتمامات والهوايات', color: '#e74c3c' },
          { icon: '🏃', title: 'Gerunds (verb + ing)', ar: 'قواعد تصريف الفعل المضاف إليه ing', color: '#e67e22' },
          { icon: '⏰', title: 'Always / Never', ar: 'ظروف التكرار', color: '#f39c12' },
          { icon: '💪', title: 'Can / Cannot', ar: 'التعبير عن القدرة وعدم القدرة', color: '#2980b9' },
          { icon: '😊', title: 'Personality Adjectives', ar: 'صفات الشخصية + البادئات السلبية', color: '#8e44ad' },
          { icon: '✍️', title: 'Self Introduction', ar: 'كتابة فقرة التعريف بالنفس', color: '#27ae60' },
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
          <strong style={{ color: '#e74c3c' }}>❤️ Likes & Interests:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            I like/love/enjoy + verb-ing<br/>
            I am keen on / interested in / fond of + verb-ing
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#e67e22' }}>🏃 Gerunds (verb + ing):</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            play → playing | dance → dancing | swim → swimming<br/>
            <small>+ ing / drop e + ing / double consonant + ing</small>
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#f39c12' }}>⏰ Always / Never:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            I always play football. ✅ (before main verb)<br/>
            She is never late. ✅ (after to be)
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#2980b9' }}>💪 Can / Cannot:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            I can swim. / I cannot fly.<br/>
            Can + subject + base verb?
          </p>
        </div>

        <div style={{ marginBottom: '12px' }}>
          <strong style={{ color: '#8e44ad' }}>😊 Personality + Prefixes:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            un-: unhappy | im-: impolite | dis-: dishonest<br/>
            ir-: irresponsible | il-: illegal | in-: inactive
          </p>
        </div>

        <div>
          <strong style={{ color: '#27ae60' }}>✍️ Self Introduction:</strong>
          <p style={{ margin: '4px 0', fontSize: '13px', background: '#fff', padding: '8px', borderRadius: '6px' }}>
            My name is... I am... I live in...<br/>
            I am keen on... I am a ... person.<br/>
            I can..., but I cannot...
          </p>
        </div>
      </div>

      {/* زر البدء */}
      <button
        onClick={onStart}
        style={{ width: '100%', padding: '15px', background: 'linear-gradient(135deg, #27ae60, #2ecc71)', color: 'white', border: 'none', borderRadius: '12px', fontSize: '16px', fontWeight: 'bold', cursor: 'pointer' }}
      >
        🚀 ابدأ الدروس
      </button>
    </div>
  )
}
