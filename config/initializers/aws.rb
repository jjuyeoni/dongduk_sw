CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'    
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_Key"],                        # required
    aws_secret_access_key: ENV["AWS_Secret"],                        # required
    region:                '',                  # optional, defaults to 'us-east-1'
    endpoint:              '' # optional, defaults to nil
  }
  config.fog_directory  = 'sw-dongduk'                         # required
  config.fog_public     = true                                       # optional, defaults to true
  config.fog_attributes = {} # optional, defaults to {}
end