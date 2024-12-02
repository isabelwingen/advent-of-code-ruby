# frozen_string_literal: true

require_relative '../day'

class Day17 < Day
  def number_of_combos(n, numbers)
    if n.zero?
      1
    elsif numbers.empty? || n <= 0
      0
    else
      numbers.map.with_index do |p, i|
        number_of_combos(n - p, numbers.drop(i + 1))
      end.sum
    end
  end

  def num_of_com2(taken, rem_num, goal: 150)
    if (goal - taken.sum).zero?
      { taken.size => 1 }
    elsif rem_num.empty? || taken.sum > goal
      {}
    else
      rem_num.map
             .with_index { |p, i| num_of_com2(taken + [p], rem_num.drop(i + 1), goal: goal) }
             .each_with_object({}) do |hash, acc|
        hash.each { |key, value| acc[key] = (acc[key] || 0) + value }
        acc
      end
    end
  end

  def part1
    numbers = read_input(split1: "\n").map(&:to_i).sort
    num_of_com2([], numbers)
  end
end
