# frozen_string_literal: true

require_relative '../day'

class Day9 < Day
  def part1
    numbers = read_input.strip.chars.map(&:to_i)
    start, last = build_linked_list(numbers)
    start, last = move_last(start, last) until start.compact?
    start.to_s
  end

  private

  def move_last(start, last)
    new_last = last.pre
    last.pre.succ = nil
    fill_in(start, last.value, last.size)
    [start, new_last]
  end

  def fill_in(start, value, size)
    if start.succ.nil? # reached the end
      if start.free?
        start.value = value
        start.size = size
      else
        new_node = Node.new(start, nil, value, size)
        start.succ = new_node
      end
      return start
    end
    return fill_in(start.succ, value, size) unless start.free?

    return fill_in(start.succ, value, size) if start.no_space?

    if size < start.size
      pre = start.pre
      succ = start.succ
      x = Node.new(pre, nil, value, size)
      pre.succ = x
      y = Node.new(x, succ, nil, start.size - size)
      x.succ = y
      succ.pre = y
    else
      start.value = value
      fill_in(start, value, size - start.size) if size != start.size
    end
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
      if empty_space?
        false
      elsif @succ.nil?
        true
      else
        @succ.compact?
      end
    end

    def to_s
      string = (@value.to_s.chars.first || '.') * @size
      if @succ.nil?
        string
      else
        "#{string}#{@succ.to_s}"
      end
    end
  end
end
