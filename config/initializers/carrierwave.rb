CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJEF4Z5GWQV5MSP6Q',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }

  config.fog_directory  = 'sub-insta'
  config.asset_host = "https://s3.ap-northeast-1.amazonaws.com/sub-insta"
  config.cache_storage = :fog
end
