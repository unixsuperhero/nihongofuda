require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  def test_to_kana
    assert Romaji.to_kana('a') == 'あ'
  end

  def test_more_complex_conversion
    assert Romaji.to_kana('ittekimasu') == 'いってきます'
  end

  def test_n_by_itself
    assert Romaji.to_kana('konnichiha') == 'こんにちは'
  end

  # should write more tests.  I just can't think of a finite number of use
  # cases that cover all the scenarios.
end
