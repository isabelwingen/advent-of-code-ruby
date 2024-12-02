# frozen_string_literal: true

class Day10
  INPUT = '1113122113'

  def step(list)
    list.slice_when { |prev, curr| prev != curr }
        .flat_map { |l| [l.size, l.first] }
  end

  def part1
    input = INPUT.chars.map(&:to_i)
    50.times.inject(input) { |accumulator, _| step(accumulator) }.size
  end
end
