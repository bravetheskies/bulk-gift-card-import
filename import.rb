require 'dotenv/load'
require 'shopify_api'
require 'optparse'
require 'csv'
require 'fileutils'

puts "Contecting to store: #{ENV['SHOPIFY_DOMAIN']}"

ShopifyAPI::Context.setup(
  # These values are required but not actually used for private apps
  api_key: "DUMMY_VALUE",
  host_name: "DUMMY_VALUE",
  scope: "DUMMY_VALUE",

  private_shop: ENV.fetch("SHOPIFY_DOMAIN"),
  api_secret_key: ENV.fetch("TOKEN"), # Note that this is actually the admin token, not the api secret key

  session_storage: ShopifyAPI::Auth::FileSessionStorage.new, # This is only to be used for testing, more information in session docs
  is_embedded: false, # Set to true if you are building an embedded app
  is_private: true, # Set to true if you are building a private app
  api_version: "2021-10" # The vesion of the API you would like to use
)

session = ShopifyAPI::Utils::SessionUtils.load_current_session

gift_card = ShopifyAPI::GiftCard.new(session: session)
gift_card.note = "This is a note"
gift_card.initial_value = 100.0
gift_card.code = "ABCD EFGH IJKL MNOP"
gift_card.save()
