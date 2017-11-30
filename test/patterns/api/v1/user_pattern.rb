class Api::V1::UserPattern < Pattern
  def initialize(user = nil)
    if user
      @user = user
      @pattern = {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone: user.phone,
        address: user.address
      }
    end

    self
  end

  def list(users)
    @pattern = []

    users.each do |user|
      @pattern << {
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone: user.phone,
        address: user.address
      }
    end

    self
  end

end
