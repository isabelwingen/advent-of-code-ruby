# frozen_string_literal: true

require_relative '../day'
require_relative '../../util/vector2d'

class Day8 < Day
  def part1
    lines = read_input(split1: "\n")
    positions = {}
    @max_row = lines.size - 1
    @max_col = lines[0].size - 1
    lines.each_with_index do |line, row|
      line.chars.each_with_index do |char, col|
        next if char == '.'

        if positions.include? char
          positions[char] << Vector2d.new(row, col)
        else
          positions[char] = [Vector2d.new(row, col)]
        end
      end
    end
    all_anti_nodes(positions, method(:anti_nodes_for_pair2)).count
  end

  def all_anti_nodes(positions, fun)
    anti_nodes = Set.new
    positions.each_value do |arr|
      anti_nodes(arr, fun).each { |ant| anti_nodes << ant }
    end
    anti_nodes
  end

  def anti_nodes(arr, fun)
    anti_nodes = Set.new
    arr.each_with_index do |a, i|
      arr.each_with_index do |b, j|
        next if j <= i

        fun.call(a, b).each { |ant| anti_nodes << ant }
      end
    end
    anti_nodes
  end

  def anti_nodes_for_pair(a, b)
    diff = b - a
    [b + diff, a - diff]
      .reject { |vector| vector.row.negative? || vector.col.negative? }
      .reject { |vector| vector.row > @max_row || vector.col > @max_col }
  end

  def anti_nodes_for_pair2(a, b)
    diff = b - a
    result = Set.new
    result << a
    result << b
    next_node = b + diff
    while valid?(next_node)
      result << next_node
      next_node += diff
    end

    next_node = a - diff
    while valid?(next_node)
      result << next_node
      next_node -= diff
    end
    result
  end

  def valid?(node)
    node.row >= 0 && node.row <= @max_row && node.col >= 0 && node.col <= @max_col
  end
end
