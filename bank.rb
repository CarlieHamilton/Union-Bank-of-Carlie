# Banking App by Carlie Hamilton
# https://github.com/BlueCodeThree/CA-ruby

require 'io/console' # dependency for the password
require 'yaml' # for saving my hash

# here are some variables. The $ means they are "global" variables so I can use them in my methods
$balance = 0  # I should remove this when I have my multiple users working
line = "-"
welcome = "| --  Welcome to the banking app  -- |"
password = "1234"  # I'll remove this too
$like_to_do = "What would you like to do? (type: 'balance', 'deposit', 'withdraw', 'history' or 'exit')"
$transactions = []

# load the accounts
accounts = YAML.load_file('accounts.yml')

# open balance file to get all the accounts and their users
# b_file = File.read('accounts.rb')  
#     accounts = b_file

# The app begins...
puts line * welcome.length
puts welcome
puts line * welcome.length
puts "Please enter your name:"
$name = gets.chomp
if accounts.has_key? $name
    puts "Hi #{$name}! Please enter your pin:"
    password_guess = IO::console.getpass
    while password_guess.to_i != accounts[$name][:pin]
        puts "Oops! Try again! Please type in your password"
        password_guess = IO::console.getpass
    end
else 
    accounts[$name] = {}
    puts "please create a pin:"
    password_save1 =  IO::console.getpass
    puts "please type your pin again:"
    password_save2 =  IO::console.getpass
    if password_save1 == password_save2
        accounts[$name] = {pin: password_save1, balance: 0}
    end
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
        puts "Your balance is $#{$balance}"
        puts " "
        banking_stuff()
    when "d","deposit"
        puts "How much would you like to deposit?"
        deposit = gets.chomp.to_i
        $balance = $balance + deposit
        save_balance = File.open('balance.rb', 'w')
        save_balance.puts $balance
        save_balance.close
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
                    save_balance = File.open('balance.rb', 'w')
                    save_balance.puts $balance
                    save_balance.close
                    $transactions.push("withdraw: $#{withdraw}, balance: $#{$balance}")
                    puts "You withdrew #{withdraw}"
                    puts "Your balance is now #{$balance}"
                    puts " "
                    banking_stuff()
                end
            end
        else
            $balance = $balance - withdraw
            save_balance = File.open('balance.rb', 'w')
            save_balance.puts $balance
            save_balance.close
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




