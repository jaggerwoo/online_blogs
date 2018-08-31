class User < ApplicationRecord
  before_save :set_password

  def self.authenticate username, password
    user = find_by(username: username)
    if user and user.valid_password?(password)
      user
    else
      nil
    end
  end

  def valid_password? password
    self.crypted_password == Digest::SHA256.hexdigest(password + self.salt)
  end

  private

    def set_password
      self.salt = Time.now.to_i
      self.crypted_password = Digest::SHA256.hexdigest(self.password + self.salt)
    end
end
