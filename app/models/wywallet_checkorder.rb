class WywalletCheckorder < ActiveRecord::Base
  attr_accessible :acquirer_id, :agreement_id, :client_id, :client_id_type, :client_ip, :custom_parameters, :description, :order_id, :postback_timeout, :postback_url, :transmission_time
end
