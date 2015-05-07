if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
    config.fog_credentials = {
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AWS_ACCESS_KEY'],
      :aws_secret_access_key => ENV['AWS_SECRET_KEY'],
      :region                => ENV['AWS_REGION'],
    }

    config.fog_directory = ENV['S3_BUCKET_NAME']
    config.fog_public = true
  end
  
else
  CarrierWave.configure do |config|
    config.storage = :file
  end
end
