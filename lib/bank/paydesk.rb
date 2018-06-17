# frozen_string_literal: true

class Paydesk
  ERROR = 'ERROR: THE AMOUNT YOU REQUESTED CANNOT BE COMPOSED FROM BILLS /
    AVAILABLE IN THIS ATM. PLEASE ENTER A DIFFERENT AMOUNT:'

  def initialize(bills_hash, amount)
    @bills_hash = bills_hash
    @amount     = amount
  end

  attr_reader :bills_hash, :amount

  def call
    compose_call(bills_hash, amount)
  end

  private

  def compose_call(bills_hash, amount)
    # call a compose function according to
    # data representation template string or hash
    return ERROR unless amount_formatter(amount)

    used_bills = compose(bills_hash, amount_formatter(amount))
    used_bills.each do |bill|
      bills_hash[bill] -= used_bills[bill]
    end
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
