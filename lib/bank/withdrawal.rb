# frozen_string_literal: true

require 'transaction'

# withdrawal.rb
# Withdrawal class defined as
# child class of Transactions
# for save information about
# withdrawals of bank users
# and give interfaces for
# make withdrawals in different
# currencies
class Withdrawal < Transaction
  attr_accessor :currency, :amount, :account_id
  attr_accessor :withdrawal_id

  def initialize(account_id)
    super
    @withdrawal_id = auto_id
    @account_id    = account_id
  end

  def call
    # TODO
  end

  private

  def withdraw(amount, account_id, currency = :uah)
    # TODO
    compose(bills_hash, amount_formatter(amount))
  end
  # TODO

  def remainded_bills(bills_hash, used_bills_hash)
    # give information about bills after withdrawal
    used_bills_hash.keys.each do |key|
      bills_hash[key] -= used_bills_hash[key]
    end

    bills_hash
  end

  def compose(bills_hash, amount)
    # compose method for recursion
    # call greedy compose and resize hash
    arg_hash = bills_hash
    composed_bill = bill_greedy_compose(arg_hash, amount)

    while bills_hash_total(composed_bill) != amount
      arg_hash.delete(max_bill_in_hash(arg_hash))
      composed_bill = bill_greedy_compose(arg_hash, amount)
      return ERROR if arg_hash == {}
    end

    composed_bill
  end

  def bill_greedy_compose(bills_hash, amount)
    # simple greedy algorithm for compose bills
    used_bills_hash = {}

    bills_hash_keys_sort(bills_hash_clean(bills_hash)).reverse_each do |bill|
      next if amount < bill

      used_bills_hash[:"#{bill}"] = 0

      while amount >= bill && bills_hash[:"#{bill}"] > used_bills_hash[:"#{bill}"]
        amount -= bill
        used_bills_hash[:"#{bill}"] += 1
      end
    end

    used_bills_hash
  end

  def bills_hash_total(bills_hash)
    # count total of avaliable bills
    # return an integer num - total of hash values
    total_in_hash = 0

    bills_hash.each do |key, value|
      total_in_hash += (key.to_s.to_i * value.to_i)
    end

    total_in_hash
  end

  def bills_hash_clean(bills_hash)
    # cleaning hash with bills from non-existent and nil value key-value pairs
    # return hash without key-value where value nil or zero
    bills_hash.select { |_key, value| !value.nil? && value.positive? }
  end

  def bills_hash_keys_sort(bills_hash)
    # sorting hash keys in the order of growth
    # return an array with keys sorted from min to max
    bills_hash.keys.map { |e| e.to_s.to_i }.sort
  end

  def max_bill_in_hash(bills_hash)
    # return max bill key from hash
    :"#{bills_hash_keys_sort(bills_hash_clean(bills_hash))[-1]}"
  end

  def amount_formatter(amount)
    if amount.nil? || !amount.respond_to?(:to_i)
      false
    else
      amount.to_i
    end
  end
end