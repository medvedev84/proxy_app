class CreateWywalletCredits < ActiveRecord::Migration
  def change
    create_table :wywallet_credits do |t|
      t.string :acquirer_id
      t.string :agreement_id
      t.string :transmission_time
      t.string :client_ip
      t.string :postback_url
      t.integer :postback_timeout
      t.integer :amount
      t.integer :vat_amount
      t.string :currency_iso, :limit => 3
      t.string :client_id_type, :limit => 30
      t.string :client_id, :limit => 50
      t.string :order_id, :limit => 60
      t.string :reconciliation_time, :limit => 19
      t.string :product_id, :limit => 50
      t.string :description, :limit => 35
      t.text :custom_parameters
      t.string :vat_format, :limit => 9
      t.text :generated_message 
      t.string :account_name, :limit => 20
      t.string :transaction_id, :limit => 60
      t.integer :batch_id
      t.integer :transaction_status
      t.string :transaction_status_desc
      t.string :operation_status
      t.string :operation_status_desc
      t.timestamps
    end
  end
end
