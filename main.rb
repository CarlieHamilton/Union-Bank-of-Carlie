# Union Bank of Carlie - Banking App by Carlie Hamilton
# https://github.com/BlueCodeThree/Union-Bank-of-Carlie

# TODO
# make it so that it uses two decimal points
# error checking for input of monies
# way for user to cancel and go back to menu
# way to change pin
# history shows past 5 transactions, with an option to see the next five and previous five

require 'io/console' # dependency for the password
require 'yaml' # for saving my accounts hash
require './methods.rb' # some external methods 

# here are some variables.
line = "-"
welcome = "| --  Welcome to the Union Bank of Carlie  -- |"
like_to_do = "What would you like to do? (type: 'balance', 'deposit', 'withdraw', 'history' or 'exit')"

# load and save the accounts
accounts = YAML.load_file('accounts.yml')
save_account = File.write('accounts.yml', accounts.to_yaml)

# The app begins... 
puts line * welcome.length
puts welcome
puts line * welcome.length
puts "Please enter your name:"
name = gets.chomp.capitalize

# Current user - check if has suspended account, check pin
if accounts.has_key? name
    if accounts[name][:suspended] == true
        account_suspended
    else
        puts "Hi #{name}! Please enter your pin:"
        guess_count = 0
        password_guess = IO::console.getpass
        while password_guess.to_i != accounts[name][:pin]
            guess_count += 1
            if guess_count < 3
                puts "Oops! Try again! Please type in your password"
                password_guess = IO::console.getpass
            else
                system('clear')
                puts "Your pin does not match"
                accounts[name][:suspended] = true
                save_account
                account_suspended
            end
        end
    end

# Create a new user
else 
    accounts[name] = {}
    create_pin
    while password_save1 != password_save2
        system('clear')
        puts "Oops! Your passwords did not match. Please try again!"
        create_pin
    end
    accounts[name] = {pin: password_save1.to_i, balance: 0, suspended: false, history: ["#{Time.now} - Account Opened, Balance: $0"]}
    save_account
end

puts " "
puts "Welcome #{name}!" 

# This method is for the initial user input for what they would like to do (display balance, deposit etc)
while true
    puts " "
    puts like_to_do
    user_input = gets.chomp
    system('clear')
    case user_input
    when "b","balance"
        puts "Your balance is $#{accounts[name][:balance]}" 
    when "d","deposit"
        puts "How much would you like to deposit?"
        deposit = gets.chomp.to_i
        accounts[name][:balance] = accounts[name][:balance] + deposit
        accounts[name][:history] << "#{Time.now} - Deposit: $#{deposit}, Balance: $#{accounts[name][:balance]}"
        save_account
        puts "Your balance is now $#{accounts[name][:balance]}"
    when "w","withdraw"
        puts "Your balance is $#{accounts[name][:balance]}"
        puts "How much would you like to withdraw?"
        withdraw = gets.chomp.to_i
        if withdraw > accounts[name][:balance]
            withdraw_error = true
            while withdraw_error == true
                puts "Ooops, you don't have that much. Please try again!"
                puts "How much would you like to withdraw?"
                withdraw = gets.chomp.to_i
                if withdraw <= accounts[name][:balance]
                    withdraw_money(withdraw, accounts, name, save_account)
                    withdraw_error = false
                end
            end
        else
            withdraw_money(withdraw, accounts, name, save_account)
        end
    when "h","history"
        puts "Transaction history for #{name}:"
        puts accounts[name][:history]
    when "exit"
        abort("Goodbye #{name}!")
    else
        puts "Sorry, something happened. Please try again"
    end
end