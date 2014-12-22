require 'rubygems'
#require 'awesome_print'
require 'stock_quote'
#  agent = Mechanize.new
#     agent.get("http://us.megabus.com/")
#     form = agent.page.parser.css('form')[0]
    
    
  
#     agent.page.forms[0]["JourneyPlanner$hidSelectedState"] = "Illinois"
#     agent.page.forms[0]["JourneyPlanner$hidSelectedOrigin"] = "Chicago, IL"
#      agent.page.forms[0]["JourneyPlanner$hidSelectedDest"] = "Ann Arbor, MI"
#     agent.page.forms[0]["JourneyPlanner$txtOutboundDate"] = "2015-01-30"
    
#      agent.page.forms[0].submit
#     page = agent.follow_meta_refresh = true
#     agent.page.forms[0].fields.each do |f|
#       puts  f.name
#     end 
#   agent.page.link_with(:text => 'JourneyPlanner$btnSearch').click
#   ap page
 # stock = StockQuote::Stock.quote("fb")
 #      puts stock.oneyr_target_price

url2 = 'https://www.kimonolabs.com/api/bu8zjgds?apikey=fXtugRoRyvuslv1YDNFkzpHufv2KK6jO'
      url_s2 ="&s="+"fb"+"+Analyst+Estimates"
      response2 = JSON.parse(RestClient.get(url2+url_s2))
      puts response2
      	#@pe = response2['results']['Growth'][0]
      	# if @growth['company'].to_i > @growth['industry'].to_i
      	# 	puts "EXPENSIVE"
      	# elsif  @growth['company'].to_i < @growth['industry'].to_i
      	# 	puts "CHEAP"
      	# end
      		
      		#puts @pe	