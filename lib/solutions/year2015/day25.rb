# frozen_string_literal: true

class Day25
  def triangular_number(n)
    (1..n).sum
  end

  def position(row, col)
    triangular_number(row + col - 1) - (row - 1)
  end

  def code(position)
    if position == 1
      20_151_125
    else
      (20_151_125 * 252_533.pow(position - 1, 33_554_393)).modulo(33_554_393)
    end
  end

  def part1
    position(2947, 3029)
    code(position(2947, 3029))
  end
end
