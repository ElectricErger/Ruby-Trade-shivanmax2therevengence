require 'ruby-trade'

class MyApp
  include RubyTrade::Client

Tradeamount = 10000
UpdateInterval = 5
cycler=0

  # Called by the system when we connect to the exchange server
  def self.on_connect *args
    puts "Connected."

    update_orders

    this = self
    EM.add_periodic_timer UpdateInterval do
      this.update_orders
    end
  end

   #AI KICKS IN HERE
  def self.update_orders
	@buy_order.cancel
	@sell_order.cancel

	#Keeps our records of the max and min over different intevals
	if #{level1["ask"]} > max2Minutes
		max2Minutes = #{level1["ask"]}
	end
	if #{level1["ask"]} < min2Minutes
	min2Minutes = #{level1["ask"]}
	end
        if #{level1["ask"]} > max30Sec
                max30Sec = #{level1["ask"]}
        end
        if #{level1["ask"]} < min30Sec
        min30Sec = #{level1["ask"]}
        end


	#Resets values if they go over their time frame
	cycler = cycler + 1
	if cycler%(12*4)==0
		max2Minutes = #{level1["ask"]}
		min2Minutes = #{level1["ask"]}
	end
	if cycler%12==0
		max30Sec = #{level1["ask"]}
		min30Sec = #{level1["ask"]}
	end
  end

	













  # Called whenever something happens on the exchange
  def self.on_tick level1
    puts "Cash: #{cash}"
    puts "Stock: #{stock}"
    puts "Bid: #{level1["bid"]}"
    puts "Ask: #{level1["ask"]}"
    puts "Last: #{level1["last"]}"
  end

  # Called when an order gets filled
  def self.on_fill order, amount, price
    puts "Order ID #{order.id} was filled for #{amount} shares at $%.2f" % price
  end

  # Called when an order gets partially filled
  def self.on_partial_fill order, amount, price
    puts "Order ID #{order.id} was partially filled for #{amount} shares at $%.2f" % price

    # Cancel the order
    @buy_order.cancel!
  end

end

# Connect to the server
MyApp.connect_to "127.0.0.1", as: "shivanmax2therevengence"
