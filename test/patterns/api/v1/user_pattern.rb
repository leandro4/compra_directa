class Api::V1::UserPattern < Pattern
  def initialize(user)
    @user = user
    @pattern = {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      address: user.address,
      user_type: user.user_type
    }
    self
  end
end
