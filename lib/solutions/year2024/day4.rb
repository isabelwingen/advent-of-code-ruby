# frozen_string_literal: true

require_relative '../day'

class Day4 < Day
  def part1
    grid = read_input(split1: "\n").map(&:chars)
    lines = all_lines(grid)
    pattern = /XMAS/

    lines.map { |line| line.scan(pattern).count }.sum
  end

  def part2
    grid = read_input(split1: "\n").map(&:chars)
    sum = 0
    0.upto(grid.size).each do |row|
      0.upto(grid.size).each do |col|
        char = cell(grid, row, col)
        next if char != 'M' && char != 'S'

        sum += 1 if diagonal_mas(grid, row, col, 1) && diagonal_mas(grid, row, col + 2, -1)
      end
    end
    sum
  end

  private

  def cell(grid, row, col)
    (grid[row] || [])[col]
  end

  def diagonal_mas(grid, row, col, dir)
    if dir.negative?
      (cell(grid, row + 1, col - 1) == 'A') &&
        ((cell(grid, row, col) == 'M' && cell(grid, row + 2, col - 2) == 'S') ||
        (cell(grid, row, col) == 'S' && cell(grid, row + 2, col - 2) == 'M'))
    else
      (cell(grid, row + 1, col + 1) == 'A') &&
        ((cell(grid, row, col) == 'M' && cell(grid, row + 2, col + 2) == 'S') ||
        (cell(grid, row, col) == 'S' && cell(grid, row + 2, col + 2) == 'M'))
    end
  end

  def all_lines(grid)
    (grid + all_diagonal_lines_right(grid) + all_diagonal_lines_left(grid) + all_columns(grid))
      .flat_map { |x| x.size == 1 ? [x.join] : [x.join, x.reverse.join] }
  end

  def all_diagonal_lines_right(grid)
    (0...(grid.length * 2) - 1).map { |i| diagonal_line_right(grid, i) }
  end

  def all_diagonal_lines_left(grid)
    (0...(grid.length * 2) - 1).map { |i| diagonal_line_left(grid, i) }
  end

  def diagonal_line_right(grid, i)
    i.downto(0).map { |row| (grid[row] || [])[i - row] }.compact
  end

  def diagonal_line_left(grid, i)
    diagonal_line_right(grid.map(&:reverse), i)
  end

  def all_columns(grid)
    (0...grid.size).map { |col| column(grid, col) }
  end

  def column(grid, col)
    grid.map { |row| row[col] }
  end
end
