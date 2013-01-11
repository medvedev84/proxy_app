require 'digest/sha1'

class WywalletController < ApplicationController

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
	
		
	def ping		
		if params[:q] != nil	
			_AcquirerID = params[:q][:AcquirerID]
			_AgreementID = params[:q][:AgreementID]
			_TransmissionTime = params[:q][:TransmissionTime]
			_ClientIP = params[:q][:ClientIP]
			_PostbackURL = params[:q][:PostbackURL]
			_PostbackTimeout = params[:q][:PostbackTimeout]
			_SharedSecret = params[:q][:SharedSecret]
		else
=begin		
			_AcquirerID = $_AcquirerID
			_AgreementID = $_AgreementID
			_TransmissionTime = $_TransmissionTime
			_ClientIP = $_ClientIP
			_PostbackURL = $_PostbackURL
			_PostbackTimeout = $_PostbackTimeout
			_SharedSecret = $_SharedSecret		
=end			
		end		
		@result = make_ping(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret)
		render "result"
	end
	
	def purchase	
		if params[:q] != nil	
			_AcquirerID = params[:q][:AcquirerID]
			_AgreementID = params[:q][:AgreementID]
			_TransmissionTime = params[:q][:TransmissionTime]
			_ClientIP = params[:q][:ClientIP]
			_PostbackURL = params[:q][:PostbackURL]
			_PostbackTimeout = params[:q][:PostbackTimeout]
			_SharedSecret = params[:q][:SharedSecret]
			
			_Amount = params[:q][:Amount]
			_VatAmount = params[:q][:VatAmount]
			_CurrencyISOString = params[:q][:CurrencyISOString]
			_ClientIdType = params[:q][:ClientIdType]
			_ClientId = params[:q][:ClientId]
			_OrderId = params[:q][:OrderId]
			_ReconciliationTime = params[:q][:ReconciliationTime]
			_ProductId = params[:q][:ProductId]
			_Description = params[:q][:Description]			
			_CustomParameters = params[:q][:CustomParameters]			
			_VatFormat = params[:q][:VatFormat]			
			_AccountName = params[:q][:AccountName]						
		else
=begin		
			_AcquirerID = $_AcquirerID
			_AgreementID = $_AgreementID
			_TransmissionTime = $_TransmissionTime
			_ClientIP = $_ClientIP
			_PostbackURL = $_PostbackURL
			_PostbackTimeout = $_PostbackTimeout
			_SharedSecret = $_SharedSecret	

			_Amount = $_Amount
			_VatAmount = $_VatAmount
			_CurrencyISOString = $_CurrencyISOString
			_ClientIdType = $_ClientIdType
			_ClientId = $_ClientId
			_OrderId = $_OrderId
			_ReconciliationTime = $_ReconciliationTime
			_ProductId = $_ProductId
			_Description = $_Description		
			_CustomParameters = $_CustomParameters			
			_VatFormat = $_VatFormat		
			_AccountName = $_AccountName	
=end			
		end		
		@result = make_purchase(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
								_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description,
								_CustomParameters, _VatFormat, _AccountName)
		render "result"								
	end	
	
	def reversal	
		if params[:q] != nil	
			_AcquirerID = params[:q][:AcquirerID]
			_AgreementID = params[:q][:AgreementID]
			_TransmissionTime = params[:q][:TransmissionTime]
			_ClientIP = params[:q][:ClientIP]
			_PostbackURL = params[:q][:PostbackURL]
			_PostbackTimeout = params[:q][:PostbackTimeout]
			_SharedSecret = params[:q][:SharedSecret]
			
			_TransactionID = params[:q][:TransactionID]
			_OrderId = params[:q][:OrderId]						
			_Amount = params[:q][:Amount]
			_VatAmount = params[:q][:VatAmount]			
			_ReconciliationTime = params[:q][:ReconciliationTime]			
			_Description = params[:q][:Description]			
			_CustomParameters = params[:q][:CustomParameters]			
			_VatFormat = params[:q][:VatFormat]							
		else
=begin		
			_AcquirerID = $_AcquirerID
			_AgreementID = $_AgreementID
			_TransmissionTime = $_TransmissionTime
			_ClientIP = $_ClientIP
			_PostbackURL = $_PostbackURL
			_PostbackTimeout = $_PostbackTimeout
			_SharedSecret = $_SharedSecret	

			_TransactionID = $_TransactionID
			_OrderId = $_OrderId
			_Amount = $_Amount
			_VatAmount = $_VatAmount
			_ReconciliationTime = $_ReconciliationTime
			_Description = $_Description		
			_CustomParameters = $_CustomParameters			
			_VatFormat = $_VatFormat		
=end			
		end		
		@result = make_reversal(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
								_TransactionID, _OrderId, _Amount, _VatAmount, _ReconciliationTime, _Description,
								_CustomParameters, _VatFormat)
		render "result"								
	end		
	
	def credit		
		if params[:q] != nil	
			_AcquirerID = params[:q][:AcquirerID]
			_AgreementID = params[:q][:AgreementID]
			_TransmissionTime = params[:q][:TransmissionTime]
			_ClientIP = params[:q][:ClientIP]
			_PostbackURL = params[:q][:PostbackURL]
			_PostbackTimeout = params[:q][:PostbackTimeout]
			_SharedSecret = params[:q][:SharedSecret]
			
			_Amount = params[:q][:Amount]
			_VatAmount = params[:q][:VatAmount]
			_CurrencyISOString = params[:q][:CurrencyISOString]
			_ClientIdType = params[:q][:ClientIdType]
			_ClientId = params[:q][:ClientId]
			_OrderId = params[:q][:OrderId]
			_ReconciliationTime = params[:q][:ReconciliationTime]
			_ProductId = params[:q][:ProductId]
			_Description = params[:q][:Description]			
			_CustomParameters = params[:q][:CustomParameters]			
			_VatFormat = params[:q][:VatFormat]			
			_AccountName = params[:q][:AccountName]						
		else
