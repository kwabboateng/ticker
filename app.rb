require 'rubygems'
require 'bundler'
require 'sinatra'
require 'yahoofinance'
require 'chartkick'
require 'date'
require 'stock_quote'
require 'json'
get '/' do
    erb :form
end


post '/your-stock-price' do
 @bgcolor = "" 
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
      
      stock = StockQuote::Stock.quote(@input)
      @target_price = stock.oneyr_target_price

      url = 'https://www.kimonolabs.com/api/b9lszajm?apikey=fXtugRoRyvuslv1YDNFkzpHufv2KK6jO'
      url_s = "&s="+@input+"+Analyst+Opinion"
      response = JSON.parse(RestClient.get(url+url_s))
      puts response['results']['Collection'][0]['MeanRT']

      @wallstreet = 'buy'
      if (response['results']['Collection'][0]['MeanRT']).to_i == 3
        @bgcolor = "yellow"
        @wallstreet = 'hold'
      elsif (response['results']['Collection'][0]['MeanRT']).to_i > 3
        @bgcolor = "red"
        @wallstreet = 'sell'
      end
        

      url2 = 'https://www.kimonolabs.com/api/bu8zjgds?apikey=fXtugRoRyvuslv1YDNFkzpHufv2KK6jO'
      url_s2 ="&s="+@input+"+Analyst+Estimates"
      response2 = JSON.parse(RestClient.get(url2))
      @pe = response2['results']['Growth'][0]
        @peInd = nil
        if @pe['company'].to_i > @pe['industry'].to_i
           @peInd = 'Expensive'
        else  
           @peInd = 'Cheap'
        end
      erb :stock_price
    else
      erb :error
    end
  end
end