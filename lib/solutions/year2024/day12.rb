# frozen_string_literal: true

require_relative '../day'

class Day12 < Day
  def part2
    grid = read_input(split1: "\n").map(&:chars)
    areas = areas(grid)

    areas.map { |area| price area }.sum
  end

  def price(area)
    area.size * borders(area)
  end

  def borders(area)
    vertical_borders(area, 1) + vertical_borders(area, -1) + horizontal_borders(area, 1) + horizontal_borders(area, -1)
  end

  def vertical_borders(area, offset = 1)
    borders = []
    area.each do |row, col|
      new_col = col + offset

      next if area.include? [row, new_col]
      borders << [row, new_col]
    end
    count_vertical_borders(borders)
  end

  def horizontal_borders(area, offset = 1)
    borders = []
    area.each do |row, col|
      new_row = row + offset

      next if area.include? [new_row, col]
      borders << [new_row, col]
    end
    count_horizontal_borders(borders)
  end

  def count_vertical_borders(borders)
    borders
      .group_by(&:last)
      .transform_values { |value| value.map(&:first) }
      .values
      .flat_map { |list| list.slice_when { |prev, curr| curr != prev + 1 }.to_a }
      .count
  end

  def count_horizontal_borders(borders)
    borders
      .group_by(&:first)
      .transform_values { |value| value.map(&:last) }
      .values
      .flat_map { |list| list.slice_when { |prev, curr| curr != prev + 1 }.to_a }
      .count
  end

  def areas(grid)
    all = all_positions(grid).to_set
    areas = Set.new
    until all.empty?
      area = flood(grid, all.first)
      area.each do |position|
        all.delete(position)
      end
      areas.add(area)
    end
    areas
  end

  def all_positions(grid)
    (0...grid.length).flat_map do |row|
      (0...grid.first.length).map do |column|
        [row, column]
      end
    end
  end

  def flood(grid, pos)
    row, col = pos
    set = Set.new
    set.add([row, col])
    value = (grid[row] || [])[col]
    while true
      before = set.size
      set.flat_map { |r,c| neighbors(r, c)}
         .reject { |a| set.include?(a) }
         .select { |r, c| (grid[r] || [])[c] == value }
         .each do |neighbor|
        set.add(neighbor)
      end
      break if set.size == before
    end
    set.sort
  end

  def neighbors(row, col)
    [[row - 1, col], [row + 1, col], [row, col - 1], [row, col + 1]]
      .reject { |row, col| row < 0 || col < 0 }
  end
end
