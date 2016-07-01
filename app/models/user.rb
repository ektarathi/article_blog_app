class User < ActiveRecord::Base
  
  validates :first_name, :email, presence: true

  validates :email, uniqueness: true

  before_create { generate_token(:token) }

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end

end
