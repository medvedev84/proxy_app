class CreateWywalletReversals < ActiveRecord::Migration
  def change
    create_table :wywallet_reversals do |t|
      t.string :acquirer_id
      t.string :agreement_id
      t.string :transmission_time
      t.string :client_ip
      t.string :postback_url
      t.integer :postback_timeout	  
	  t.string :purchase_transaction_id, :limit => 60
	  t.string :order_id, :limit => 60	  
      t.integer :amount
      t.integer :vat_amount
      t.string :vat_format, :limit => 9
      t.string :reconciliation_time, :limit => 19
      t.string :description, :limit => 160
      t.text :custom_parameters
      t.text :generated_message 
      t.string :reversal_transaction_id, :limit => 60
      t.integer :batch_id
      t.integer :transaction_status
      t.string :transaction_status_desc, :limit => 200
      t.string :operation_status, :limit => 30
      t.string :operation_status_desc, :limit => 200
      t.timestamps
    end
  end
end
