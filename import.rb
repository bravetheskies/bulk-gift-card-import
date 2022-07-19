require 'dotenv/load'
require 'shopify_api'
require 'optparse'
require 'csv'
require 'fileutils'

@options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby import.rb [options]"

  opts.on("-v", "--verbose", "Show extra information") do
    @options[:verbose] = true
  end
  opts.on("-f=FILE", "--file=FILE", "Input file") do |file|
    @options[:input_file] = file
  end
end.parse!

if @options[:input_file]
  input = @options[:input_file]
else
  abort "Please select an input file."
end

puts "Contecting to store: #{ENV['SHOPIFY_DOMAIN']}"

begin
  ShopifyAPI::Context.setup(
    # These values are required but not actually used for private apps
    api_key: "DUMMY_VALUE",
    host_name: "DUMMY_VALUE",
    scope: "DUMMY_VALUE",

    private_shop: ENV.fetch("SHOPIFY_DOMAIN"),
    api_secret_key: ENV.fetch("TOKEN"),

    session_storage: ShopifyAPI::Auth::FileSessionStorage.new,
    is_embedded: false,
    is_private: true,
    api_version: "2022-07"
  )

  session = ShopifyAPI::Utils::SessionUtils.load_current_session
rescue => error
  puts "Unable to connect to Shopify API: #{error.message}"
end

if session and input
  csv_in = CSV.parse(File.read(input), :headers => true)

  csv_in.each do |row|
    begin
      gift_card = ShopifyAPI::GiftCard.new(session: session)
      gift_card.note = row["Note"]
      gift_card.initial_value = row["Balance"]
      gift_card.code = row["Code"]
      gift_card.expires_on = row["Expires"]
      gift_card.save()
    rescue => error
      puts "Error with gift card `#{row["Code"]}`: #{error.message}"
    end
  end
end
