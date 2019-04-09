class BankAccount
    attr_reader :name, :balance
    
    def initialize(name, balance=0, suspended=false, history=[])
        @name = name
        @pin = 4444
        @balance = balance
        @suspended = suspended
        @history = history
    end

    # Load the user's account.
    # def load_account(name, accounts) # this will need to see if it is in my class BankAccount. i.e. check if..... arg. confusing. So, my info is not in a hash, it's in this class.......
    #     if accounts.has_key? name
    #         if accounts[name][:suspended] == true
    #             account_susspended ### need to make this, currently in methords.rb
    #         else
    #             puts 
    #         end
    #     end
    # end

    # Create an account
    def create_account(name)

    end

    def get_pin(pin_attempt)
        correct_pin = false
        while correct_pin == false
            if pin_attempt == @pin
                correct_pin = true
            else
                puts "Oops, wrong pin. Please try again:"
                pin_attempt = gets.chomp.to_i
            end
        end
    end

    def get_balance
        puts "Hi #{@name}, your balance is $#{@balance}"
    end

    def withdraw_money()

    end

    def get_history()

    end

    def exit
        abort("Goodbye #{name}!")
    end

end