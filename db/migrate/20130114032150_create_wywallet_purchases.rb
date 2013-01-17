class CreateWywalletPurchases < ActiveRecord::Migration
  def change
    create_table :wywallet_purchases do |t|
      t.string :acquirer_id
      t.string :agreement_id
      t.string :transmission_time
      t.string :client_ip
      t.string :postback_url
      t.integer :postback_timeout
      t.integer :amount
      t.integer :vat_amount
      t.string :currency_iso
      t.string :client_id_type
      t.string :client_id
      t.string :order_id
      t.string :reconciliation_time
      t.string :product_id
      t.string :description
      t.text :custom_parameters
      t.string :vat_format
      t.string :generated_message 
      t.string :account_name
      t.string :transaction_id
      t.integer :batch_id
      t.integer :transaction_status
      t.string :transaction_status_desc
      t.string :operation_status
      t.string :operation_status_desc
      t.timestamps
    end
  end
end
