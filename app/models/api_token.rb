class ApiToken < ApplicationRecord
	include HasToken

	belongs_to :user, polymorphic: true
end
