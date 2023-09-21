class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  
  STOCK_LIMIT = 10
  SEARCH_ATTRIBUTES = [:first_name, :last_name, :email].freeze 

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

  def self.search(param, current_user = nil)
    param.strip!
    users = SEARCH_ATTRIBUTES.each_with_object([]) do |attribute, result|
      result << where("#{attribute} like ?", "%#{param}%")
    end

    users.flatten.uniq.reject{ |user| user == current_user}
  end

  def can_track_friend?(friend)
    return true if friend 
  end
end
