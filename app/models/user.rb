class User < ApplicationRecord
	VALID_EMAIL_REGEX = ^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$
	validates :name, presence:true, length: {maximum:5}
	validates :email,	format: {with: /VALID_EMAIL_REGEX/ }
end
