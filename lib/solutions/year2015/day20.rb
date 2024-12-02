# frozen_string_literal: true

require_relative '../day'
require 'prime'

class Day20 < Day
  def factors_of(number)
    return [1] if number == 1

    primes, powers = number.prime_division.transpose
    exponents = powers.map { |i| (0..i).to_a }
    divisors = exponents.shift.product(*exponents).map do |powers|
      primes.zip(powers).map { |prime, power| prime**power }.inject(:*)
    end
    divisors.sort
  end

  def score(number)
    factors_of(number).sum * 10
  end

  def part1
    number = 1
    number += 1 until score(number) >= 36_000_000
    number
  end

  def score2(number)
    factors_of(number).reject { |factor| number / factor > 50 }.sum * 11
  end

  def part2
    number = 1
    until score2(number) >= 36_000_000
      puts number
      number += 1
    end
    number
  end
end
