require 'rails_helper'

describe Api::NonprofitsController, type: :request do

  let(:user) { create(:user)}
  let(:nonprofit_admin_role) do
     role = user.roles.build(host: nonprofit, name: 'nonprofit_admin')
     role.save!
     role
  end
  let(:nonprofit) {create(:nm_justice)}

  describe 'get' do
  end

  describe 'create' do
    around(:each) do |example|
      @old_bp = Settings.default_bp
      example.run
      Settings.default_bp = @old_bp
    end

    it 'validates and returns correct errors' do
      input = {}
      post '/api/nonprofits', params: input, xhr: true
      expect(response).to have_http_status :unprocessable_entity
      expect(response.parsed_body['errors'].keys).to match_array ['name', 'city', 'state_code', 'slug', 'user_id']
    end

    it 'succeeds' do
      input =  { name: 'n', state_code: 'WI', city: 'appleton', zip_code: 54_915, user_id: user.id, phone: '920-555-5555' }
      sign_in user
      bp = force_create(:billing_plan)
      Settings.default_bp.id = bp.id

      sign_in user

      post '/api/nonprofits', params: input, xhr: true
      expect(response).to have_http_status :created

      expected_np = {
        name: 'n',
        state_code: 'WI',
        city: 'appleton',
        zip_code: '54915',
        state_code_slug: 'wi',
        city_slug: 'appleton',
        slug: 'n',
        phone: '920-555-5555',
        email: nil,
        website: nil,
        urls: {plain_url: "http://www.example.com/nonprofits/1", slug_url: "http://www.example.com/wi/appleton/n"}
      }.with_indifferent_access
      
      expect(response.parsed_body['id']).to be > 0
      expect(response.parsed_body.except('id')).to eq expected_np
    end
  end
end


