# frozen_string_literal: true

require_relative '../day'

class Day5 < Day

  def part1
    rules, updates = rules_and_updates
    updates.select { |update| right_order? update, rules }
           .map { |update| middle_elem(update) }
           .sum
  end

  def part2
    rules, updates = rules_and_updates
    updates.reject { |update| right_order? update, rules }
           .map { |update| sort(update, rules) }
           .map { |update| middle_elem(update) }
           .sum
  end

  private

  def rules_and_updates
    lines = read_input(split1: "\n")
    rules = lines.take_while { |line| !line.chomp.empty? }
                 .map { |x| x.split('|') }
                 .map { |line| line.map(&:to_i) }
    updates = lines.drop_while { |line| !line.chomp.empty? }.drop(1)
                   .map { |x| x.split(',') }
                   .map { |line| line.map(&:to_i) }
    [rules, updates]
  end

  def sort(update, rules)
    relevant_rules = rules.select { |a, b| update.include?(a) && update.include?(b) }
                          .select { |a, b| update.index(a) > update.index(b) }
    return update if relevant_rules.empty?

    relevant_rules.each do |a, b|
      if update.index(a) > update.index(b)
        update[update.index(a)] = b
        update[update.index(b)] = a
      end
    end
    sort(update, rules)
  end

  def middle_elem(list)
    middle = list.size / 2
    list[middle]
  end

  def right_order?(update, rules)
    (0...update.size).each do |i|
      current = update[i]
      left_rules = rules.select { |a, b| b == current && update.include?(a) }
                        .all? { |a, _| update.index(a) < i }
      right_rules = rules.select { |a, b| a == current && update.include?(b) }
                         .all? { |_, b| update.index(b) > i }
      return false if !left_rules || !right_rules
    end
    true
  end
end
