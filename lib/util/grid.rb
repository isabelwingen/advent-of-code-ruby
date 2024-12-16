# frozen_string_literal: true

class Grid
  MOVES = %(left right up down)

  def initialize
    @current_row = 0
    @current_column = 0
    @values = Hash.new(nil)
  end

  def current_position=(pos)
    row, col = pos
    @current_row = row
    @current_column = col
  end

  def current_position
    [@current_row, @current_column]
  end

  def move(move, steps: 1)
    case move
    when :down
      @current_row += steps
    when :up
      @current_row -= steps
    when :right
      @current_column += steps
    else
      @current_column -= steps
    end
    [@current_row, @current_column]
  end

  def current_value=(value)
    @values[current_position] = value
  end

  def current_value
    @values[current_position]
  end

  def display
    row_min = @values.keys.map(&:first).min
    row_max = @values.keys.map(&:first).max
    col_min = @values.keys.map { |x| x[1] }.min
    col_max = @values.keys.map { |x| x[1] }.max
    (row_min..row_max).each do |row|
      (col_min..col_max).each do |col|
        if @values[[row, col]].nil?
          print ' '
        else
          print @values[[row, col]]
        end
      end
      puts
    end
  end
end
