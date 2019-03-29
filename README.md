# Union Bank of Carlie
Welcome to the Union Bank of Carlie - a totally secure place to save all your monies*

This is a banking app that runs in terminal. 

## Running the file
In terminal, navigate to the location of the file, and start the app using the command: `ruby main.rb`

## Features of the app
The app begins by asking for a name. If the user is already in the system, they are prompted to put in their pin. The pin is hidden from displaying in the terminal. If the user gets the pin correct, they have access to the main part of the banking app. If the user gets the pin incorrect three times they are locked out of the system. 

If the user is not in the system, the user is prompted to create a pin, and a new user is created. 

Once in the main banking loop, the user has the option to either:

- `balance`
- `deposit`
- `withdraw` - the user will not be able to withdraw more than their balance
- `history` - displays a history of the transactions
- `exit` - ends the program.

Account names, balance and transaction histories are saved in the `accounts.yml` file.

## Some ways to improve the app
Here are my thoughts of things that could be implemented in the future:

- make it so that it uses two decimal points - currently the app only uses integers
- error checking for input of the money - currently if the input is not able to be converted to an integer (because it is letters, etc), it just returns `0`
- way for user to cancel and go back to menu
- way to change pin

\* This is not a secure place to store your monies
