# Union Bank of Carlie
# Banking App by Carlie Hamilton
# version: 2.0
# Now with classes!

require 'yaml' # save each account details
require_relative './bank_account.rb' # here is my bank classes

# here are some variables.
line = "-"
welcome = "| --  Welcome to the Union Bank of Carlie  -- |"
like_to_do = "What would you like to do? Select from: (b)alance, (d)eposit, (w)ithdraw, (h)istory or exit"

# load the accounts
# accounts = YAML.load_file('accounts.yml')

# The app begins... 
puts line * welcome.length
puts welcome
puts line * welcome.length
puts "Please enter your name:"
name = gets.chomp.capitalize

account = BankAccount.new(name)

# Check the pin number
puts "Please enter your pin"
pin_attempt = gets.chomp.to_i
account.get_pin(pin_attempt)

puts like_to_do
choice = gets.chomp.downcase
case choice
when "b", "balance"
    account.get_balance
else
    puts "Oops, something went wrong. Please try again"
end