# frozen_string_literal: true

require_relative '../day'

class Day13 < Day
  def part1
    read_input(split1: "\n")
      .each_slice(4)
      .map { |x| parse(x, false) }
      .map { |cm| cm.minimal_costs }
      .compact
      .sum
  end

  def part2
    read_input(split1: "\n")
      .each_slice(4)
      .map { |x| parse(x, true) }
      .map { |cm| cm.solve }
      .compact
      .sum
  end

  private

  def parse(chunk, part2)
    a, b, c = chunk
    left_a, right_a = a[10..].split(", ").map { |x| x[2..].to_i }
    left_b, right_b = b[10..].split(", ").map { |x| x[2..].to_i }
    left_c, right_c = c[7..].split(", ").map { |x| x[2..].to_i }
    ClawMachine.new(left_a, right_a, left_b, right_b, left_c, right_c, part2)
  end

  class ClawMachine
    def initialize(a_x, a_y, b_x, b_y, p_x, p_y, part2)
      @a_x = a_x
      @a_y = a_y
      @b_x = b_x
      @b_y = b_y
      @p_x = p_x
      @p_x += 10000000000000 if part2
      @p_y = p_y
      @p_y += 10000000000000 if part2
    end

    def solve
      # a * a_x + b * b_x = p_x
      # a * a_y + b * b_y = p_y

      q = @p_x * @a_y - @a_x * @p_y
      r = @a_y * @b_x - @b_y * @a_x
      b = q / r

      return nil unless q.modulo(r).zero?

      t = @p_y - b * @b_y
      a = t / @a_y
      return nil unless t.modulo(@a_y).zero?

      3 * a + b
    end

    def minimal_costs
      x = x_pairs.to_set
      y = y_pairs.to_set
      intersection = x & y

      return nil if intersection.empty?

      intersection.map { |a, b| a * 3 + b}.min
    end

    def x_pairs(early_break = false)
      results = []
      max_a = @p_x / @a_x
      0.upto(max_a) do |t|
        diff = @p_x - t * @a_x
        times_b = diff / @b_x
        results << [t, times_b] if times_b > 0 && diff.modulo(@b_x).zero?

        break if early_break && results.size > 1
      end
      results
    end

    def y_pairs(early_break = false)
      results = []
      max_a = @p_y / @a_y
      0.upto(max_a) do |t|
        diff = @p_y - t * @a_y
        times_b = diff / @b_y
        results << [t, times_b] if times_b > 0 && diff.modulo(@b_y).zero?

        break if early_break && results.size > 1
      end
      results
    end
  end
end
