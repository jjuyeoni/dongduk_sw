CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["aws_access_key_id"],                        # required unless using use_iam_profile
    aws_secret_access_key: ENV["aws_secret_access_key"],                        # required unless using use_iam_profile
    use_iam_profile:       true,                         # optional, defaults to false
    region:                'ap-northeast-2',                  # optional, defaults to 'us-east-1'
    host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'https://s3-ap-northeast-2.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'dongduk1'                                      # required
  config.fog_public     = true                                                 # optional, defaults to true
  config.fog_attributes = {} # optional, defaults to {}
  
   # 이미지를 가진 게시글 삭제 시 AWS S3서버에도 자동 삭제처리
  config.remove_previously_stored_files_after_update = true
end