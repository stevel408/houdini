# frozen_string_literal: true

# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
require 'stripe'
require 'calculate/calculate_fees'

module StripeUtils
  # Get the verification status from a stripe object
  # Some of our accounts seem to be marked 'Unverified,' but have no
  # fields_needed set and have transfers_enabled set to true. So for our system,
  # that practically means they are verified.
  def self.get_verification_status(stripe_acct)
    return 'verified' if stripe_acct.transfers_enabled

    stripe_acct.legal_entity.verification.status
  end

  def self.create_transfer(net_amount, stripe_account_id, currency)
    Stripe::Transfer.create({
                              amount: net_amount,
                              currency: currency || Settings.intntl.currencies[0],
                              recipient: 'self'
                            },
                            stripe_account: stripe_account_id)
  end

  def self.create_refund(stripe_charge, amount, reason)
    stripe_charge.refunds.create(
      amount: amount,
      refund_application_fee: true,
      reverse_transfer: true,
      reason: reason
    )
  end
end
