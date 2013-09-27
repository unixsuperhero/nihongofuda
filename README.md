
# Name

NihongoFuda (Japanese Cards)

# Description

A rails website for quizzing yourself with flash cards.  The database is prepped for Japanese writing systems.

# Try It

http://nihongofuda.herokuapp.com

# Setup

    git clone git@github.com:unixsuperhero/nihongofuda.git
    cd nihongofuda
    rake db:create:all db:migrate db:seed
    # start server

# Credit

I cloned/modified a script from this repo: https://github.com/sloonz/kanjidic
I use it to load the kanjidic2.xml file into the db via an ActiveRecord object.

I plan to fork the project and make a proper clone of the original.



# Displaying Kana Charts with Ruby

    hiragana = 'あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもや　ゆ　よらりるれろわ　　　をん　　　　'
    katakana = 'アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤ　ユ　ヨラリルレロワ　　　ヲン　　　　'
    def display_chart(characters)
      chart=[[],[],[],[],[]]
      characters.split(//).each_slice(5){ |slice|
        chart.each_with_index{ |e,i|
          chart[i] << slice.shift
        }
      }

      printf("%s\n%s\n%s\n%s\n%s\n", *chart.map{|row| row.join})
    end

    # $> display_chart hiragana
    #
    # あかさたなはまやらわん
    # いきしちにひみ　り　　
    # うくすつぬふむゆる　　
    # えけせてねへめ　れ　　
    # おこそとのほもよろを　

    # $> display_chart katakana
    #
    # アカサタナハマヤラワン
    # イキシチニヒミ　リ　　
    # ウクスツヌフムユル　　
    # エケセテネヘメ　レ　　
    # オコソトノホモヨロヲ　











