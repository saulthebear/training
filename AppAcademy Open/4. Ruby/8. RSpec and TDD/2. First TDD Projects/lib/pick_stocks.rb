def pick_stocks(prices)
  best_pair = []
  best_profit = 0

  (0..(prices.length - 1)).each do |day1|
    (day1...prices.length).each do |day2|
      profit = prices[day2] - prices[day1]
      if profit.positive? && profit > best_profit
        best_profit = profit
        best_pair = [day1, day2]
      end
    end
  end

  best_pair
end
