# frozen_string_literal: true

require_relative '../day'

class Day14 < Day

  WIDTH = 101
  HEIGHT = 103

  def part1
    read_input(split1: "\n")
      .map { |x| parse(x) }
      .map { |p, v| move(p, v) }
      .reject { |x, _| x == WIDTH / 2 }
      .reject { |_, y| y == HEIGHT / 2 }
      .group_by { |p| quadrant(p) }
      .transform_values(&:count)
      .values
      .reduce(&:*)
  end

  def part2
    positions = read_input(split1: "\n").map { |x| parse(x) }
    c = 0
    until positions.map(&:first).size == positions.map(&:first).to_set.size
      positions = positions.map { |p, v| move2(p, v) }
      c += 1
    end
    pretty_print(positions)
  end

  def pretty_print(positions)
    pos = positions.map(&:first)
    max_x = pos.map(&:first).max
    max_y = pos.map(&:last).max
    (0...max_y).each do |y|
      (0...max_x).each do |x|
        if pos.include? [x, y]
          print '#'
        else
          print '.'
        end
      end
      puts
    end
  end

  def tree?(positions)
    line_counts = positions.map(&:first)
                           .group_by(&:last)
                           .sort_by { |k, _| k }
                           .map { |_, v| v.map(&:first).count }
                           .reject { |p| p.zero?}

    line_counts == line_counts.sort
  end

  def quadrant(position)
    x, y = position
    if x < WIDTH / 2 && y < HEIGHT / 2
      1
    elsif x < WIDTH / 2
      3
    elsif y < HEIGHT / 2
      2
    else
      4
    end
  end

  def move(position, velocity, steps: 100, height: HEIGHT, width: WIDTH)
    p_x, p_y = position
    v_x, v_y = velocity
    [(p_x + steps * v_x).modulo(width), (p_y + steps * v_y).modulo(height)]
  end

  def move2(position, velocity, steps: 1, height: HEIGHT, width: WIDTH)
    p_x, p_y = position
    v_x, v_y = velocity
    [[(p_x + steps * v_x).modulo(width), (p_y + steps * v_y).modulo(height)], velocity]
  end

  def parse(line)
    p, v = line.split(" ")
    p_x, p_y = p[2..].split(",").map(&:to_i)
    v_x, v_y = v[2..].split(",").map(&:to_i)
    [[p_x, p_y], [v_x, v_y]]
  end
end
