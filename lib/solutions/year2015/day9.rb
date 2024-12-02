# frozen_string_literal: true

require_relative '../day'

class Day9 < Day
  def parse
    edges = read_input(split1: "\n").map do |line|
      parts = line.split
      { cities: Set.new([parts[0], parts[2]]), distance: parts.last.to_i }
    end
    nodes = edges.flat_map { |e| e[:cities].to_a }.uniq
    [edges, nodes]
  end

  def size(path)
    path.map { |x| x[:distance] }.sum
  end

  def potential_size_max(path)
    missing = 8 - path.size
    size(path) + (missing * 130)
  end

  def potential_size_min(path)
    missing = 8 - path.size
    size(path) + (missing * 3)
  end

  def part1
    edges, nodes = parse
    stack = nodes.map do |node|
      [{ node: node, distance: 0 }]
    end

    res = nil
    while stack.any?
      path = stack.pop
      next if res && res < potential_size_max(path)

      next_edges = edges.select { |edge| edge[:cities].include? path.last[:node] }
                        .reject do |edge|
        path.slice(0, path.size - 1).any? do |p|
          edge[:cities].include? p[:node]
        end
      end
                        .flat_map do |edge|
        next_node = edge[:cities].reject { |city| city == path.last[:node] }.first
        { node: next_node, distance: edge[:distance] }
      end
      if next_edges.empty?
        size = size(path)
        res = size if res.nil? || size < res
      end
      next_edges.each do |e|
        stack.unshift path + [e]
      end
    end
    res
  end

  def part2
    edges, nodes = parse
    stack = nodes.map do |node|
      [{ node: node, distance: 0 }]
    end

    res = nil
    while stack.any?
      path = stack.pop
      next if res && potential_size_max(path) < res

      next_edges = edges.select { |edge| edge[:cities].include? path.last[:node] }
                        .reject do |edge|
        path.slice(0, path.size - 1).any? do |p|
          edge[:cities].include? p[:node]
        end
      end
                        .flat_map do |edge|
        next_node = edge[:cities].reject { |city| city == path.last[:node] }.first
        { node: next_node, distance: edge[:distance] }
      end
      if next_edges.empty?
        size = size(path)
        res = size if res.nil? || size > res
      end
      next_edges.each do |e|
        stack.unshift path + [e]
      end
    end
    res
  end
end
