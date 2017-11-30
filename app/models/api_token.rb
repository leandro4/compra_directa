class ApiToken < ApplicationRecord
	include HasToken
  include Expires

  before_create :set_expire_time

	belongs_to :user, polymorphic: true
end
