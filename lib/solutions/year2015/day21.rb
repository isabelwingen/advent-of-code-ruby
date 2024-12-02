# frozen_string_literal: true

require_relative '../day'

class Day21 < Day
  def round_odd(player, boss)
    damage_dealt = [player[:damage] - boss[:armor], 1].max
    boss[:hit_points] -= damage_dealt
  end

  def round_even(player, boss)
    damage_dealt = [boss[:damage] - player[:armor], 1].max
    player[:hit_points] -= damage_dealt
  end

  def play(player, b)
    boss = b.clone
    counter = 1
    until player[:hit_points] <= 0 || boss[:hit_points] <= 0
      if counter.even?
        round_even(player, boss)
      else
        round_odd(player, boss)
      end
      counter += 1
    end
    boss[:hit_points] <= 0
  end

  # Weapons:    Cost  Damage  Armor
  # Dagger        8     4       0
  # Shortsword   10     5       0
  # Warhammer    25     6       0
  # Longsword    40     7       0
  # Greataxe     74     8       0
  #
  # Armor:      Cost  Damage  Armor
  # Leather      13     0       1
  # Chainmail    31     0       2
  # Splintmail   53     0       3
  # Bandedmail   75     0       4
  # Platemail   102     0       5
  #
  # Rings:      Cost  Damage  Armor
  # Damage +1    25     1       0
  # Damage +2    50     2       0
  # Damage +3   100     3       0
  # Defense +1   20     0       1
  # Defense +2   40     0       2
  # Defense +3   80     0       3

  def built_players
    weapons = [
      { weapon1: 1, cost: 8, damage: 4, armor: 0 },
      { weapon2: 1, cost: 10, damage: 5, armor: 0 },
      { weapon3: 1, cost: 25, damage: 6, armor: 0 },
      { weapon4: 1, cost: 40, damage: 7, armor: 0 },
      { weapon5: 1, cost: 74, damage: 8, armor: 0 }
    ]
    armor = [
      {},
      { armor1: 1, cost: 13, damage: 0, armor: 1 },
      { armor2: 1, cost: 31, damage: 0, armor: 2 },
      { armor3: 1, cost: 53, damage: 0, armor: 3 },
      { armor4: 1, cost: 75, damage: 0, armor: 4 },
      { armor5: 1, cost: 102, damage: 0, armor: 5 }
    ]
    rings = [
      { ring1: 1, cost: 25, damage: 1, armor: 0 },
      { ring2: 1, cost: 50, damage: 2, armor: 0 },
      { ring3: 1, cost: 100, damage: 3, armor: 0 },
      { ring4: 1, cost: 20, damage: 0, armor: 1 },
      { ring5: 1, cost: 40, damage: 0, armor: 2 },
      { ring6: 1, cost: 80, damage: 0, armor: 3 }
    ]
    ring_combos = (0..5)
                  .flat_map { |i| ((i + 1)..5).flat_map { |j| [[], [i], [i, j]] } }
                  .uniq
                  .map { |combo| combo.map { |i| rings[i] } }
                  .map { |combo| combo.reduce({}) { |a, b| a.merge(b) { |_, o, n| o + n } } }
                  .uniq
    weapons.flat_map do |weapon|
      armor.flat_map do |armor|
        ring_combos.map do |ring|
          [weapon, armor, ring].reduce({}) { |a, b| a.merge(b) { |_k, c, d| c + d } }
        end
      end
    end
  end

  def part1
    boss = { hit_points: 103, damage: 9, armor: 2 }
    built_players.map { |player| player.merge(hit_points: 100) }
                 .select { |player| play(player, boss) }
                 .min_by { |player| player[:cost] }[:cost]
  end

  def part2
    boss = { hit_points: 103, damage: 9, armor: 2 }
    built_players.map { |player| player.merge(hit_points: 100) }
                 .reject { |player| play(player, boss) }
                 .max_by { |player| player[:cost] }[:cost]
  end
end
