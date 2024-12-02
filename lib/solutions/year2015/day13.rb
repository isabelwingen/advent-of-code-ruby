# frozen_string_literal: true

require_relative '../day'

class Day13 < Day
  def parse(line)
    parts = line.split
    name = parts[10].slice(0..parts[10].length - 2)
    { person: parts[0], type: parts[2], value: parts[3].to_i, by: name }
  end

  def find_happiness_increase(person_a, person_b, edges)
    edge1 = edges.select { |edge| edge[:person] == person_a && edge[:by] == person_b }.first
    happiness_increase = if edge1[:type] == 'lose'
                           -edge1[:value]
                         else
                           edge1[:value]
                         end
    edge2 = edges.select { |edge| edge[:person] == person_b && edge[:by] == person_a }.first
    happiness_increase + if edge2[:type] == 'lose'
                           -edge2[:value]
                         else
                           edge2[:value]
                         end
  end

  def part1
    edges = read_input(split1: "\n").map { |p| parse(p) }
    persons = edges.map { |edge| edge[:person] }.uniq
    stack = [{ path: [persons.first], happiness: 0 }]
    result = { path: [], happiness: 0 }
    until stack.empty?
      current = stack.pop
      last_person = current[:path].last
      other_persons = persons.reject { |person| current[:path].include?(person) }
      if other_persons.empty?
        total_happiness = current[:happiness] + find_happiness_increase(last_person,
                                                                        current[:path].first, edges)
        if total_happiness > result[:happiness]
          result = { path: current[:path],
                     happiness: total_happiness }
        end
      else
        other_persons.each do |other_person|
          happiness_increase = find_happiness_increase(last_person, other_person, edges)
          stack.unshift(
            { path: current[:path] + [other_person],
              happiness: current[:happiness] + happiness_increase }
          )
        end
      end
    end
    result
  end
end
