# frozen_string_literal: true

require_relative '../day'

class Day10 < Day
  def part1
    grid = read_input(split1: "\n").map { |line| line.chars.map(&:to_i) }
    get_paths(grid).map { |line| [line.first, line.last] }.uniq.count
  end

  def part2
    grid = read_input(split1: "\n").map { |line| line.chars.map(&:to_i) }
    get_paths(grid).count
  end

  def trailheads(grid)
    result = Set.new
    grid.each_with_index do |row, row_id|
      row.each_with_index do |cell, col_id|
        result.add([row_id, col_id]) if cell.zero?
      end
    end
    result
  end

  def get_paths(grid)
    trailheads = trailheads(grid)

    result = Set.new
    stack = trailheads.map { |trailhead| [trailhead] }
    until stack.empty?
      current = stack.pop
      if current.size == 10
        result.add current
        next
      end

      row, col = current.last
      value = current.size - 1
      neighbors = [[row - 1, col], [row + 1, col], [row, col + 1], [row, col - 1]]
      neighbors
        .reject { |r, c| r.negative? || c.negative? }
        .reject { |r, c| (grid[r] || [])[c].nil? }
        .select { |r, c| (grid[r] || [])[c] == value + 1 }
        .each do |r, c|
        stack.push current + [[r, c]]
      end
    end
    result
  end
end
