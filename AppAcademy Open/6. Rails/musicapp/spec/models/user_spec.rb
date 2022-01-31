require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryBot.build(:user,
      email: 'example@example.com',
      password: 'good_password'
    )
  end
  
  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6).allow_nil }
  end
  
  describe '#is_password?' do
    it 'verifies a password is incorrect' do
      expect(subject.is_password?('bad_password')).to be false
    end

    it 'verifies a password is correct' do
      expect(subject.is_password?('good_password')).to be true
    end
  end
  
  describe '#reset_session_token!' do
    it 'sets a new session token' do
      original_token = subject.session_token
      subject.reset_session_token!
      new_token = subject.session_token
      expect(new_token).not_to eq original_token
    end
    
    it 'returns the new token' do
      returned_token = subject.reset_session_token!
      expect(returned_token).to eq subject.session_token
    end
  end
end
