class WywalletPurchase < ActiveRecord::Base
  attr_accessible :account_name, :acquirer_id, :agreement_id, :amount, :batch_id, :client_id, :client_id_type, :client_ip, :currency_iso, :custom_parameters, :description, :order_id, :postback_timeout, :postback_url, :product_id, :reconciliation_time, :transaction_id, :transmission_time, :vat_amount, :vat_format
end
