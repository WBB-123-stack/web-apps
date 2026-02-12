# EXERCISE
# Using the Ruby hash `bitcoin_data`, display a summary of
# Bitcoin data for the user. Something like the output below.

# enter amount of Bitcoin the user owns as a float (e.g. 1.0)
bitcoin = 0.25

# connect to the Blockchain.com Exchange Rates API
# DON'T CHANGE THIS CODE
# ----------------------
require "net/http"
require "json"
url = "https://blockchain.info/ticker"
uri = URI(url)
response = Net::HTTP.get(uri)
bitcoin_data = JSON.parse(response)
# ----------------------

# using the API, extract current rate of bitcoin in USD
usd_rate = bitcoin_data["USD"]["last"]

# calculate value in USD of user's bitcoin
usd_value = usd_rate * bitcoin

# output
puts "You have #{usd_rate} Bitcoin."
puts "1 Bitcoin is valued at $#{usd_rate} USD."
puts "Your Bitcoin is worth $#{usd_value}."
