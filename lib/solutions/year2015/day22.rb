# frozen_string_literal: true

require_relative '../day'
require_relative '../../util/game'

class Day22 < Day
  def children(game, res)
    return [] if game.player_dead?

    return [] if !res.nil? && game.mana_spent > res

    game.player_spells.map { |child| child }
  end

  def do_boss_round(child)
    if child.player_dead? || child.boss_dead?
      child
    else
      child.boss_round
    end
  end

  def find_solution(hard_mode: false)
    stack = [Game.new(hard_mode: hard_mode)]
    res = nil
    until stack.empty?
      current = stack.pop

      if current&.boss_dead?
        res = current.mana_spent if res.nil? || res > current.mana_spent
        next
      end

      children(current, res)
        .map { |child| do_boss_round(child) }
        .each { |child| stack.push(child) }
    end
    res
  end

  def part1
    find_solution(hard_mode: false)
  end

  def part2
    find_solution(hard_mode: true)
  end
end
