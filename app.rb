require 'rubygems'
require 'bundler'
require 'sinatra'
require 'yahoofinance'
require 'chartkick'
require 'date'

get '/' do
    erb :form
end


post '/your-stock-price' do

@today = DateTime 
  @input = params[:symbol].upcase
  # Check for blank input
  if @input == ""
    erb :error
  else
    # Fetch data from YF
    @quote = YahooFinance::get_standard_quotes(@input)
    @daysHash = YahooFinance::get_historical_quotes_days(@input, 7)
    @history = []
    @daysHash.each do |day|  
      @history << [day[0] , day[4]]
    end
    @name = @quote[@input].name
    # Error handling
    if @quote[@input].valid?
      @buy = @quote[@input].lastTrade
     # @sell = @quote[@input].ask
      erb :stock_price
    else
      erb :error
    end
  end
end