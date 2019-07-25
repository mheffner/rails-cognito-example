class User < ApplicationRecord
  has_many :cognito_sessions
end
