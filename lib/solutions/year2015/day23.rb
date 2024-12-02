# frozen_string_literal: true

require_relative '../day'

class Day23 < Day
  def part1
    commands = read_input(split1: "\n").map { |line| line.split(/[ ,]+/) }
    registers = { 'a' => 1, 'b' => 0 }
    pointer = 0
    while pointer >= 0 && pointer < commands.size
      command = commands[pointer]
      case command[0]
      when 'hlf'
        registers[command[1]] = registers[command[1]] / 2
        pointer += 1
      when 'tpl'
        registers[command[1]] *= 3
        pointer += 1
      when 'inc'
        registers[command[1]] += 1
        pointer += 1
      when 'jmp'
        pointer += command[1].to_i
      when 'jie'
        pointer += if registers[command[1]].even?
                     command[2].to_i
                   else
                     1
                   end
      when 'jio'
        pointer += if registers[command[1]] == 1
                     command[2].to_i
                   else
                     1
                   end
      end
    end
    registers
  end
end
