class Api::V1::UserPattern < Pattern
  def initialize(user = nil)
    if user
      @user = user
      @pattern = pattern_template(user)
    end

    self
  end

  def list(users)
    @pattern = []

    users.each do |user|
      @pattern << pattern_template(user)
    end

    self
  end

  def pattern_template(user)
    {
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      email: user.email,
      phone: user.phone,
      address: user.address,
      city: user.city,
      iva: user.iva,
      cuit: user.cuit
    }
  end

end
