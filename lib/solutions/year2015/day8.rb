# frozen_string_literal: true

require_relative '../day'
class Day8 < Day
  def number_of_characters_of_string_code(string)
    string.size
  end

  def number_of_characters_in_memory(string)
    in_memory = -2
    pointer = 0
    while pointer < string.size
      c = string[pointer]
      in_memory += 1
      if c == '\\'
        d = string[pointer + 1]
        if %w[\\ "].include?(d)
          pointer += 2
        elsif d == 'x'
          pointer += 4
        else
          raise 'should not happen'
        end
      else
        pointer += 1
      end
    end
    in_memory
  end

  def sum(lines, fun)
    lines.map { |line| fun.call(line) }.sum
  end

  def part1
    lines = read_input(split1: "\n")
    a = sum(lines, method(:number_of_characters_of_string_code))
    b = sum(lines, method(:number_of_characters_in_memory))
    a - b
  end

  def encode(string)
    res = ''
    pointer = 0
    while pointer < string.size
      c = string[pointer]
      res += if c == '"'
               '\\"'
             elsif c == '\\'
               '\\\\'
             else
               c
             end
      pointer += 1
    end
    res
  end

  def part2
    lines = read_input(split1: "\n").map { |line| encode(line) }
    a = sum(lines, method(:number_of_characters_of_string_code))
    b = sum(lines, method(:number_of_characters_in_memory))
    a - b
  end
end
