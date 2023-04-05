SibApiV3Sdk.configure do |config|
  config.api_key['api-key'] = ENV.fetch('SENDINBLUE_API_KEY')
end