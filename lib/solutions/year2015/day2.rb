# frozen_string_literal: true

require_relative '../day'
class Day2 < Day
  def paper_needed(box)
    (l, w, h) = box.map(&:to_i)
    a = l * w
    b = w * h
    c = h * l
    (2 * (a + b + c)) + [a, b, c].min
  end

  def volume(box)
    (l, w, h) = box.map(&:to_i)
    l * w * h
  end

  def ribbon_needed(box)
    (m, n) = box.map(&:to_i).sort.first(2)
    volume(box) + m + m + n + n
  end

  def part1
    boxes = read_input(split1: "\n", split2: 'x')
    boxes.map { |box| paper_needed(box) }.sum
  end

  def part2
    boxes = read_input(split1: "\n", split2: 'x')
    boxes.map { |box| ribbon_needed(box) }.sum
  end
end
