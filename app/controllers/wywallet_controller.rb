require 'digest/sha1'

class WywalletController < ApplicationController
	before_filter :params_required, :except => :incorrect
	
	#Test WSDL Online PaymentService: 
	$test_wsdl = "https://mpaymenttest.payex.com/MAP/PaymentService?wsdl"
	
	#Production WSDL Online PaymentService: 
	$production_wsdl = "https://mps.payex.com/MAP/PaymentService?wsdl"	
	
	#Test endpoint URL (simulator)
	$test_url = "https://mpaymenttest.payex.com/MAP/PaymentServiceTest"
	#Namespase		
	$namespace = "http://map.payex.com/"
	
	
	$_TransmissionTime = DateTime.now.strftime('%Y-%m-%d %H:%M:%S')  #"2013-01-09 14:45:53"
	$_ClientIP = ""	
	$_PostbackURL = ""
	$_PostbackTimeout = 600
	
	$_AcquirerID = "WyWallet"
	$_AgreementID = "99990097"
	$_SharedSecret =  "map123"
	
	$_TransactionID = "577880106"
	$_Amount = 100
	$_VatAmount = 10
	$_CurrencyISOString = "SEK"
	$_ClientIdType = "MSISDN"
	$_ClientId = "004699999000"				  
	$_OrderId = "1"
	$_ReconciliationTime =  "2013-01-09 17:30:17"
	$_ProductId = "1"
	$_Description = "New iPhone 6G"
	$_CustomParameters = "param1=value1"
	$_VatFormat = "Amount"
	$_AccountName = ""
	
	def incorrect
		@result = "there are no paramteres in request"
		render "result"
	end
		
	def ping		
		_AcquirerID = params[:q][:AcquirerID]
		_AgreementID = params[:q][:AgreementID]
		_TransmissionTime = params[:q][:TransmissionTime]
		_ClientIP = params[:q][:ClientIP]
		_PostbackURL = params[:q][:PostbackURL]
		_PostbackTimeout = params[:q][:PostbackTimeout]
		_SharedSecret = params[:q][:SharedSecret]			
		@result = make_ping(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret)					
		render "result"
	end
	
	def purchase	
		purchase = WywalletPurchase.new(params[:q])
		if purchase.save			
			# get response data
			response = make_purchase(purchase, $_SharedSecret)
			h = response.body
			purchase.transaction_id =  h[:purchase_response][:return][:response][:transaction_id].to_s
			purchase.batch_id =  h[:purchase_response][:return][:response][:batch_id].to_i						
			purchase.transaction_status =  h[:purchase_response][:return][:status][:transaction_status].to_i
			purchase.transaction_status_desc =  h[:purchase_response][:return][:status][:transaction_status_desc].to_s
			purchase.operation_status =  h[:purchase_response][:return][:status][:operation_status].to_s
			purchase.operation_status_desc =  h[:purchase_response][:return][:status][:operation_status_desc].to_s			
			purchase.save
			@result = h
		else 
			@result = "error during saving data to DB"
		end		
		render "result"								
	end	
	
	def reversal	
		reversal = WywalletReversal.new(params[:q])
		if reversal.save			
			# get response data
			response = make_reversal(reversal, $_SharedSecret)
			h = response.body
			reversal.reversal_transaction_id =  h[:reversal_response][:return][:response][:transaction_id].to_s
			reversal.batch_id =  h[:reversal_response][:return][:response][:batch_id].to_i						
			reversal.transaction_status =  h[:reversal_response][:return][:status][:transaction_status].to_i
			reversal.transaction_status_desc =  h[:reversal_response][:return][:status][:transaction_status_desc].to_s
			reversal.operation_status =  h[:reversal_response][:return][:status][:operation_status].to_s
			reversal.operation_status_desc =  h[:reversal_response][:return][:status][:operation_status_desc].to_s			
			reversal.save
			@result = h
		else 
			@result = "error during saving data to DB"
		end							
		render "result"																	
	end	
	
	def credit	
		credit = WywalletCredit.new(params[:q])
		if credit.save			
			# get response data
			response = make_credit(credit, $_SharedSecret)
			h = response.body
			credit.transaction_id =  h[:credit_response][:return][:response][:transaction_id].to_s
			credit.batch_id =  h[:credit_response][:return][:response][:batch_id].to_i						
			credit.transaction_status =  h[:credit_response][:return][:status][:transaction_status].to_i
			credit.transaction_status_desc =  h[:credit_response][:return][:status][:transaction_status_desc].to_s
			credit.operation_status =  h[:credit_response][:return][:status][:operation_status].to_s
			credit.operation_status_desc =  h[:credit_response][:return][:status][:operation_status_desc].to_s			
			credit.save
			@result = h
		else 
			@result = "error during saving data to DB"
		end							
		render "result"								
	end
	
	def checkorder	
		checkorder = WywalletCheckorder.new(params[:q])
		if checkorder.save			
			# get response data
			response = make_checkorder(checkorder, $_SharedSecret)
			h = response.body			
			checkorder.transaction_id =  h[:check_order_response][:return][:response][:transaction_id].to_s
			checkorder.amount_authorized =  h[:check_order_response][:return][:response][:amount_authorized].to_i						
			checkorder.amount_captured =  h[:check_order_response][:return][:response][:amount_captured].to_i
			checkorder.amount_cancelled =  h[:check_order_response][:return][:response][:amount_cancelled].to_i
			checkorder.amount_reversed =  h[:check_order_response][:return][:response][:amount_reversed].to_i			
			checkorder.last_batch_id =  h[:check_order_response][:return][:response][:last_batch_id].to_i			
			checkorder.last_transaction_id =  h[:check_order_response][:return][:response][:last_transaction_id].to_s		
			checkorder.last_transaction_status =  h[:check_order_response][:return][:response][:last_transaction_status].to_i		
			checkorder.last_transaction_type =  h[:check_order_response][:return][:response][:last_transaction_type].to_i			
			checkorder.transaction_status =  h[:check_order_response][:return][:status][:transaction_status].to_i
			checkorder.transaction_status_desc =  h[:check_order_response][:return][:status][:transaction_status_desc].to_s
			checkorder.operation_status =  h[:check_order_response][:return][:status][:operation_status].to_s
			checkorder.operation_status_desc =  h[:check_order_response][:return][:status][:operation_status_desc].to_s			
			checkorder.save			
			@result = h
		else 
			@result = "error during saving data to DB"
		end							
		render "result"								
	end	
	
	private 
	
		def make_checkorder(obj, _SharedSecret)			
			client = get_savon_client					
			response = client.call(:CheckOrder) do
			  message(
				:arg0 => { 
					:header => get_header(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.client_ip, obj.postback_url, obj.postback_timeout), 
					:request => get_checkorder_request(obj.order_id, obj.client_id_type, obj.client_id, obj.custom_parameters),					
					:footer => get_footer(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.postback_url, obj.order_id, obj.client_id_type, obj.client_id, _SharedSecret) 
					}
				)
			end		
			return response		
		end		
		
		def make_credit(obj, _SharedSecret)			
			client = get_savon_client					
			response = client.call(:Credit) do
			  message(
				:arg0 => { 
					:header => get_header(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.client_ip, obj.postback_url, obj.postback_timeout), 
					:request => get_sales_request(obj.amount, obj.vat_amount, obj.currency_iso, obj.client_id_type, obj.client_id, obj.order_id, obj.reconciliation_time, obj.product_id, obj.description, obj.custom_parameters, obj.vat_format, obj.account_name), 
					:footer => get_footer(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.postback_url, obj.amount, obj.vat_amount, obj.currency_iso, obj.client_id_type, obj.client_id, obj.order_id, obj.reconciliation_time, obj.product_id, obj.description, obj.custom_parameters, _SharedSecret) 
					}
				)
			end			
			return response
		end				

		def make_reversal(obj, _SharedSecret)			
			client = get_savon_client					
			response = client.call(:Reversal) do
			  message(
				:arg0 => { 
					:header => get_header(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.client_ip, obj.postback_url, obj.postback_timeout), 
					:request => get_reversal_request(obj.purchase_transaction_id, obj.order_id, obj.amount, obj.vat_amount, obj.reconciliation_time, obj.description, obj.custom_parameters, obj.vat_format), 
					:footer => get_footer(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.postback_url, obj.purchase_transaction_id , obj.amount, obj.vat_amount, obj.reconciliation_time, _SharedSecret) 
					}
				)
			end			
			return response
		end	
		
		def make_purchase(obj, _SharedSecret)			
			client = get_savon_client					
			response = client.call(:Purchase) do
			  message(
				:arg0 => { 
					:header => get_header(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.client_ip, obj.postback_url, obj.postback_timeout), 
					:request => get_sales_request(obj.amount, obj.vat_amount, obj.currency_iso, obj.client_id_type, obj.client_id, obj.order_id, obj.reconciliation_time, obj.product_id, obj.description, obj.custom_parameters, obj.vat_format, obj.account_name), 
					:footer => get_footer(obj.acquirer_id, obj.agreement_id, obj.transmission_time, obj.postback_url, obj.amount, obj.vat_amount, obj.currency_iso, obj.client_id_type, obj.client_id, obj.order_id, obj.reconciliation_time, obj.product_id, obj.description, obj.custom_parameters, _SharedSecret) 
					}
				)
			end			
			return response
		end			
	
		def make_ping(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret)
			client = get_savon_client					
			response = client.call(:Ping) do
			  message(
				:arg0 => { 
					:header => get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout), 
					:footer => get_footer(_AcquirerID, _AgreementID, _TransmissionTime, _PostbackURL, _SharedSecret) 
					}
				)
			end					
			return response.body		
		end	
		
		def get_savon_client 
			client = Savon::Client.new do
			endpoint $test_url
			namespace $namespace
			env_namespace :soapenv
			namespace_identifier :map		
			convert_request_keys_to :none 				
			end		
		end
		
		def get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout)
			return {
				"AcquirerID" => _AcquirerID,
				"AgreementID" => _AgreementID,
				"TransmissionTime" => _TransmissionTime,
				"ClientIP" => _ClientIP,
				"PostbackURL" => _PostbackURL,
				"PostbackTimeout" => _PostbackTimeout
			}		
		end
		
		def get_footer(*s)		
			return {
				"MAC" => get_key(s)  
			} 		
		end		
			
		def get_checkorder_request(_OrderId, _ClientIdType, _ClientId, _CustomParameters)
			return {		
				"OrderId" => _OrderId,
				"ClientIdType" => _ClientIdType,
				"ClientId" => _ClientId,	
				"CustomParameters" => _CustomParameters
			}			
		end
		
		def get_reversal_request(_TransactionID, _OrderId, _Amount, _VatAmount, _ReconciliationTime, _Description, _CustomParameters, _VatFormat)
			return {
				"TransactionID" => _TransactionID,
				"Amount" => _Amount,
				"VatAmount" => _VatAmount,			
				"OrderId" => _OrderId,
				"ReconciliationTime" => _ReconciliationTime,		
				"Description" => _Description,		
				"CustomParameters" => _CustomParameters,		
				"VatFormat" => _VatFormat		
			}			
		end
		
		def get_sales_request(_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description, _CustomParameters, _VatFormat, _AccountName)
			return {
				"Amount" => _Amount,
				"VatAmount" => _VatAmount,
				"CurrencyISOString" => _CurrencyISOString,
				"ClientIdType" => _ClientIdType,
				"ClientId" => _ClientId,
				"OrderId" => _OrderId,
				"ReconciliationTime" => _ReconciliationTime,
				"ProductId" => _ProductId,
				"Description" => _Description,		
				"CustomParameters" => _CustomParameters,		
				"VatFormat" => _VatFormat,		
				"AccountName" => _AccountName			
			}			
		end
		
		def get_key(parameters_array)
			parameters_array.reject { |parameter| parameter.to_s.strip.empty? }
			key = Digest::SHA1.base64digest(parameters_array.join(''))
			return key[0..key.size/2 - 1]
		end
		
		
		def params_required		
			incorrect = false

			# here should be checking for credentials to avoid malicious requests
=begin			
			if ((params[:license] == nil) || (params[:corporate] == nil))
				incorrect = true
			else
				sql = "select activationCode from activation where corporateId = " + params[:corporate].to_s 
				sql_result = ActiveRecord::Base.connection.execute(sql)
				activation_code = ""
				if sql_result.first != nil
					activation_code = sql_result.first[0]
				end
				incorrect = activation_code != params[:license]
			end	
=end			

			if params[:q] == nil					
				incorrect = true				
			end			
			if incorrect 					
				redirect_to "/wywallet/incorrect"					
			end				
		end		

end
