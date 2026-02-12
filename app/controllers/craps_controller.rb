class CrapsController < ApplicationController
  before_action :set_user

  def index
    @bet = params[:bet].to_i
    
    # if there is no point, this is the come-out roll
    if session[:point].nil?
      handle_come_out_roll
    else
      # this is not the come-out roll, we are trying to hit the point
      handle_point_roll
    end
  end

  private

  def set_user
    # In a real app, you would have a proper user authentication system
    # For now, we'll just use the first user
    @user = User.first
  end

  def handle_come_out_roll
    @die1 = rand(1..6)
    @die2 = rand(1..6)
    @total = @die1 + @die2

    # on come-out roll:
    # 7 or 11 is a win
    # 2, 3, or 12 is a loss
    # anything else becomes the point
    if @total == 7 || @total == 11
      process_win
    elsif @total == 2 || @total == 3 || @total == 12
      process_loss
    else
      @outcome = "The point is #{@total}. Roll again to hit the point."
      session[:point] = @total
      session[:bet] = @bet
      @user.wallet -= @bet
      @user.save
    end
  end

  def handle_point_roll
    @point = session[:point]
    @bet = session[:bet]
    @die1 = rand(1..6)
    @die2 = rand(1..6)
    @total = @die1 + @die2

    # if we roll the point, we win
    # if we roll a 7, we lose
    # otherwise, we roll again
    if @total == @point
      process_win
    elsif @total == 7
      process_loss
    else
      @outcome = "You rolled a #{@total}. Roll again to hit the point (#{@point})."
    end
  end

  def process_win
    winnings = @bet * 2
    @user.wallet += winnings
    @user.save
    @outcome = "You win! You won $#{winnings}."
    session[:point] = nil
    session[:bet] = nil
  end

  def process_loss
    @outcome = "You lose! You lost $#{@bet}."
    session[:point] = nil
    session[:bet] = nil
  end
end

