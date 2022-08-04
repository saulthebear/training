# Leetcode: 121. Best Time to Buy and Sell Stock
# https://leetcode.com/problems/best-time-to-buy-and-sell-stock/

def maxProfit(prices):
    left = 0
    right = 1
    maxProfit = 0
    
    while right < len(prices):
        print(f'left: {prices[left]}, right: {prices[right]}')
        if prices[left] < prices[right]:
            maxProfit = max(prices[right] - prices[left], maxProfit)
        else:
            left = right
        right += 1
    
    print(f'buy: {left} sell: {right} profit: {maxProfit}')
    
    return maxProfit
    
prices = [1,2,4,2,5,7,2,4,9,0,9]
print(maxProfit(prices))