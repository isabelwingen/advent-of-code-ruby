# frozen_string_literal: true

require_relative '../day'
class Day1 < Day
  def part1
    v = 0
    read_input.each_char do |c|
      if c == '('
        v += 1
      else
        v -= 1
      end
    end
    v
  end

  def part2
    v = 0
    read_input.each_char.with_index do |c, index|
      if c == '('
        v += 1
      else
        v -= 1
      end
      return index + 1 if v == -1
    end
    -1
  end
end
