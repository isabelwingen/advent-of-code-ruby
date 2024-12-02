# frozen_string_literal: true

require_relative '../day'

class Day15 < Day
  TOTAL_TIME = 2503

  def parse(line)
    parts = line.split
    { capacity: parts[2].to_i, durability: parts[4].to_i, flavor: parts[6].to_i,
      texture: parts[8].to_i, calories: parts[10].to_i }
  end

  def part1
    ingredients = read_input(split1: "\n").map { |line| parse(line) }
    res = { a: 0, b: 0, res: 0 }
    (0..100).each do |a|
      puts a
      (0..(100 - a)).each do |b|
        (0..(100 - a - b)).each do |c|
          d = 100 - a - b - c
          next unless a + b + c + d == 100

          factors = [a, b, c, d]
          calories = [
            factors.map.with_index { |factor, i| ingredients[i][:calories] * factor }.sum,
            0
          ].max

          next unless calories == 500

          p = %i[capacity durability flavor texture].map do |type|
            [factors.map.with_index { |factor, i| ingredients[i][type] * factor }.sum, 0].max
          end.reduce(:*)

          res = { a: a, b: b, res: p } if p > res[:res]
        end
      end
    end
    res
  end
end
