require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require_relative '../lib/modules/answer'

class TestXenon < Minitest::Test
    def setup
        require_relative '../lib/modules/xenon'
    end

    def test_xenon_account
        answer = Answer.new('xenon', 'account', 'strstr', 'theartificiallounge', 'xenon account')

        account = answer.account

        puts account

        # assert_includes mem.data, ['ludivine', '{wallet}strstr', '10']
    end

    def test_xenon_give
        answer = Answer.new('xenon', 'give', 'maxdeviant', 'theartificiallounge', 'xenon give greylion 2')

        give = answer.give

        # assert_includes mem.data, ['ludivine', '{wallet}maxdeviant', '3']
        # assert_includes mem.data, ['ludivine', '{wallet}greylion', '10']
    end
end

# class XenonMemoryTest < Memory

#     attr_reader :data

#     def initialize

#         @data = Array.new

#         saveAttribute('aliceffekt', 'wallet', 10)
#         saveAttribute('greylion', 'wallet', 8)
#         saveAttribute('maxdeviant', 'wallet', 5)
#         saveAttribute('jean', 'wallet', 999)

#     end

#     def load(_topic)

#         if _topic.strip() == "" then return @data end
#         return @data.select { |row| row.include?(_topic) }

#     end

#     def save(username, key, value)

#         lastRow = @data.index { |row| row[0] == username && row[1] == key }

#         if lastRow != nil
#             @data[lastRow][2] = value
#         else
#             @data.push([ username, key, value ])
#         end

#     end
# end
