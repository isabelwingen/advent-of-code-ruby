# frozen_string_literal: true

require_relative '../day'
require_relative '../../util/grid'

class Day3 < Day
  def map_to_moves(char)
    case char
    when '^'
      :up
    when 'v'
      :down
    when '>'
      :left
    else
      :right
    end
  end

  def part1
    houses = Hash.new(0)
    houses[[0, 0]] = 1
    grid = Grid.new
    read_input.each_char do |c|
      houses[grid.move(map_to_moves(c))] += 1
    end
    houses.count
  end

  def part2
    houses = Hash.new(0)
    houses[[0, 0]] = 2
    santas = [Grid.new, Grid.new]
    read_input.each_char.with_index do |c, index|
      houses[santas[index % 2].move(map_to_moves(c))] += 1
    end
    houses.count
  end
end
