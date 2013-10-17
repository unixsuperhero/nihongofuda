# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

kana_unicode_list = %w{
          0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
  304x    　  ぁ  あ  ぃ  い  ぅ  う  ぇ  え  ぉ  お  か  が  き  ぎ  く
  305x    ぐ  け  げ  こ  ご  さ  ざ  し  じ  す  ず  せ  ぜ  そ  ぞ  た
  306x    だ  ち  ぢ  っ  つ  づ  て  で  と  ど  な  に  ぬ  ね  の  は
  307x    ば  ぱ  ひ  び  ぴ  ふ  ぶ  ぷ  へ  べ  ぺ  ほ  ぼ  ぽ  ま  み
  308x    む  め  も  ゃ  や  ゅ  ゆ  ょ  よ  ら  り  る  れ  ろ  ゎ  わ
  309x    ゐ  ゑ  を  ん  ゔ  ゕ  ゖ  　  　   ゙     ゚  ゛  ゜  ゝ  ゞ  ゟ
  30Ax    ゠  ァ  ア  ィ  イ  ゥ  ウ  ェ  エ  ォ  オ  カ  ガ  キ  ギ  ク
  30Bx    グ  ケ  ゲ  コ  ゴ  サ  ザ  シ  ジ  ス  ズ  セ  ゼ  ソ  ゾ  タ
  30Cx    ダ  チ  ヂ  ッ  ツ  ヅ  テ  デ  ト  ド  ナ  ニ  ヌ  ネ  ノ  ハ
  30Dx    バ  パ  ヒ  ビ  ピ  フ  ブ  プ  ヘ  ベ  ペ  ホ  ボ  ポ  マ  ミ
  30Ex    ム  メ  モ  ャ  ヤ  ュ  ユ  ョ  ヨ  ラ  リ  ル  レ  ロ  ヮ  ワ
  30Fx    ヰ  ヱ  ヲ  ン  ヴ  ヵ  ヶ  ヷ  ヸ  ヹ  ヺ  ・  ー  ヽ  ヾ  ヿ
}

kana_re = 'ぁあぃいぅうぇえぉおかがきぎくぐけげこごさざしじすずせぜそぞただちぢっつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもゃやゅゆょよらりるれろゎわゐゑをんゔゕゖ゛゜ゝゞゟ゠ァアィイゥウェエォオカガキギクグケゲコゴサザシジスズセゼソゾタダチヂッツヅテデトドナニヌネノハバパヒビピフブプヘベペホボポマミムメモャヤュユョヨラリルレロヮワヰヱヲンヴヵヶヷヸヹヺ・ーヽヾヿ'

## # ----------------------------
## # Regular Expressions
## # ADD AS scopes to Edict model
## # ----------------------------
##   okuri_re = Edict.where("literal ~ '^#{kanji}[#{kana_re}]+$'")
##   compound1_re = Edict.where("literal ~ '^#{kanji}[^#{kana_re}]+$'")
##   compound2_re = Edict.where("literal ~ '^[^#{kana_re}]+#{kanji}$'")


hira, kata = %w{ hiragana katakana }.map{|name| Yamafuda.find_or_create_by(name: name) }

hira.fuda = {
   a: 'あ',     i: 'い',     u: 'う',    e: 'え',    o: 'お',
  ka: 'か',    ki: 'き',    ku: 'く',   ke: 'け',   ko: 'こ',
  sa: 'さ',   shi: 'し',    su: 'す',   se: 'せ',   so: 'そ',
  ta: 'た',   chi: 'ち',   tsu: 'つ',   te: 'て',   to: 'と',
  na: 'な',    ni: 'に',    nu: 'ぬ',   ne: 'ね',   no: 'の',
  ha: 'は',    hi: 'ひ',    fu: 'ふ',   he: 'へ',   ho: 'ほ',
  ma: 'ま',    mi: 'み',    mu: 'む',   me: 'め',   mo: 'も',
  ya: 'や',                 yu: 'ゆ',               yo: 'よ',
  ra: 'ら',    ri: 'り',    ru: 'る',   re: 'れ',   ro: 'ろ',
  wa: 'わ',                                         wo: 'を',
   n: 'ん'
}.map{ |back, front| Fuda.find_or_create_by(front: front, back: back) }

