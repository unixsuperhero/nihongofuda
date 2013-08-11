class Pattern

  class << self

    # Atoms

    def kana  ;  "[#{Kana.all}]" ; end
    def kana! ; "[^#{Kana.all}]" ; end

    def starting_compound k ; "#{k}#{kana!}+" ; end
    def ending_compound   k ; "#{kana!}+#{k}" ; end

    # Patterns

    def okuri k
      %r{^#{k}#{kana}+$}
    end

    def compound k
      %r{^(#{starting_compound k}|#{ending_compound k})$}
    end
  end

end
