# Leetcode: 121. Best Time to Buy and Sell Stock
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

def maxProfit(prices):
    maxAfter = [0] * len(prices)
    maxPrice = prices[-1]
    
    for i in range(len(prices) - 2, -1, -1):
        maxAfter[i] = maxPrice
        maxPrice = max(maxPrice, prices[i])
    
    maxProfit = 0
    
    for i in range(len(prices)):
        potentialProfit = maxAfter[i] - prices[i]
        maxProfit = max(maxProfit, potentialProfit)
    
    return maxProfit
    
prices = [7,6, 4, 3, 1]
print(maxProfit(prices))