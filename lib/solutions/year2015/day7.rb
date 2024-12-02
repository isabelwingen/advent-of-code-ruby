# frozen_string_literal: true

require_relative '../day'
class Day7 < Day
  COMMANDS = %(in and or lshift rshift not)

  def initialize
    super
    @registers = {} # Initialize @registers as an instance variable
  end

  def parse(line)
    left, right = line.split ' -> '
    lefts = left.split
    if lefts.length == 1
      { command: :in, left: left, register: right }
    elsif lefts.length == 2
      { command: :not, left: lefts[1], register: right }
    elsif lefts.include? 'AND'
      { command: :and, left: lefts[0], right: lefts[2], register: right }
    elsif lefts.include? 'OR'
      { command: :or, left: lefts[0], right: lefts[2], register: right }
    elsif lefts.include? 'RSHIFT'
      { command: :rshift, left: lefts[0], right: lefts[2], register: right }
    elsif lefts.include? 'LSHIFT'
      { command: :lshift, left: lefts[0], right: lefts[2], register: right }
    end
  end

  def value(input)
    input.to_i if Integer(input)
  rescue StandardError
    @registers[input]
  end

  def next_gate(gate)
    left_value = value(gate[:left])
    right_value = value(gate[:right])
    right_present = gate[:right].nil? || right_value
    left_value && right_present
  end

  def pack(integer)
    [integer].pack('S<').unpack1('b*')
  end

  def unpack(binary_string)
    [binary_string].pack('b*').unpack1('S<')
  end

  def execute_gate(gate)
    new_value = case gate[:command]
                when :in
                  value(gate[:left])
                when :and
                  value(gate[:left]) & value(gate[:right])
                when :or
                  value(gate[:left]) | value(gate[:right])
                when :rshift
                  value(gate[:left]) >> value(gate[:right])
                when :lshift
                  value(gate[:left]) << value(gate[:right])
                when :not
                  ~value(gate[:left])
                else
                  raise 'should not happen'
                end
    @registers[gate[:register]] = unpack(pack(new_value))
  end

  def part1
    gates = read_input(split1: "\n").map { |line| parse(line) }

    while gates.any?
      gates.select { |gate| next_gate(gate) }.each do |gate|
        execute_gate(gate)
        gates.delete(gate)
      end
    end
    @registers['a']
  end

  def part2
    gates = read_input(split1: "\n").map { |line| parse(line) }
    b_gate = gates.select { |gate| gate[:register] == 'b' && gate[:command] == :in }.first
    b_gate[:left] = part1.to_s
    @registers = {}

    while gates.any?
      gates.select { |gate| next_gate(gate) }.each do |gate|
        execute_gate(gate)
        gates.delete(gate)
      end
    end
    @registers['a']
  end
end
