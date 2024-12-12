# frozen_string_literal: true

require_relative '../day'

class Day9 < Day
  def part1
    numbers = read_input.strip.chars.map(&:to_i)
    start, last = build_linked_list(numbers)
    start, last = move_last(start, last) until start.compact?
    checksum(start)
  end

  def part2
    numbers = read_input.strip.chars.map(&:to_i)
    start, last = build_linked_list(numbers)
    move_whole(start, last)
    checksum(start)
  end

  private

  def checksum(start)
    sum = 0
    id = 0
    current = start
    until current.nil?
      unless current.value.nil?
        id.upto(id + current.size - 1) do |i|
          sum += current.value * i
        end
      end
      id += current.size
      current = current.succ
    end
    sum
  end

  def move_whole(start, last)
    current = last
    until current == start
      next_node = current.pre
      find_place_and_move(start, current) unless current.value.nil?
      current = next_node
    end
  end

  def find_place_and_move(start, current)
    new_place = find_place_with_enough_space(start, current)
    return if new_place.nil?

    add_to_new_space(new_place, current)
    current.value = nil
  end

  def add_to_new_space(new_space, current)
    residue = new_space.size - current.size
    new_space.value = current.value
    new_space.size = current.size
    add_node(new_space, Node.new(nil, nil, nil, residue)) unless residue.zero?
  end

  def find_place_with_enough_space(start, current)
    place = start.succ
    until place.free? && place.size >= current.size
      return nil if place == current

      place = place.succ
    end
    place
  end

  def move_last(start, last)
    new_last = last.pre
    last.pre.succ = nil
    fill_in(start, last.value, last.size) unless last.value.nil?
    [start, new_last]
  end

  def fill_in(start, value, size)
    current = start
    n = size
    while n.positive?
      current = current.build_succ until current.empty_space?
      current.value = value
      if n == current.size
        n = 0
      elsif n < current.size
        # pre -> current -> succ
        y = Node.new(current, current.succ, nil, current.size - n)
        current.size = n
        current.succ = y
        y.succ.pre = y
        n = 0
      else
        n -= current.size
      end
    end
  end

  def add_node(before, node)
    succ = before.succ
    before.succ = node
    node.pre = before
    node.succ = succ
    succ.pre = node
  end

  def build_linked_list(numbers)
    start = Node.new(nil, nil, nil, 0)
    current = start
    numbers.each_with_index do |number, index|
      current.succ = if index.odd? # free space
                       Node.new(current, nil, nil, number)
                     else
                       Node.new(current, nil, index / 2, number)
                     end
      current = current.succ
    end
    [start, current]
  end

  class Node
    def initialize(pre, succ, value, size)
      @pre = pre
      @succ = succ
      @value = value
      @size = size
    end

    attr_accessor :pre, :succ, :value, :size

    def no_space?
      @size.zero?
    end

    def free?
      @value.nil?
    end

    def empty_space?
      free? && !no_space?
    end

    def compact?
      current = self
      until current.nil?
        return false if current.empty_space?

        current = current.succ
      end
      true
    end

    def build_succ
      if @succ.nil?
        new_node = Node.new(self, nil, nil, 1)
        self.succ = new_node
      end
      @succ
    end

    def to_s
      string = ''
      current = self
      until current.nil?
        value = current.value || '.'
        string += (value.to_s * current.size)
        current = current.succ
      end
      string
    end
  end
end
