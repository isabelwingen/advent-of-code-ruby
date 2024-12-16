# frozen_string_literal: true

class Vector2d
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def inspect
    [@row, @col].inspect
  end

  def +(other)
    Vector2d.new(@row + other.row, @col + other.col)
  end

  def -(other)
    Vector2d.new(@row - other.row, @col - other.col)
  end

  def diff(other)
    Vector2d.new(other.row - @row, other.col - @col)
  end

  def manhattan(other)
    (@row - other.row).abs + (@col - other.col).abs
  end

  def ==(other)
    @row == other.row && @col == other.col
  end

  def eql?(other)
    self == other
  end

  def hash
    [@row, @col].hash
  end
end
