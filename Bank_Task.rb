require_relative 'logger'
class User
    attr_accessor :name, :balance
    def initialize(name, balance)
        @name = name
        @balance = balance
    end
end

class Transaction 
    attr_reader :user, :value
    def initialize(user, value) 
        @user = user
        @value = value
    end
end

class Bank
    def process_transactions(users,transactions,&block)
        raise "the method #{__method__} is not implemented in #{self.class}"
    end
end

class CBABank < Bank
    include Logger
    def process_transactions(users,transactions,&block)
        Logger.log_info("Processing transactions #{transactions.map{|t| "User #{t.user.name} transaction with value #{t.value}"}.join(", ")}") 
        transactions.each do |transaction|
            begin
                if !users.include?(transaction.user) 
                    raise "#{transaction.user.name} not exist in the bank !!"
                elsif transaction.value < 0 && (transaction.user.balance - transaction.value.abs) < 0
                    raise "Not enough balance"
                elsif transaction.user.balance - transaction.value.abs == 0
                    Logger.log_warning("#{transaction.user.name} has 0 balance")
                end
                transaction.user.balance += transaction.value
                block.call("success", transaction)
            rescue Exception => e
                block.call("failure", transaction, e)
            end
        end
    end
end
    

