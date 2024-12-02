# frozen_string_literal: true

require 'thor'
require_relative '../lib/solutions_loader' # Create this loader class to handle dynamic loading

class AdventOfCode < Thor
  desc 'solve YEAR DAY PART', 'Solve Advent of Code for a given year, day, and part'

  def solve(year, day, part)
    year = year.to_i
    day = day.to_i
    part = part.to_i

    exit(1) unless year.between?(2015, 2024) && day.between?(1, 25) && part.between?(1, 2)

    solution = SolutionsLoader.load_solution(year, day)
    exit(1) if solution.nil?

    if part == 1
      puts solution.part1
    else
      puts solution.part2
    end
  end
end

AdventOfCode.start(ARGV)
