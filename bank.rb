# Banking App by Carlie Hamilton
# https://github.com/BlueCodeThree/CA-ruby

# dependency for the password
require 'io/console'

# here are some variables. The $ means they are "global" variables so I can use them in my methods
$balance = 0
line = "-"
welcome = "Welcome to the banking app"
password = "1234"
$like_to_do = "What would you like to do? (type: 'balance', 'deposit', 'withdraw', 'history' or 'exit')"
$transactions = []


# The app begins...
puts line * welcome.length
puts welcome
puts line * welcome.length
puts "Please enter your name:"
$name = gets.chomp
puts "Hi #{$name}! Please enter your password:"
password_guess = IO::console.getpass
while password_guess != password
    puts "Oops! Try again! Please type in your password"
    password_guess = gets.chomp
end

puts " "
puts "Alright #{$name}," 

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
        puts "Your balance is $#{$balance}"
        puts " "
        banking_stuff()
    when "d","deposit"
        puts "How much would you like to deposit?"
        deposit = gets.chomp.to_i
        $balance = $balance + deposit
        $transactions.push("deposit: $#{deposit}, balance: $#{$balance}")
        puts "Your balance is $#{$balance}"
        puts " "
        banking_stuff()
    when "w","withdraw"
        puts "How much would you like to withdraw?"
        withdraw = gets.chomp.to_i
        if withdraw > $balance
            while true
                puts "Ooops, you don't have that much. Please try again!"
                puts "How much would you like to withdraw?"
                withdraw = gets.chomp.to_i
                if withdraw <= $balance
                    $balance = $balance - withdraw
                    $transactions.push("withdraw: $#{withdraw}, balance: $#{$balance}")
                    puts "You withdrew #{withdraw}"
                    puts "Your balance is now #{$balance}"
                    puts " "
                    banking_stuff()
                end
            end
        else
            $balance = $balance - withdraw
            $transactions.push("withdraw $#{withdraw}, balance: $#{$balance}")
            puts "You withdrew $#{withdraw}"
            puts "Your balance is now $#{$balance}"
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




