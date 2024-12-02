# frozen_string_literal: true

require_relative '../day'

class Day6 < Day
  COMMANDS = %(toggle on off)

  def parse(line)
    command = if line.include? 'toggle'
                :toggle
              elsif line.include? 'off'
                :off
              else
                :on
              end
    (to, _, from) = line.split.reverse.take(3)
    [command, from.split(',').map(&:to_i), to.split(',').map(&:to_i)]
  end

  def part1
    lights_on = Set.new
    read_input(split1: "\n").map { |line| parse(line) }.each do |command, from, to|
      puts [command, from, to].join("\t")
      (from[0]..to[0]).each do |x|
        (from[1]..to[1]).each do |y|
          p = [x, y]
          if command == :on || (command == :toggle && !lights_on.include?(p))
            lights_on << p
          else
            lights_on.delete p
          end
        end
      end
    end
    lights_on.count
  end

  def part2
    lights_on = {}
    read_input(split1: "\n").map { |line| parse(line) }.each do |command, from, to|
      (from[0]..to[0]).each do |x|
        (from[1]..to[1]).each do |y|
          lights_on[x] = Hash.new(0) unless lights_on.include? x
          if command == :on
            lights_on[x][y] += 1
          elsif command == :off
            lights_on[x][y] = [lights_on[x][y] - 1, 0].max
          else
            lights_on[x][y] += 2
          end
        end
      end
    end
    lights_on.values.map { |inner_hash| inner_hash.values.sum }.sum
  end
end
