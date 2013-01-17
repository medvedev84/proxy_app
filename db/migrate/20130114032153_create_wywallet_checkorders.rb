class CreateWywalletCheckorders < ActiveRecord::Migration
  def change
    create_table :wywallet_checkorders do |t|
      t.string :acquirer_id
      t.string :agreement_id
      t.string :transmission_time
      t.string :client_ip
      t.string :postback_url
      t.integer :postback_timeout
      t.string :client_id_type, :limit => 30
      t.string :client_id, :limit => 50
      t.string :order_id, :limit => 60
      t.text :custom_parameters
      t.text :generated_message  
      t.string :transaction_id, :limit => 60
	  t.integer :amount_authorized
	  t.integer :amount_captured
	  t.integer :amount_cancelled
	  t.integer :amount_reversed
	  t.integer :last_batch_id
      t.string :last_transaction_id, :limit => 60
	  t.integer :last_transaction_status
	  t.integer :last_transaction_type	  
      t.integer :transaction_status
      t.string :transaction_status_desc
      t.string :operation_status
      t.string :operation_status_desc	  
      t.timestamps
    end
  end
end
