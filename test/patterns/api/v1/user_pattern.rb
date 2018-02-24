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
      business_name: user.business_name,
      description: user.description,
      email: user.email,
      phone: user.phone,
      address: user.address,
      city: user.city,
      iva: user.iva,
      cuit: user.cuit,
      type: user.type.downcase,
      avatar_url: user.avatar.url
    }
  end
end
