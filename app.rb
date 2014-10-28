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
  # Convert input to CAPS
#   data_table = GoogleVisualr::DataTable.new
#   # Add Column Headers
# data_table.new_column('string', 'Year' )
# data_table.new_column('number', 'Sales')
# data_table.new_column('number', 'Expenses')

# # Add Rows and Values
# data_table.add_rows([
#     ['2004', 1000, 400],
#     ['2005', 1170, 460],
#     ['2006', 660, 1120],
#     ['2007', 1030, 540]
# ])

# option = { width: 400, height: 240, title: 'Company Performance' }
# @chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

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