kata.fuda = {
  a: 'ア',   i: 'イ',   u: 'ウ',  e: 'エ',  o: 'オ',
 ka: 'カ',  ki: 'キ',  ku: 'ク', ke: 'ケ', ko: 'コ',
 sa: 'サ', shi: 'シ',  su: 'ス', se: 'セ', so: 'ソ',
 ta: 'タ', chi: 'チ', tsu: 'ツ', te: 'テ', to: 'ト',
 na: 'ナ',  ni: 'ニ',  nu: 'ヌ', ne: 'ネ', no: 'ノ',
 ha: 'ハ',  hi: 'ヒ',  hu: 'フ', he: 'ヘ', ho: 'ホ',
 ma: 'マ',  mi: 'ミ',  mu: 'ム', me: 'メ', mo: 'モ',
 ya: 'ヤ',             yu: 'ユ',           yo: 'ヨ',
 ra: 'ラ',  ri: 'リ',  ru: 'ル', re: 'レ', ro: 'ロ',
 wa: 'ワ',                                 wo: 'ヲ',
  n: 'ン'
}.map{ |back, front| Fuda.find_or_create_by(front: front, back: back) }


require './public/build_kanji'
read_kanjidic './public/kanjidic.xml' unless Kanji.count > 13100
read_radfilex './public/radkfilex' unless Radical.count > 213

yamafudas = [1,2,3,4,5,6,8,9,10].inject({}.with_indifferent_access) { |h,g|
  h.merge(
    "#{g}"      => Yamafuda.find_or_create_by(name: "kanji grade #{g}"),
    "#{g} kun"  => Yamafuda.find_or_create_by(name: "kanji grade #{g} kun-only"),
    "#{g}mean"  => Yamafuda.find_or_create_by(name: "kanji grade #{g} meanings")
  )
}

kanji_characters = Kanji.where.not(grade: nil, frequency: nil).order(:grade, :strokes, :frequency)
kanji_characters.map{|k|
  f = Fuda.find_or_create_by(front: k.literal, back: "#{k.kun}\n#{k.on}\n#{k.meanings}")
  fk= Fuda.find_or_create_by(front: k.literal, back: "#{k.kun}")
  fm= Fuda.find_or_create_by(front: k.literal, back: "#{k.meanings}")
   f.kanji << k unless  f.kanji.include?(k)
  fk.kanji << k unless fk.kanji.include?(k)
  fm.kanji << k unless fm.kanji.include?(k)
  yamafudas["#{k.grade}"    ].fuda << f  unless yamafudas["#{k.grade}"    ].fuda.include?(f)
  yamafudas["#{k.grade} kun"].fuda << fk unless yamafudas["#{k.grade} kun"].fuda.include?(fk)
  yamafudas["#{k.grade}mean"].fuda << fm unless yamafudas["#{k.grade}mean"].fuda.include?(fm)
  f
} unless yamafudas.all?{|g,y| y.fuda.count > 5 }

#grades = [1,2,3,4,5,6,8,9,10]
#grades.map{|grade|
#  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade}")
#  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).flat_map(&:fuda) if yamafuda.fuda.blank?
#  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade} kun-only")
#  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).map{|k|
#    Fuda.find_or_create_by(front: k.literal, back: k.kun).tap{|f| f.kanji << k unless f.kanji.include?(k) }
#  } if yamafuda.fuda.blank?
#  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade} meanings")
#  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).map{|k|
#    Fuda.find_or_create_by(front: k.literal, back: k.meanings).tap{|f| f.kanji << k unless f.kanji.include?(k) }
#  } if yamafuda.fuda.blank?
#}

