# frozen_string_literal: true

require_relative '../day'

class Day24 < Day
  def group_with_weight(weight, groups)
    if weight.negative? || groups.empty?
      false
    elsif groups.include?(weight) || weight.zero?
      true
    else
      groups.any? { |group| group_with_weight(weight - group, groups.reject { |g| g == group }) }
    end
  end

  def pair(weight, group, groups)
    if groups.reject { |p| p == group }.include?(weight - group)
      [group, weight - group].to_set
    else
      Set.new
    end
  end

  def groups_with_weight_and_size(weight, size, groups)
    if size == 2
      groups.map { |group| pair(weight, group, groups) }.reject(&:empty?).uniq
    else
      groups.flat_map do |group|
        groups_with_weight_and_size(weight - group, size - 1, groups.reject { |g| g == group })
          .map { |s| s << group }
      end.uniq
    end
  end

  def part1
    groups = read_input(split1: "\n").map(&:to_i)
    groups_with_weight_and_size(groups.sum / 4, 4, groups).map { |g| g.reduce(:*) }.min
  end
end
