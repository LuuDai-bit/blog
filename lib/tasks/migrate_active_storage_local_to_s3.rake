# frozen_string_literal: true

namespace :migrate_active_storage_local_to_s3 do
  desc 'Migrate ActiveStorage local files to S3'

  task migrate: :environment do
    # create connect to bucket
    credentials = Aws::Credentials.new(Rails.application.credentials.dig(:aws, :s3, :access_key_id), Rails.application.credentials.dig(:aws, :s3, :secret_access_key))
    s3 = Aws::S3::Resource.new(region: ENV.fetch('S3_REGION'), credentials: credentials)
    bucket = s3.bucket(ENV.fetch('S3_BUCKET'))

    # Migrate from local disk to s3
    local_blobs = ActiveStorage::Blob.where(service_name: 'local')

    local_blobs.each do |blob|
      blob.open do |file|
        bucket.object(blob.key).put(body: file)
      end
    end

    local_blobs.update_all(service_name: 'amazon')
  end
end
