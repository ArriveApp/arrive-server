module AuthHelper
  def stub_sign_in(user = nil)
    user ||= User.new
    request.env['warden'] = double(Warden,
                                   :authenticate => user,
                                   :authenticate! => user,
                                   :authenticate? => true)
    sign_in :user, user
  end

end