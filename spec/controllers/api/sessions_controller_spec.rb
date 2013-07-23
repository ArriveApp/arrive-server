describe Api::SessionsController do
  context 'POST create' do
    let!(:user) { User.create(email: 'user@user.com', password: '1234') }

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, format: 'json', user: params
    end

    context 'with unvalid login' do
      let(:params) { { email: 'unknown@user.com', password: '1234' } }
      its('response.body') { should == { success: false, message: 'Invalid email or password.' }.to_json }
    end

    context 'with invalid password' do
      let(:params) { { email: 'user@user.com', password: '4321' } }
      its('response.body') { should == { success: false, message: 'Invalid email or password.' }.to_json }
    end

    context 'with valid credentials' do
      let(:params) { { email: 'user@user.com', password: '1234' } }
      its('response.body') { should == { success: true, auth_token: user.reload.authentication_token, email: user.email }.to_json }
    end
  end
end
