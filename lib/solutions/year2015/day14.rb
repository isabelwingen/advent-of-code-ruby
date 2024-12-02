# frozen_string_literal: true

require_relative '../day'

class Day14 < Day
  TOTAL_TIME = 2503

  def parse(line)
    parts = line.split
    { speed: parts[3].to_i, time: parts[6].to_i, waiting: parts[13].to_i }
  end

  def part1
    read_input(split1: "\n").map { |line| parse(line) }.map do |line|
      time = line[:time] + line[:waiting]
      number_of_cycles = TOTAL_TIME / time
      remainder = TOTAL_TIME - (time * number_of_cycles)

      (number_of_cycles * line[:time] * line[:speed]) + ([remainder,
                                                          line[:time]].min * line[:speed])
    end.max
  end

  def part2
    reindeers = read_input(split1: "\n")
                .map { |line| parse(line) }
                .map { |h| h.merge({ travelled: 0, points: 0 }) }

    (0..2502).each do |i|
      reindeers.each do |reindeer|
        if i.modulo(reindeer[:time] + reindeer[:waiting]) < reindeer[:time]
          reindeer[:travelled] += reindeer[:speed]
        end
      end
      max = reindeers.map { |reindeer| reindeer[:travelled] }.max
      reindeers.select { |reindeer| reindeer[:travelled] == max }.each do |reindeer|
        reindeer[:points] += 1
      end
    end
    reindeers.map { |reindeer| reindeer[:points] }.max
  end
end
