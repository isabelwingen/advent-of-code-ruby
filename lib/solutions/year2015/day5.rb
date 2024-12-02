# frozen_string_literal: true

require_relative '../day'

class Day5 < Day
  def naughty?(str)
    str.include?('ab') || str.include?('cd') || str.include?('pq') || str.include?('xy')
  end

  def nice?(str)
    str.chars.select { |char| %w[a e i o u].include? char }.count > 2 &&
      str.scan(/((.)\2*)/).map(&:first).any? { |x| x.size > 1 }
  end

  def part1
    read_input(split1: "\n").reject { |s| naughty?(s) }.count { |s| nice?(s) }
  end

  def correct_distance?(array)
    array.each do |a|
      array.each do |b|
        next if a == b
        return true if (a - b).abs > 1
      end
    end
    false
  end

  def condition1(str)
    str.chars.each_cons(2).with_index
       .map { |c, i| [c.join, i] }
       .group_by(&:first)
       .transform_values { |values| values.map { |_, b| b } }
       .select { |_, v| v.count > 1 }
       .any? { |_, v| correct_distance?(v) }
  end

  def condition2(str)
    str.chars.each_cons(3).map(&:join).any? { |x| x.chars.first == x.chars.last }
  end

  def part2
    read_input(split1: "\n").count { |s| condition1(s) && condition2(s) }
  end
end
