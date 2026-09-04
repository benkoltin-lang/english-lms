// ============================================
// هيكل عام: المرحلة (Stage) -> المستوى (Level) -> الفصل (Term) -> التسلسل (Sequence) -> الدرس (Lesson)
// هذا الملف فارغ من المحتوى الدراسي الفعلي - فقط الهيكل التنظيمي
// ============================================

export const STAGES = [
  { id: 'primary', nameAr: 'ابتدائي' },
  { id: 'middle', nameAr: 'متوسط' }
]

export const LEVELS = [
  { id: '3PS', stage: 'primary', nameAr: 'الثالثة ابتدائي' },
  { id: '4PS', stage: 'primary', nameAr: 'الرابعة ابتدائي' },
  { id: '5PS', stage: 'primary', nameAr: 'الخامسة ابتدائي' },
  { id: '1MS', stage: 'middle', nameAr: 'الأولى متوسط' },
  { id: '2MS', stage: 'middle', nameAr: 'الثانية متوسط' },
  { id: '3MS', stage: 'middle', nameAr: 'الثالثة متوسط' },
  { id: '4MS', stage: 'middle', nameAr: 'الرابعة متوسط' }
]

export const TERMS = [
  { id: 1, nameAr: 'الفصل الأول' },
  { id: 2, nameAr: 'الفصل الثاني' },
  { id: 3, nameAr: 'الفصل الثالث' }
]

// أنواع الأنشطة المرتبطة بالدرس العادي (وليس التقييمات)
export const LESSON_ACTIVITY_TYPES = [
  { id: 'practice', nameAr: 'تطبيق' },
  { id: 'review', nameAr: 'مراجعة' }
]

// أنواع التقييمات (مستقلة عن الدروس العادية)
export const ASSESSMENT_TYPES = [
  { id: 'assignment', nameAr: 'فرض' },
  { id: 'exam', nameAr: 'امتحان' }
]

// مستويات صعوبة السؤال
export const DIFFICULTY_LEVELS = [
  { id: 'easy', nameAr: 'سهل' },
  { id: 'medium', nameAr: 'متوسط' },
  { id: 'hard', nameAr: 'صعب' }
]

// أنواع الأسئلة المعتمدة في المرحلة الأولى (الأساسية الستة)
// كل نوع له شكل "data" مختلف - انظر schema.js للتفاصيل
export const QUESTION_TYPES = [
  { id: 'multiple-choice', nameAr: 'اختيار من متعدد' },
  { id: 'multiple-select', nameAr: 'اختيار متعدد الإجابات' },
  { id: 'true-false', nameAr: 'صح أو خطأ' },
  { id: 'fill-blank', nameAr: 'أكمل الفراغ' },
  { id: 'dropdown', nameAr: 'قائمة منسدلة' },
  { id: 'matching', nameAr: 'وصّل' },
  { id: 'reordering', nameAr: 'رتب الكلمات' },
  { id: 'picture-word', nameAr: 'صورة وكلمة' },
  { id: 'classification', nameAr: 'تصنيف' }
]
