# frozen_string_literal: true

class Game
  def initialize(hard_mode: false)
    @poison = 0
    @shield = 0
    @recharge = 0
    @player_hp = 50
    @mana = 500
    @boss_hp = 51
    @mana_spent = 0
    @hard_mode = hard_mode
  end

  attr_reader :mana_spent

  def boss_dead?
    @boss_hp <= 0
  end

  def player_dead?
    @player_hp <= 0
  end

  def player_spells
    %i[magic_missile drain shield poison recharge]
      .map { |spell| clone.player_round(spell) }
      .compact
  end

  def boss_round
    apply_effects

    return self if @boss_hp <= 0

    return self if @player_hp <= 0

    @player_hp -= if @shield.positive?
                    2
                  else
                    9
                  end
    count_down_effects
    self
  end

  protected

  def player_round(spell)
    apply_effects
    count_down_effects
    @player_hp -= 1 if @hard_mode

    return self if @boss_hp <= 0

    @player_hp = 0 if @mana < 53

    return self if @player_hp <= 0 || @mana < 53

    send(spell)
  end

  private

  def poison
    return nil if @mana < 173 || @poison.positive?

    @mana -= 173
    @mana_spent += 173
    @poison = 6
    self
  end

  def shield
    return nil if @mana < 113 || @shield.positive?

    @mana -= 113
    @mana_spent += 113
    @shield = 6
    self
  end

  def recharge
    return nil if @mana < 229 || @recharge.positive?

    @mana -= 229
    @mana_spent += 229
    @recharge = 5
    self
  end

  def magic_missile
    return nil if @mana < 53

    @mana -= 53
    @mana_spent += 53
    @boss_hp -= 4
    self
  end

  def drain
    return nil if @mana < 73

    @mana -= 73
    @mana_spent += 73
    @boss_hp -= 2
    @player_hp += 2
    self
  end

  def count_down_effects
    @poison = [@poison - 1, 0].max
    @shield = [@shield - 1, 0].max
    @recharge = [@recharge - 1, 0].max
  end

  def apply_effects
    @boss_hp -= 3 if @poison.positive?
    @mana += 101 if @recharge.positive?
  end
end
