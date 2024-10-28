class Lecturer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # before_create :generate_username

  has_one_attached :avatar, dependent: :destroy

  has_many :lecturer_courses, dependent: :destroy
  has_many :courses, through: :lecturer_courses

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "encrypted_password", "first_name", "id", "last_name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "user_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob"]
  end

  private

  # def generate_username
  #   # Split email at "@" and append 6 random characters
  #   prefix, domain = email.split('@')
  #   random_chars = SecureRandom.hex(3) # 6 random characters in hexadecimal form
  #   self.username = "#{prefix}_#{random_chars}"
  # end

end
