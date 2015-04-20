require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestSearch < Minitest::Test
    def setup
        require_relative '../lib/modules/search'
    end

    def test_search_search
        answer = Answer.new('search', 'search', 'maxdeviant', 'theartificiallounge', 'search')

        search = answer.search

        assert_equal "Is <http://www.google.com/search?q=cat%20fact&btnI|this> what you're looking for?", search

        queries = [
          'aliceffekt',
          'neon hermetism',
          'devine lu linvega'
        ]

        queries.each do |query|
            answer = Answer.new('search', 'search', 'maxdeviant', 'theartificiallounge', "search #{query}")

            search = answer.search

            assert_equal "Is <http://www.google.com/search?q=#{url_encode(query)}&btnI|this> what you're looking for?", search
        end
    end

    def test_search_google
        answer = Answer.new('search', 'google', 'maxdeviant', 'theartificiallounge', 'search google cat fact')

        google = answer.google

        assert_equal 'http://www.google.com/search?q=cat%20fact&btnI', google
    end

    def test_search_duckduckgo
        answer = Answer.new('search', 'duckduckgo', 'maxdeviant', 'theartificiallounge', 'search duckduckgo cat fact')

        duckduckgo = answer.duckduckgo

        assert_equal 'https://duckduckgo.com/?q=!ducky+cat%20fact+%s', duckduckgo
    end
end
