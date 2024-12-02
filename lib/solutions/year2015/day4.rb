# frozen_string_literal: true

require_relative '../day'
require 'digest'

class Day4 < Day
  def part1
    i = 0
    key = 'iwrupvqb'
    loop do
      string = "#{key}#{i}"
      md5 = Digest::MD5.hexdigest(string)
      return i if md5.slice(0, 5) == '00000'

      i += 1
    end
  end

  def part2
    i = part1
    key = 'iwrupvqb'
    loop do
      string = "#{key}#{i}"
      md5 = Digest::MD5.hexdigest(string)
      return i if md5.slice(0, 6) == '000000'

      i += 1
    end
  end
end
