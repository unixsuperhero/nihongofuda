
# Name

NihongoFuda (Japanese Cards)

# Description

A rails website for quizzing yourself with flash cards.  The database is prepped for Japanese writing systems.

# Setup

    git clone git@github.com:unixsuperhero/nihongofuda.git
    cd nihongofuda
    rake db:create:all db:migrate db:seed
    # start server

# Credit

I cloned/modified a script from this repo: https://github.com/sloonz/kanjidic  
I use it to load the kanjidic2.xml file into the db via an ActiveRecord object.

I plan to fork the project and make a proper clone of the original.

