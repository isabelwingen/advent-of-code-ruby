# frozen_string_literal: true

require_relative '../day'

class Day18 < Day
  def neighbours(grid, row, col)
    [
      [row - 1, col - 1], [row - 1, col], [row - 1, col + 1],
      [row, col - 1], [row, col + 1],
      [row + 1, col - 1], [row + 1, col], [row + 1, col + 1]
    ]
      .reject { |r, _| r.negative? || r > 99 }
      .reject { |_, c| c.negative? || c > 99 }
      .map { |r, c| grid[r][c] }
  end

  def switch(row, col, grid)
    if grid[row][col] == '#'
      on_neighbours = neighbours(grid, row, col).select { |x| x == '#' }.size
      if [2, 3].include?(on_neighbours)
        '#'
      else
        '.'
      end
    elsif neighbours(grid, row, col).select { |x| x == '#' }.size == 3
      '#'
    else
      '.'
    end
  end

  def part1
    grid = read_input(split1: "\n").map(&:chars)
    (0..99).each do |i|
      puts i
      grid = grid.map.with_index do |_row, row_id|
        grid[row_id].map.with_index do |_cell, col_id|
          switch(row_id, col_id, grid)
        end
      end
    end
    grid.flatten.join.each_char.count { |c| c == '#' }
  end

  def part2
    grid = read_input(split1: "\n").map(&:chars)
    corners = [[0, 0], [0, 99], [99, 0], [99, 99]]
    corners.each { |row, col| grid[row][col] = '#' }
    (0..99).each do |_i|
      grid = grid.map.with_index do |_row, row_id|
        grid[row_id].map.with_index do |_, col_id|
          if corners.include?([row_id, col_id])
            '#'
          else
            switch(row_id, col_id, grid)
          end
        end
      end
    end
    grid.flatten.join.each_char.count { |c| c == '#' }
  end
end
