if ['development','production', 'staging', 'public'].include?(Rails.env)
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:region] = 'US Standard'
  # Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  # Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
  Paperclip::Attachment.default_options[:s3_host_name] = 's3.amazonaws.com'
  Paperclip::Attachment.default_options[:s3_credentials] = {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  }
end
