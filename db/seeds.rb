# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hira, kata = %w{ hiragana katakana }.map{|name| Yamafuda.create(name: name) }

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
}.map{ |back, front| Fuda.create(front: front, back: back) }

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
}.map{ |back, front| Fuda.create(front: front, back: back) }


require './public/build_kanji'
read_kanjidic './public/kanjidic.xml'
read_radfilex './public/radkfilex'

kanji_characters = Kanji.where.not(grade: nil, frequency: nil).order(:grade, :strokes, :frequency)
kanji_characters.map{|k|
  f = Fuda.create(front: k.literal, back: "#{k.kun}\n#{k.on}\n#{k.meanings}")
  f.kanji << k
  f
}

grades = [1,2,3,4,5,6,8,9,10]
grades.map{|grade|
  yamafuda = Yamafuda.create(name: "kanji grade #{grade}")
  yamafuda.fuda = Kanji.where(grade: grade).order(:grade, :strokes, :frequency).flat_map(&:fuda)
}
