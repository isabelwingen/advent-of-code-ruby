# frozen_string_literal: true

require_relative '../day'

class Day19 < Day
  def parse(line)
    if line.empty?
      nil
    elsif line.include? '=>'
      a, d = line.split(' => ')
      b, c = d.split
      { from: a, to: b, safe: c == '#safe' }
    else
      line
    end
  end

  def replace_all(string_hsh, from, to)
    replacement_count = 0
    result = string_hsh[:result].gsub(/#{from}/) do
      replacement_count += 1
      to
    end
    { times: string_hsh[:times] + replacement_count, result: result }
  end

  def replace_once(string_hsh, from, to, weight = 1)
    if string_hsh[:result].include? from
      { times: string_hsh[:times] + weight, result: string_hsh[:result].sub(/#{from}/, to) }
    else
      string_hsh
    end
  end

  def clean_up(string_hsh, safe_rules)
    result = safe_rules.reduce(string_hsh) do |hsh, rule|
      replace_all(hsh, rule[:to], rule[:from])
    end
    if result[:result] == string_hsh[:result]
      result
    else
      clean_up(result, safe_rules)
    end
  end

  def clean_queue(queue)
    queue.group_by { |hash| hash[:result] }
         .map { |_, group| group.min_by { |hash| hash[:times] } }
  end

  def part2
    rules = read_input(split1: "\n").reverse.drop(1).map { |line| parse(line) }.compact
    safe_rules = rules.select { |rule| rule[:safe] }
    goal = parse(read_input(split1: "\n").last)
    goal = clean_up({ times: 0, result: goal }, safe_rules)
    goal = replace_once(goal, 'PMg', 'F')
    goal = replace_once(goal, 'PB', 'Ca')
    goal = replace_once(goal, 'CaF', 'F')
    goal = clean_up(goal, safe_rules) # remove first Rn (ORnFAr)
    goal = replace_once(goal, 'PTiTi', 'P', 2)
    goal = replace_once(goal, 'PBF', 'F', 2)
    goal = replace_once(goal, 'PBF', 'F', 2)
    goal = clean_up(goal, safe_rules) # remove next Rn (SiRnFYFAr)
    goal = replace_once(goal, 'SiAl', 'F')
    goal = replace_once(goal, 'BF', 'Mg')
    goal = clean_up(goal, safe_rules) # remove next Rn (SiRnMgAr)
    goal = replace_once(goal, 'SiAl', 'F')
    goal = replace_once(goal, 'CaF', 'F')
    goal = clean_up(goal, safe_rules) # remove next Rn (TiRnFAr)
    # clean up beginning
    goal = replace_once(goal, 'HCaCaCa', 'H', 3)
    goal = replace_once(goal, 'HSiTh', 'H', 2)
    goal = replace_once(goal, 'HCaCaSiTh', 'H', 4)
    goal = replace_once(goal, 'HCaCa', 'H', 2)
    goal = replace_once(goal, 'HPB', 'H', 2)
    goal = replace_once(goal, 'HCaCaCaSiTh', 'H', 5)
    goal = replace_once(goal, 'HCaCaSiTh', 'H', 4)
    goal = replace_once(goal, 'HCaCaCaCaCaCaCaCaCaCa', 'H', 10)
    # next Rn
    goal = replace_once(goal, 'CaCaP', 'P', 2)
    goal = replace_once(goal, 'PTi', 'P')
    goal = replace_once(goal, 'PB', 'Ca')
    goal = replace_once(goal, 'PB', 'Ca')
    goal = replace_once(goal, 'CaCaCaPTiTi', 'P', 5)
    goal = replace_once(goal, 'PMg', 'F')
    goal = replace_once(goal, 'PBF', 'F', 2)
    goal = replace_once(goal, 'HSi', 'N')
    goal = clean_up(goal, safe_rules) # remove next Rn (NRnFYFAr)
    goal = replace_once(goal, 'PB', 'Ca')
    goal = replace_once(goal, 'CaCaF', 'F', 2)
    goal = replace_once(goal, 'HCa', 'H')
    goal = replace_once(goal, 'HSi', 'N')
    goal = replace_once(goal, 'CaF', 'F')
    goal = clean_up(goal, safe_rules) # remove next Rn (NRnFAr)
    goal = replace_all(goal, 'TiMg', 'Mg')
    goal = clean_up(goal, safe_rules) # remove next Rn (NRnFAr)
    goal = replace_all(goal, 'SiAl', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = clean_up(goal, safe_rules) # remove next Rn
    goal = replace_all(goal, 'ThCa', 'Th')
    goal = clean_up(goal, safe_rules) # remove next Rn
    goal = replace_all(goal, 'SiAl', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'PB', 'Ca')
    goal = replace_all(goal, 'CaCa', 'Ca')
    goal = replace_all(goal, 'CaCa', 'Ca')
    goal = replace_all(goal, 'CaCa', 'Ca')
    goal = replace_all(goal, 'SiTh', 'Ca')
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = clean_up(goal, safe_rules) # remove next Rn
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'CaF', 'F')
    goal = replace_all(goal, 'BF', 'Mg')
    goal = clean_up(goal, safe_rules) # remove next Rn
    goal = replace_all(goal, 'PMg', 'F')
    goal = clean_up(goal, safe_rules) # remove next Rn
    goal = replace_all(goal, 'CaCa', 'Ca')
    goal = replace_all(goal, 'CaCa', 'Ca')
    goal = replace_all(goal, 'HCa', 'H')
    goal = replace_all(goal, 'HCa', 'H')
    goal = replace_once(goal, 'PTi', 'P')
    goal = replace_once(goal, 'HP', 'O')
    goal = replace_once(goal, 'OB', 'H')
    goal = replace_once(goal, 'CaP', 'P')
    goal = replace_once(goal, 'CaP', 'P')
    goal = replace_once(goal, 'PTi', 'P')
    goal = replace_once(goal, 'HP', 'O')
    goal = replace_once(goal, 'OB', 'H')
    goal = replace_once(goal, 'CaP', 'P')
    goal = replace_once(goal, 'HP', 'O')
    goal = replace_once(goal, 'OB', 'H')
    replace_once(goal, 'HF', 'e')
  end
end
