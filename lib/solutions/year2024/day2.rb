# frozen_string_literal: true

require_relative '../day'

class Day2 < Day
  def part1
    lines = read_input(split1: "\n").map { |line| line.split.map(&:to_i) }
    lines.count { |line| safe? line }
  end

  def part2
    lines = read_input(split1: "\n").map { |line| line.split.map(&:to_i) }
    lines.count { |line| safe_with_removing? line }
  end

  private

  def sorted?(line)
    line == line.sort || line.reverse == line.sort
  end

  def safe?(line)
    sorted?(line) &&
      line.map.with_index { |elem, i| i == line.size - 1 ? 1 : (elem - line[i + 1]).abs }
          .all? { |x| x >= 1 && x <= 3 }
  end

  def safe_with_removing?(line)
    return true if safe? line

    line.each_with_index do |_, i|
      return true if safe?(line[0...i] + line[i + 1..])
    end

    false
  end
end
