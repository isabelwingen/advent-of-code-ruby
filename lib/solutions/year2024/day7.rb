# frozen_string_literal: true

require_relative '../day'

class Day7 < Day

  def part1
    read_input(split1: "\n", split2: ' ')
      .map { |line| line.map.with_index { |s, i| i.zero? ? s.to_i : s.to_i } }
      .map { |line| { result: line[0], values: line[1..]} }
      .select { |line| solve_equation2(line) }
      .map { |line| line[:result] }
      .sum
  end

  def solve_equation(equation)
    result = equation[:result]
    values = equation[:values]
    stack = [values]
    until stack.empty?
      current = stack.pop
      if current&.size == 1
        return true if current&.first == result
      else
        u = current[0] * current[1]
        v = current[0] + current[1]
        stack.push(Array.new([v] + current[2..]))
        stack.push(Array.new([u] + current[2..]))
      end
    end
    false
  end

  def solve_equation2(equation)
    result = equation[:result]
    values = equation[:values]
    stack = [values]
    until stack.empty?
      current = stack.pop
      return true if current&.size == 1 && current&.first == result

      next if current&.size == 1

      next if current.first > result

      u = current[0] * current[1]
      v = current[0] + current[1]
      w = "#{current[0]}#{current[1]}".to_i
      stack.push(Array.new([u] + current[2..]))
      stack.push(Array.new([v] + current[2..]))
      stack.push(Array.new([w] + current[2..]))
    end
    false
  end

end
