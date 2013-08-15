describe Api::SessionsController do
  describe 'POST create' do
    let(:user) { User.new(school: School.new) }

    before do
      User.stub(:find_for_database_authentication) { user }
      user.stub(:valid_password?) { true }
      user.stub(:reset_authentication_token!)
    end

    context 'with invalid user credentials' do
      it 'returns a 401 response' do
        User.stub(:find_for_database_authentication) { nil }

        post :create, format: :json, session: { email: 'unknown@user.com', password: '1234' }

        expect(response.status).to eq(401)
      end

    end

    context 'with no params' do
      it 'returns a 401 response' do
        User.stub(:find_for_database_authentication) { nil }

        post :create, format: :json, session: {}

        expect(response.status).to eq(401)
      end

    end

    context 'with valid credentials' do
      it 'returns a 201' do
        User.should_receive(:find_for_database_authentication).with(email: 'user@user.com') { user }
        user.should_receive(:valid_password?).with('1234') { true }
        user.should_receive(:reset_authentication_token!)

        post :create, format: :json, session: {email: 'user@user.com', password: '1234'}

        expect(response.status).to eq(201)
      end

      it 'returns user, school, and courses json' do
        user.firstname = 'Ned Stark'
        user.authentication_token = '1234abcd'
        user.is_teacher = false
        user.school = School.new(id: 1, name: 'My School', courses: [Course.new(id: 1, name: 'Math')])
        User.stub(:find_for_database_authentication) { user }

        post :create, format: :json, session: {email: 'user@user.com', password: '1234'}

        expect(response.body).to eq({
                                      user: {authentication_token: '1234abcd', firstname: 'Ned Stark', is_teacher: false},
                                      school: {id: 1, name: 'My School'},
                                      courses: [{id: 1, name: 'Math'}]
                                    }.to_json)
      end

    end

  end

end
