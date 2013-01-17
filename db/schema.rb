# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130114032153) do

  create_table "wywallet_checkorders", :force => true do |t|
    t.string   "acquirer_id"
    t.string   "agreement_id"
    t.string   "transmission_time"
    t.string   "client_ip"
    t.string   "postback_url"
    t.integer  "postback_timeout"
    t.string   "client_id_type",          :limit => 30
    t.string   "client_id",               :limit => 50
    t.string   "order_id",                :limit => 60
    t.text     "custom_parameters"
    t.text     "generated_message"
    t.string   "transaction_id",          :limit => 60
    t.integer  "amount_authorized"
    t.integer  "amount_captured"
    t.integer  "amount_cancelled"
    t.integer  "amount_reversed"
    t.integer  "last_batch_id"
    t.string   "last_transaction_id",     :limit => 60
    t.integer  "last_transaction_status"
    t.integer  "last_transaction_type"
    t.integer  "transaction_status"
    t.string   "transaction_status_desc"
    t.string   "operation_status"
    t.string   "operation_status_desc"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "wywallet_credits", :force => true do |t|
    t.string   "acquirer_id"
    t.string   "agreement_id"
    t.string   "transmission_time"
    t.string   "client_ip"
    t.string   "postback_url"
    t.integer  "postback_timeout"
    t.integer  "amount"
    t.integer  "vat_amount"
    t.string   "currency_iso",            :limit => 3
    t.string   "client_id_type",          :limit => 30
    t.string   "client_id",               :limit => 50
    t.string   "order_id",                :limit => 60
    t.string   "reconciliation_time",     :limit => 19
    t.string   "product_id",              :limit => 50
    t.string   "description",             :limit => 35
    t.text     "custom_parameters"
    t.string   "vat_format",              :limit => 9
    t.text     "generated_message"
    t.string   "account_name",            :limit => 20
    t.string   "transaction_id",          :limit => 60
    t.integer  "batch_id"
    t.integer  "transaction_status"
    t.string   "transaction_status_desc"
    t.string   "operation_status"
    t.string   "operation_status_desc"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "wywallet_purchases", :force => true do |t|
    t.string   "acquirer_id"
    t.string   "agreement_id"
    t.string   "transmission_time"
    t.string   "client_ip"
    t.string   "postback_url"
    t.integer  "postback_timeout"
    t.integer  "amount"
    t.integer  "vat_amount"
    t.string   "currency_iso"
    t.string   "client_id_type"
    t.string   "client_id"
    t.string   "order_id"
    t.string   "reconciliation_time"
    t.string   "product_id"
    t.string   "description"
    t.string   "custom_parameters"
    t.string   "vat_format"
    t.string   "generated_message"
    t.string   "account_name"
    t.string   "transaction_id"
    t.integer  "batch_id"
    t.integer  "transaction_status"
    t.string   "transaction_status_desc"
    t.string   "operation_status"
    t.string   "operation_status_desc"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "wywallet_reversals", :force => true do |t|
    t.string   "acquirer_id"
    t.string   "agreement_id"
    t.string   "transmission_time"
    t.string   "client_ip"
    t.string   "postback_url"
    t.integer  "postback_timeout"
    t.string   "purchase_transaction_id", :limit => 60
    t.string   "order_id",                :limit => 60
    t.integer  "amount"
    t.integer  "vat_amount"
    t.string   "vat_format",              :limit => 9
    t.string   "reconciliation_time",     :limit => 19
    t.string   "description",             :limit => 160
    t.text     "custom_parameters"
    t.text     "generated_message"
    t.string   "reversal_transaction_id", :limit => 60
    t.integer  "batch_id"
    t.integer  "transaction_status"
    t.string   "transaction_status_desc", :limit => 200
    t.string   "operation_status",        :limit => 30
    t.string   "operation_status_desc",   :limit => 200
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

end
