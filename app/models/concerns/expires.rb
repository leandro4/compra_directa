module Expires
  extend ActiveSupport::Concern

  included do
    before_create :set_expire_time
  end

  def expired?
    expire_at <= DateTime.current
  end

  protected

  def set_expire_time
    self.expire_at = 30.minutes.from_now
  end
end