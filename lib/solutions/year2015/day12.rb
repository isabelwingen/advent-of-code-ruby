# frozen_string_literal: true

require 'json'
require_relative '../day'

class Day12 < Day
  def sum_all_numbers(json)
    case json
    when Array
      json.map { |j| sum_all_numbers(j) }.sum
    when Hash
      sum_all_numbers(json.values)
    when Integer
      json
    when String
      0 # skip
    else
      raise "Could not handle: #{json}"
    end
  end

  def part1
    input = JSON.parse(read_input.to_s)
    sum_all_numbers(input)
  end

  def sum_all_numbers2(json)
    case json
    when Array
      json.map { |j| sum_all_numbers2(j) }.sum
    when Hash
      if json.values.include? 'red'
        0
      else
        sum_all_numbers2(json.values)
      end
    when Integer
      json
    when String
      0 # skip
    else
      raise "Could not handle: #{json}"
    end
  end

  def part2
    input = JSON.parse(read_input.to_s)
    sum_all_numbers2(input)
  end
end
