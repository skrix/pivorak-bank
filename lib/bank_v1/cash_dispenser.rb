# frozen_string_literal: true

require_relative 'errors_out'

# cash_dispenser.rb
# CashDispenser class defined for
# storing information about
# banknotes avaliable in current
# cash dispenser in different
# currencies and provide interfaces
# for user login/logout and interactions
# with bank database and interfaces
class CashDispenser
  attr_accessor :banknotes

  def initialize(database = {})
    @banknotes = database.fetch('banknotes')
    @error     = ErrorsOut.new
  end
  # TODO
  # banknotes update add/remove

  def withdraw(amount, currency = 'uah')
    # TODO
    max_in_dispenser = total(banknotes[currency])
    return @error.over_the_limit(max_in_dispenser) if amount > max_in_dispenser
    used_banknotes = compose(banknotes[currency], amount_formatter(amount))
    @banknotes     = remainded_bills(banknotes[currency], used_banknotes)
    'Withdrawal Completed!'
  end
  # TODO

  def total(bills)
    total ||= 0
    bills.each do |key, value|
      total += key * value
    end
    total.to_i
  end

  def remainded_bills(banknotes, used_banknotes)
    # give information about bills after withdrawal
    used_banknotes.keys.each do |key|
      banknotes[key] -= used_banknotes[key]
    end

    banknotes
  end

  def compose(banknotes, amount)
    # compose method for recursion
    # call greedy compose and resize hash
    arg_hash = banknotes
    composed_bill = bill_greedy_compose(arg_hash, amount)

    while banknotes_total(composed_bill) != amount
      arg_hash.delete(max_bill_in_hash(arg_hash))
      composed_bill = bill_greedy_compose(arg_hash, amount)
      return error.composing_error if arg_hash == {}
    end

    composed_bill
  end

  def bill_greedy_compose(banknotes, amount)
    # simple greedy algorithm for compose bills
    used_banknotes = {}

    banknotes_keys_sort(banknotes_clean(banknotes)).reverse_each do |bill|
      next if amount < bill

      used_banknotes[bill] = 0

      while amount >= bill && banknotes[bill] > used_banknotes[bill]
        amount -= bill
        used_banknotes[bill] += 1
      end
    end

    used_banknotes
  end

  def banknotes_total(banknotes)
    # count total of avaliable bills
    # return an integer num - total of hash values
    total_in_hash = 0

    banknotes.each do |key, value|
      total_in_hash += (key.to_s.to_i * value.to_i)
    end

    total_in_hash
  end

  def banknotes_clean(banknotes)
    # cleaning hash with bills from non-existent and nil value key-value pairs
    # return hash without key-value where value nil or zero
    banknotes.select { |_key, value| !value.nil? && value.positive? }
  end

  def banknotes_keys_sort(banknotes)
    # sorting hash keys in the order of growth
    # return an array with keys sorted from min to max
    banknotes.keys.map { |e| e.to_s.to_i }.sort
  end

  def max_bill_in_hash(banknotes)
    # return max bill key from hash
    :"#{banknotes_keys_sort(banknotes_clean(banknotes))[-1]}"
  end

  def amount_formatter(amount)
    if amount.nil? || !amount.respond_to?(:to_i)
      false
    else
      amount.to_i
    end
  end
end
