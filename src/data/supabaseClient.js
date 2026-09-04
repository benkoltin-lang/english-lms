import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'https://panylticaatcdkngdkkg.supabase.co'
const supabaseKey = 'sb_publishable_LquqwGV-VUgVsPRY3d-Ltg_DXoK7TOt'

export const supabase = createClient(supabaseUrl, supabaseKey)
