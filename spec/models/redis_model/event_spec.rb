# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisModel::Event, type: :model do
  describe 'class method' do
    describe 'create' do
      after do
        redis = Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
        redis.client.flushdb
      end

      context 'when add job to default job queue' do
        it 'should add job successfully' do
          RedisModel::Event.create(queue: 'default_jobs', params: {name: 'test'})
          redis = Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
          keys = redis.client.keys

          expect(keys).not_to be_empty
        end
      end

      context 'when add job to low job queue' do
        it 'should add job successfully' do
          RedisModel::Event.create(queue: 'low_priority_jobs', params: {name: 'test'})
          redis = Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
          keys = redis.client.keys

          expect(keys).not_to be_empty
        end
      end

      context 'when add job to critical job queue' do
        it 'should add job successfully' do
          RedisModel::Event.create(queue: 'critcal_jobs', params: {name: 'test'})
          redis = Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
          keys = redis.client.keys

          expect(keys).not_to be_empty
        end
      end

      context 'when add job to non exist queue' do
        it 'should not add job' do
          RedisModel::Event.create(queue: 'not_exist', params: {name: 'test'})
          redis = Blog::RedisClient.new(ENV.fetch('EVENT_REDIS_DB'))
          keys = redis.client.keys

          expect(keys).to be_empty
        end
      end
    end
  end
end
