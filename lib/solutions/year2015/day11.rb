# frozen_string_literal: true

class Day11
  def count_up(char_array, id: 7)
    if id.negative?
      char_array
    elsif char_array[id] == 'z'
      char_array[id] = 'a'
      return count_up(char_array, id: id - 1)
    elsif char_array[id] == 'h'
      char_array[id] = 'j'
    elsif char_array[id] == 'k'
      char_array[id] = 'm'
    elsif char_array[id] == 'n'
      char_array[id] = 'p'
    else
      char_array[id] = char_array[id].succ
    end
    char_array
  end

  def condition_one(password)
    password.each_cons(3).any? { |l| l[1] == l[0].succ && l[2] == l[1].succ }
  end

  def condition_three(password)
    partitions = password.slice_when { |prev, curr| prev != curr }
    partitions.any? { |p| p.size > 3 } || (partitions.select { |p| p.size > 1 }.count > 1)
  end

  def valid(password)
    condition_one(password) && condition_three(password)
  end

  def part1
    password = 'hxbxwxba'.chars
    password = count_up(password) until valid(password)
    password.join
  end

  def part2
    password = count_up(part1.chars)
    password = count_up(password) until valid(password)
    password.join
  end
end
