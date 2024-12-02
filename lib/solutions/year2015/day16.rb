# frozen_string_literal: true

require_relative '../day'

class Day16 < Day
  COMPARE_SUE = { children: 3,
                  cats: 7,
                  samoyeds: 2,
                  pomeranians: 3,
                  akitas: 0,
                  vizslas: 0,
                  goldfish: 5,
                  trees: 3,
                  cars: 2,
                  perfumes: 1 }.freeze
  def parse(line, index)
    line.scan(/(\w+): (\d+)/).to_h.transform_keys(&:to_sym)
        .transform_values(&:to_i).merge(id: index + 1)
  end

  def part1
    sues = read_input(split1: "\n").map.with_index { |line, i| parse(line, i) }
    COMPARE_SUE.each do |k, v|
      sues = sues.reject { |sue| sue[k] && sue[k] != v }
    end
    sues
  end

  def part2
    sues = read_input(split1: "\n").map.with_index { |line, i| parse(line, i) }
    COMPARE_SUE.each do |k, v|
      sues = if %i[cats trees].include?(k)
               sues.reject { |sue| sue[k] && sue[k] <= v }
             elsif %i[pomeranians goldfish].include?(k)
               sues.reject { |sue| sue[k] && sue[k] >= v }
             else
               sues.reject { |sue| sue[k] && sue[k] != v }
             end
    end
    sues
  end
end