rads = Yamafuda.find_or_create_by(name: 'radicals')
radkun = Yamafuda.find_or_create_by(name: 'radicals kun-only')
radmean = Yamafuda.find_or_create_by(name: 'radical meanings')
rads.fuda = Radical.all.map{|r|
  k = r.original_kanji || Kanji.new
  f = Fuda.find_or_create_by(front: r.literal, back: "#{k.kun}\n#{k.on}\n#{k.meanings}")
  kf = Fuda.find_or_create_by(front: r.literal, back: k.kun)
  mf = Fuda.find_or_create_by(front: r.literal, back: k.meanings)
  if r.original_kanji.present?
    f.kanji << r.original_kanji unless f.kanji.include?(r.original_kanji)
    kf.kanji << r.original_kanji unless kf.kanji.include?(r.original_kanji)
    mf.kanji << r.original_kanji unless mf.kanji.include?(r.original_kanji)
  end
  radkun.fuda << kf unless radkun.fuda.include?(kf)
  radmean.fuda << mf unless radmean.fuda.include?(mf)
  f
} unless [rads.fuda.count, radkun.fuda.count, radmean.fuda.count].all?{|r| r > 213 }

#require './db/okurigana'
#load_okurigana
# ok = Yamafuda.find_or_create_by(name: 'okurigana yamafuda')
#
# ok.fuda = Kanji.where.not(grade: [8,9,10,nil]).where("kun like '%.%'").order(:grade, :strokes, :frequency).inject({}){|p,k|
#   k.kun.split(/\s*,\s*/).keep_if{|s| s =~ /\./}.each{|s|
#     parts = s.split('.')
#     puts "Not String: #{k.literal.inspect} : #{parts.last.inspect}" unless k.literal.is_a?(String) && parts.last.is_a?(String)
#     f = k.literal.to_s + parts.last.to_s
#     p[f] ||= {kun: []}.with_indifferent_access
#     p[f][:kun] << s
#     p[f][:meaning] = k.meanings
#     p[f][:kanji] = k.id
#   }
#   p
# }.map{|f,b|
#   Fuda.create(front: f, back: "#{b[:kun].join(', ')}\n#{b[:meaning]}").tap{|fuda| fuda.kanji_ids = Array(b[:kanji]) }
# }

if Edict.count == 0
  lines = IO.readlines('./public/edict.utf8')
  lines.shift
  lines.each_slice(1000){|li|
    li.each{|l|
      puts l
      l =~ /^(\S\S*)\s*(?:\[([^\]]*)\])?\s*\/(.*\/)$/
      lit,reading,meaning = [$1,$2,$3]
      meaning = reading && reading = nil if meaning.nil?
      meaning = meaning.gsub('/(', "\n(").gsub(/\/$/, '').gsub('/', '; ').gsub(/(?:^\([^)]*\)\s*)*\(\d+\)\s*/, '')
      Edict.create(literal: lit, reading: reading, meanings: meaning)
    }
  }
end

ok = Yamafuda.find_or_create_by(name: 'okurigana kanji')
if ok.fuda.count == 0
  ok.fuda = Kanji.where.not(grade: [8,9,10,nil]).where("kun like '%.%'").order(:grade, :strokes, :frequency).map{|k|
    k.kun.split(/\s*,\s*/).keep_if{|s| s.include?('.')}.map{|okuri|
      ed = Edict.find_by(literal: [k.literal, okuri.split('.').last].join)
      next unless ed.present?
      Fuda.create(front: ed.literal, back: "#{ed.reading}\n#{ed.meanings}").tap{|f| f.kanji = Array(k) }
    }.compact
  }.flatten
end

kanji = Kanji.where(grade: [*1..6]).reorder(:grade, :strokes)
if Yamafuda.where(name: 'Day 2').count == 0
  1.upto(51) {|day|
    yf = Yamafuda.find_or_create_by(name: "Day #{day}")
    knj = kanji.shift(20)
    yf.fuda = knj.map{|k|
      cmp = Edict.where("meanings like '%(P)'").where("literal ~ '.#{k.literal}|#{k.literal}.'").order('RANDOM()').limit(4)
      front = [k.literal] + cmp.map(&:literal)
      cmp_m_r = cmp.map{|c| "#{c.literal} (#{c.reading}) #{c.meanings}\n---------------" }
      Fuda.find_or_create_by(front: front.join("\n"), back: "#{k.kun}\n#{k.on}\n#{k.meanings}\n---------------\n#{cmp_m_r.join("\n")}")
    }

  }
end
