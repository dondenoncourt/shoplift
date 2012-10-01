require 'spec_helper'

describe ParserController do
  fixtures :users

  let(:user) { users(:users_001) }

  before do
     @request.env['HTTP_REFERER'] = url
  end

  describe 'empty url' do
    let(:url) { }

    it do
      expect {
        get :bookmarklet
      }.to raise_exception(ParserController::NoReferrer)
    end
  end

  describe 'invalid url' do
    let(:url) { 'bro' }

    it do
      expect {
        get :bookmarklet
      }.to raise_exception(ParserController::InvalidReferrer)
    end

  end

  describe 'valid url' do
    let(:url) { 'http://www.etsy.com/listing/107263351/halloween-banner-decoration-beware-black?ref=fp_treasury_1' }

    it do
      get :bookmarklet
      response.should be_ok
    end
  end
end
