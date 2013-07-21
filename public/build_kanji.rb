# coding: utf-8

# Usage: ruby makedb.rb (radkfilex) (kanjidic2_file) (kanjis_dir) > kanjis_db
#  radkfilex = Jim Breen's radkfilex (ftp://ftp.monash.edu.au/pub/nihongo/kradzip.zip),
#              converted from EUC-JP to UTF-81
#  kanjidic2_file = kanjidic2.xml file (http://www.csse.monash.edu.au/~jwb/kanjidic2/)
#  kanjis_dir = "kanjis" archive of kanji.free.fr

require 'rexml/document'
require 'rexml/streamlistener'

#$kanjis = {}
#$radicals = {}
#
#class Radical
#  attr_accessor :strokes, :unicode, :kanjis
#
#  def initialize
#    @kanjis = []
#  end
#
#  def to_s
#    @unicode
#  end
#end

#class Kanji
#  attr_accessor :unicode
#  attr_accessor :radicals, :skip
#  attr_accessor :kun, :on, :meanings
#  attr_accessor :frequency, :grade
#
#  attr_accessor :kun_arr, :on_arr, :meaning_arr
#
#  def initialize
#    @skip = []
#    @radicals = []
#    @kun_arr = []
#    @on_arr = []
#    @meaning_arr = []
#  end
#end

class KanjidicReader
        include REXML::StreamListener

  def tag_start(name, attrs)
    @curr_tag = name
    @curr_attrs = attrs

    if name == "character" then
      @curr = Kanji.new
      @curr.on_arr ||= []
      @curr.kun_arr ||= []
      @curr.meaning_arr ||= []
    end
  end

  def tag_end(name)
    @curr_tag = nil

    if name == "character" then
      @curr.kun = @curr.kun_arr.join(', ')
      @curr.on = @curr.on_arr.join(', ')
      @curr.meanings = @curr.meaning_arr.join(', ')
      @curr.save
    end
  end

  def text(tag_body)
    if @curr_tag == "literal" then
      @curr.literal = tag_body
    elsif @curr_tag == "freq" then
      @curr.frequency = tag_body
    elsif @curr_tag == "stroke_count" then
      @curr.strokes = tag_body
    elsif @curr_tag == "grade" then
      @curr.grade = tag_body
    elsif @curr_tag == "reading" then
      if @curr_attrs["r_type"] == "ja_on" then
        @curr.on_arr << tag_body
      elsif @curr_attrs["r_type"] == "ja_kun" then
        @curr.kun_arr << tag_body
      end
    elsif @curr_tag == "meaning" then
      if [nil].include? @curr_attrs["m_lang"] then
        @curr.meaning_arr << tag_body
      end
    end
  end
end

def read_kanjidic(file)
  REXML::Document.parse_stream(File.open(file), KanjidicReader.new)
end

#def read_radfilex(file)
#  num = 1
#  curr = nil
#  File.open(file) do |fd|
#    fd.each_line do |line|
#      if line[0] == '#' or line.chomp.size == 0 then
#        next
#      end
#
#      if line[0] == '$' then
#        parts = line.split
#        curr = Radical.new
#        curr.unicode = parts[1]
#        curr.strokes = parts[2].to_i
#        num += 1
#        $radicals[curr.unicode] = curr
#      elsif curr
#        line.chomp.each_char do |c|
#          kanji = $kanjis[c]
#          if kanji then
#            curr.kanjis << kanji
#            kanji.radicals << curr
#          end
#        end
#      end
#    end
#  end
#end

# Read arguments
#kanjidic2 = ARGV[0]
#radkfilex = ARGV[1]
#kanjisdir = ARGV[2]

# Process kanjidic2 & radkfilex
#read_kanjidic(kanjidic2)
#read_radfilex(radkfilex)

#$radicals.each { |_,rad| puts "#{rad.unicode} #{rad.strokes}" }
#$kanjis.each do |_,k|
#  skip = []
#  k.skip.each { |s| skip << s.join('-') }
#  puts "-"
#  puts "#{k.unicode}\t#{k.radicals.join}\t#{skip.join("\t")}"
#  puts "#{k.on.join("\t")}"
#  puts "#{k.kun.join("\t")}"
#  puts "#{k.meanings.join("\t")}"
#end
#puts "="
#
## Process kanji.free.fr database to extract "similar kanjis"
#Dir.glob("#{kanjisdir}/kanji/*/*.html").each do |file|
#  data = File.open(file) { |fd| fd.read }
#  if data.include? "n'existe pas ou n'a pas"
#    next
#  end
#
#  data =~ /<FONT SIZE="\+5">(.+?)<\/FONT>/m
#  char = $1
#  if data =~ /res similaires<\/FONT><\/TD><\/TR>.+?<\/TABLE>.+?<FONT SIZE="\+1">(.+?)<\/TD>/m
#    sim = $1.scan(/<A HREF="[^"]+">(.+?)<\/A>/).map { |e| e[0] }.join(" ")
#    puts "#{char} #{sim}"
#  else
#    puts char
#  end
#end
#
