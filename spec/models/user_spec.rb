require 'spec_helper'

describe User do
  fixtures :users

  subject { user }

  let(:user)  { users(:users_001) }

  describe '#followers' do
    let(:expected_follower_ids) do
      [:users_002, :users_003].map do |key|
        users(key).id
      end
    end

    its(:follower_ids) { should =~ expected_follower_ids }
  end

  describe '#followees' do
    let(:expected_followee_ids) do
      [:users_002, :users_003].map do |key|
        users(key).id
      end
    end

    its(:followee_ids) { should =~ expected_followee_ids }
  end
end
