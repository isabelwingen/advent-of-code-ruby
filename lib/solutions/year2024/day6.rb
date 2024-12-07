# frozen_string_literal: true

require_relative '../day'

class Day6 < Day
  def part1
    grid = read_input(split1: "\n").map(&:chars)
    row = grid.index { |line| line.include? '^' }
    col = grid[row].index('^')
    dir = '^'
    move_trough_grid(grid, row, col, dir)
  end

  private

  def all_obstacles(grid)
    obstacles = Set.new
    (0...grid.size).each do |row|
      (0...grid[0].size).each do |col|
        obstacles.add([row, col]) if grid[row][col] == '#'
      end
    end
    obstacles
  end

  def possible_positions(grid)
    positions = Set.new
    (0...grid.size).each do |row|
      (0...grid[0].size).each do |col|
        positions.add([row, col]) if grid[row][col] == '.'
      end
    end
    positions
  end

  def move(grid, row, col, dir)
    case dir
    when '^'
      move_up(grid, row, col)
    when 'v'
      move_down(grid, row, col)
    when '>'
      move_right(grid, row, col)
    else
      move_left(grid, row, col)
    end
  end

  def move_right(grid, row, col)
    if cell(grid, row, col + 1) == '#'
      [row, col, 'v']
    else
      [row, col + 1, '>']
    end
  end

  def move_left(grid, row, col)
    if cell(grid, row, col - 1) == '#'
      [row, col, '^']
    else
      [row, col - 1, '<']
    end
  end

  def move_down(grid, row, col)
    if cell(grid, row + 1, col) == '#'
      [row, col, '<']
    else
      [row + 1, col, 'v']
    end
  end

  def move_up(grid, row, col)
    if cell(grid, row - 1, col) == '#'
      [row, col, '>']
    else
      [row - 1, col, '^']
    end
  end

  def move_trough_grid(grid, row, col, dir)
    seen = Set.new
    position = [row, col, dir]
    while position[0] >= 0 && position[0] < grid.size && position[1] >= 0 && position[1] < grid[0].size
      seen.add(position[0..1])
      position = move(grid, *position)
    end
    seen.size
  end

  def cell(grid, row, col)
    (grid[row] || [])[col]
  end
end