=begin		
			_AcquirerID = $_AcquirerID
			_AgreementID = $_AgreementID
			_TransmissionTime = $_TransmissionTime
			_ClientIP = $_ClientIP
			_PostbackURL = $_PostbackURL
			_PostbackTimeout = $_PostbackTimeout
			_SharedSecret = $_SharedSecret	

			_Amount = $_Amount
			_VatAmount = $_VatAmount
			_CurrencyISOString = $_CurrencyISOString
			_ClientIdType = $_ClientIdType
			_ClientId = $_ClientId
			_OrderId = $_OrderId
			_ReconciliationTime = $_ReconciliationTime
			_ProductId = $_ProductId
			_Description = $_Description		
			_CustomParameters = $_CustomParameters			
			_VatFormat = $_VatFormat		
			_AccountName = $_AccountName	
=end			
		end		
		@result = make_credit(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
								_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description,
								_CustomParameters, _VatFormat, _AccountName)								
		render "result"								
	end		
	
	def checkorder	
		if params[:q] != nil	
			_AcquirerID = params[:q][:AcquirerID]
			_AgreementID = params[:q][:AgreementID]
			_TransmissionTime = params[:q][:TransmissionTime]
			_ClientIP = params[:q][:ClientIP]
			_PostbackURL = params[:q][:PostbackURL]
			_PostbackTimeout = params[:q][:PostbackTimeout]
			_SharedSecret = params[:q][:SharedSecret]

			_ClientIdType = params[:q][:ClientIdType]
			_ClientId = params[:q][:ClientId]
			_OrderId = params[:q][:OrderId]		
			_CustomParameters = params[:q][:CustomParameters]							
		else
=begin		
			_AcquirerID = $_AcquirerID
			_AgreementID = $_AgreementID
			_TransmissionTime = $_TransmissionTime
			_ClientIP = $_ClientIP
			_PostbackURL = $_PostbackURL
			_PostbackTimeout = $_PostbackTimeout
			_SharedSecret = $_SharedSecret	

			_ClientIdType = $_ClientIdType
			_ClientId = $_ClientId
			_OrderId = $_OrderId		
			_CustomParameters = $_CustomParameters					
=end			
		end	
		@result = make_checkorder(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
							_OrderId, _ClientIdType, _ClientId,  
							_CustomParameters)
		render "result"								
	end		
	
	private 
	
		def make_checkorder(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
							_OrderId, _ClientIdType, _ClientId,  
							_CustomParameters)
			
			client = get_savon_client					
			response = client.call(:CheckOrder) do
			  message(
				:arg0 => { 
					:header => get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout), 
					:request => get_checkorder_request(_OrderId, _ClientIdType, _ClientId, _CustomParameters),					
					:footer => get_footer(_AcquirerID, _AgreementID, _TransmissionTime, _PostbackURL, _OrderId, _ClientIdType, _ClientId, _SharedSecret) 
					}
				)
			end		
			return response.body		
		end		
	
		def make_credit(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
			_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description,
			_CustomParameters, _VatFormat, _AccountName)
			
			client = get_savon_client					
			response = client.call(:Credit) do
			  message(
				:arg0 => { 
					:header => get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout), 
					:request => get_sales_request(_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description, _CustomParameters, _VatFormat, _AccountName), 
					:footer => get_footer(_AcquirerID, _AgreementID, _TransmissionTime, _PostbackURL, _Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description, _CustomParameters, _SharedSecret) 
					}
				)
			end		
			return response.body		
		end	
		
		def make_reversal(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
			_TransactionID, _OrderId, _Amount, _VatAmount, _ReconciliationTime, _Description,
			_CustomParameters, _VatFormat)
			
			client = get_savon_client					
			response = client.call(:Reversal) do
			  message(
				:arg0 => { 
					:header => get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout), 
					:request => get_reversal_request(_TransactionID, _OrderId, _Amount, _VatAmount, _ReconciliationTime, _Description, _CustomParameters, _VatFormat),					
					:footer => get_footer(_AcquirerID, _AgreementID, _TransmissionTime, _PostbackURL, _TransactionID, _Amount, _VatAmount, _ReconciliationTime, _SharedSecret) 
					}
				)
			end		
			return response.body		
		end	
		
		def make_purchase(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout, _SharedSecret,
			_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description,
			_CustomParameters, _VatFormat, _AccountName)
			
			client = get_savon_client					
			response = client.call(:Purchase) do
			  message(
				:arg0 => { 
					:header => get_header(_AcquirerID, _AgreementID, _TransmissionTime, _ClientIP, _PostbackURL, _PostbackTimeout), 
					:request => get_sales_request(_Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description, _CustomParameters, _VatFormat, _AccountName), 
					:footer => get_footer(_AcquirerID, _AgreementID, _TransmissionTime, _PostbackURL, _Amount, _VatAmount, _CurrencyISOString, _ClientIdType, _ClientId, _OrderId, _ReconciliationTime, _ProductId, _Description, _CustomParameters, _SharedSecret) 
					}
				)
			end		
			return response.body		
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
			endpoint $test_url2
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

end
