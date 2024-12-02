# frozen_string_literal: true

require_relative '../day'

class Day1 < Day
  def part1
    input = read_input(split1: "\n").map(&:split)
    list1 = input.map { |x| x[0].to_i }.sort
    list2 = input.map { |x| x[1].to_i }.sort
    list1.map.with_index { |t, i| (t - list2[i]).abs }
         .sum
  end

  def part2
    input = read_input(split1: "\n").map(&:split)
    list1 = input.map { |x| x[0].to_i }
    list2 = input.map { |x| x[1].to_i }
    list1.map { |x| x * list2.count { |y| y == x } }
         .sum
  end
end
