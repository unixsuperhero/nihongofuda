# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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
read_kanjidic './public/kanjidic.xml'
read_radfilex './public/radkfilex'

kanji_characters = Kanji.where.not(grade: nil, frequency: nil).order(:grade, :strokes, :frequency)
kanji_characters.map{|k|
  f = Fuda.find_or_create_by(front: k.literal, back: "#{k.kun}\n#{k.on}\n#{k.meanings}")
  f.kanji << k unless f.kanji.include?(k)
  f
}

grades = [1,2,3,4,5,6,8,9,10]
grades.map{|grade|
  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade}")
  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).flat_map(&:fuda) if yamafuda.fuda.blank?
  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade} kun-only")
  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).map{|k|
    Fuda.find_or_create_by(front: k.literal, back: k.kun).tap{|f| f.kanji << k unless f.kanji.include?(k) }
  } if yamafuda.fuda.blank?
  yamafuda = Yamafuda.find_or_create_by(name: "kanji grade #{grade} meanings")
  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).map{|k|
    Fuda.find_or_create_by(front: k.literal, back: k.meanings).tap{|f| f.kanji << k unless f.kanji.include?(k) }
  } if yamafuda.fuda.blank?
}

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
}
