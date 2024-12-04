# frozen_string_literal: true

require_relative '../day'

class Day3 < Day
  def part1
    text = read_input
    pattern = /mul\((\d{1,3}),(\d{1,3})\)/

    text.scan(pattern).map { |x, y| x.to_i * y.to_i }.compact.sum
  end

  def part2
    text = read_input
    pattern = /mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/

    matches = text.scan(pattern)

    sum = 0
    enabled = true
    matches.each do |match|
      if match == "don't()"
        enabled = false
      elsif match == 'do()'
        enabled = true
      elsif enabled
        array = match.scan(/mul\((\d{1,3}),(\d{1,3})\)/).first.map(&:to_i)
        sum += array[0] * array[1]
      end
    end
    sum
  end
end
