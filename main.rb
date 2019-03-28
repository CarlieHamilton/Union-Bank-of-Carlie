# Banking App by Carlie Hamilton
# https://github.com/BlueCodeThree/CA-ruby
# todo - save transaction history
#      - if account suspended, immidiately exit
#      - work out why it deleted the data when suspending account

require 'io/console' # dependency for the password
require 'yaml' # for saving my accounts hash

# here are some variables. The $ means they are "global" variables so I can use them in my methods
line = "-"
welcome = "| --  Welcome to the banking app  -- |"
$like_to_do = "What would you like to do? (type: 'balance', 'deposit', 'withdraw', 'history' or 'exit')"
$transactions = []  

# load the accounts
$accounts = YAML.load_file('accounts.yml')

# open balance file to get all the accounts and their users
# b_file = File.read('accounts.rb')  
#     accounts = b_file

# The app begins...
puts line * welcome.length
puts welcome
puts line * welcome.length
puts "Please enter your name:"
$name = gets.chomp
if $accounts.has_key? $name
    puts "Hi #{$name}! Please enter your pin:"
    guess_count = 0
    password_guess = IO::console.getpass
    while password_guess.to_i != $accounts[$name][:pin]
        guess_count = guess_count + 1
        if guess_count < 3
            puts "Oops! Try again! Please type in your password"
            password_guess = IO::console.getpass
        else
            system('clear')
            puts "Your pin does not match"
            $accounts[$name] = {suspended: true}
            File.write('accounts.yml', $accounts.to_yaml)
            puts "Your account has been suspended"
            puts "Please contact your bank"
            abort
        end
    end
else 
    $accounts[$name] = {}
    puts "please create a pin:"
    password_save1 =  IO::console.getpass
    puts "please type your pin again:"
    password_save2 =  IO::console.getpass
    while password_save1 != password_save2
        system('clear')
        puts "Oops! Your passwords did not match. Please try againg!"
        puts "please create a pin:"
        password_save1 =  IO::console.getpass
        puts "please type your pin again:"
        password_save2 =  IO::console.getpass
    end
    $accounts[$name] = {pin: password_save1.to_i, balance: 0}
    File.write('accounts.yml', $accounts.to_yaml)
    
end

puts " "
puts "Welcome #{$name}!" 

# This method is for the initial user input for what they would like to do (display balance, deposit etc)
def banking_stuff()
           
    puts $like_to_do
    $user_input = gets.chomp
    banking_loop()
end

# This is my loops for checking the balance, etc. Once something has been selected, it goes back to the start by calling a method again. 
def banking_loop()
    system('clear')
    case $user_input
    when "b","balance"
        puts "Your balance is $#{$accounts[$name][:balance]}" 
        puts " "
        banking_stuff()
    when "d","deposit"
        puts "How much would you like to deposit?"
        deposit = gets.chomp.to_i
        $accounts[$name][:balance] = $accounts[$name][:balance] + deposit
        File.write('accounts.yml', $accounts.to_yaml)
        $transactions.push("deposit: $#{deposit}, balance: $#{$balance}")
        puts "Your balance is $#{$accounts[$name][:balance]}"
        puts " "
        banking_stuff()
    when "w","withdraw"
        puts "How much would you like to withdraw?"
        withdraw = gets.chomp.to_i
        puts $accounts[$name][:balance]
        if withdraw > $accounts[$name][:balance]
            while true
                puts "Ooops, you don't have that much. Please try again!"
                puts "How much would you like to withdraw?"
                withdraw = gets.chomp.to_i
                if withdraw <= $accounts[$name][:balance]
                    $accounts[$name][:balance] = $accounts[$name][:balance] - withdraw
                    File.write('accounts.yml', $accounts.to_yaml)
                    $transactions.push("withdraw: $#{withdraw}, balance: $#{$accounts[$name][:balance]}")
                    puts "You withdrew #{withdraw}"
                    puts "Your balance is now #{$accounts[$name][:balance]}"
                    puts " "
                    banking_stuff()
                end
            end
        else
            $accounts[$name][:balance] = $accounts[$name][:balance] - withdraw
            File.write('accounts.yml', $accounts.to_yaml)
            $transactions.push("withdraw $#{withdraw}, balance: $#{$accounts[$name][:balance]}")
            puts "You withdrew $#{withdraw}"
            puts "Your balance is now $#{$accounts[$name][:balance]}"
            banking_stuff()
        end
    when "h","history"
        puts $transactions
        banking_stuff()
    when "exit"
        abort("Bye #{$name}")
    else
        while true
            puts "Sorry, something happened. Please try again"
            puts $like_to_do
            $user_input = gets.chomp
            if $user_input == "balance" or $user_input == "deposit" or $user_input == "exit" or user_input == "withdraw"
                banking_loop()
            end
        end
    end
end

while true
    banking_stuff()
end




