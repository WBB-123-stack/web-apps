class DiceController < ApplicationController
  def index
    @rolls = []
    10.times do
      die1 = rand(1..6)
      die2 = rand(1..6)
      @rolls << { die1: die1, die2: die2, total: die1 + die2 }
    end
  end
end
