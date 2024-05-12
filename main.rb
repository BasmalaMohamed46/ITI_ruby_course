require_relative 'logger'
require_relative 'Bank_Task'
include Logger
callback = -> (err_status, transaction, error = nil) do
    if err_status == "success"
        Logger.log_info("User #{transaction.user.name} transaction with value #{transaction.value} succeeded")
        puts "Call endpoint for success of User #{transaction.user.name} transaction with value #{transaction.value}"
    elsif err_status == "failure"
        Logger.log_error("User #{transaction.user.name} transaction with value #{transaction.value} failed with message #{error.message}")
        puts "Call endpoint for failure of User #{transaction.user.name} transaction with value #{transaction.value} with reason #{error.message}"
    end
end

users = [
  User.new("Ali", 200),
  User.new("Peter", 500),
  User.new("Manda", 100)
]

out_side_bank_users = [
  User.new("Menna", 400),
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(out_side_bank_users[0], -100)
]
cba=CBABank.new
cba.process_transactions(users,transactions,&callback)