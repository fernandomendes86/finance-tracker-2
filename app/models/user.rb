class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  STOCK_LIMIT = 10

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    return false unless stock

    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.size < STOCK_LIMIT
  end

  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end
end
