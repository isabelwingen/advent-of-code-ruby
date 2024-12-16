# frozen_string_literal: true

require_relative '../day'

class Day11 < Day
  def part1
    read_input.split.map(&:to_i).map { |stone| size(simulate(stone, 25)) }.sum
  end

  def part2
    input = read_input.split.map(&:to_i)
    @cache = {}
    sum = 0
    input.each do |stone|
      sum += size(calc_with_cache(stone, 75))
    end
    sum
  end

  private

  def calc_with_cache(stone, n)
    @cache[stone] ||= {}
    return @cache[stone][n] if @cache[stone].include? n

    @cache[stone][n] = if n == 5
                         simulate(stone, n)
                       else
                         go_one_step(stone, n)
                       end
  end

  def go_one_step(stone, n)
    calc_with_cache(stone, 5)
      .map { |next_stone, c| calc_with_cache(next_stone, n - 5).transform_values { |v| v * c } }
      .reduce({}) { |acc, hash| acc.merge(hash) { |_, old_val, new_val| old_val + new_val } }
  end

  def simulate(stone, n = 25)
    stones = { stone => 1 }
    (1..n).each do |_|
      stones = blink_once(stones)
    end
    stones
  end

  def blink_once(stones)
    stones
      .map { |stone, count| transform(stone).transform_values { |c| c * count } }
      .reduce({}) { |acc, hash| acc.merge(hash) { |_, old_val, new_val| old_val + new_val } }
  end

  def size(stone_hash)
    stone_hash.map { |_, count| count }.sum
  end

  def transform(stone)
    stone_as_string = stone.to_s
    if stone.zero?
      { 1 => 1 }
    elsif stone_as_string.length.even?
      l = stone_as_string.length
      a = stone_as_string.chars.take(l / 2).join.to_i
      b = stone_as_string.chars.drop(l / 2).join.to_i
      if a == b
        { a => 2 }
      else
        { a => 1, b => 1 }
      end
    else
      { stone * 2024 => 1 }
    end
  end
end
