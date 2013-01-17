class WywalletReversal < ActiveRecord::Base
  attr_accessible :acquirer_id, :agreement_id, :amount, :batch_id, :client_ip, :custom_parameters, :description, :order_id, :postback_timeout, :postback_url, :reconciliation_time, :purchase_transaction_id, :transmission_time, :vat_amount, :vat_format
end
