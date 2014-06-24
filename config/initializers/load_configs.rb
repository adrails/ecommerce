require 'yaml'

YAML::ENGINE.yamler= 'syck'

payment_gateway = YAML.load_file("config/payment_gateway.yml")
Login_id = payment_gateway[Rails.env]["login_id"]
Transaction_key = payment_gateway[Rails.env]["transaction_key"]
Password = payment_gateway[Rails.env]["password"]
Payment_mode = payment_gateway[Rails.env]["mode"]
