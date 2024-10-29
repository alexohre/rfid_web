class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :timeoutable, :trackable, :confirmable

  before_create :generate_username

  belongs_to :faculty, optional: true
  belongs_to :department, optional: true

  has_many :exam_registrations
  has_many :exams, through: :exam_registrations
  
  enum status: { pending: 0, verified: 1 }

  has_one_attached :avatar, dependent: :destroy

  validates :first_name, :last_name, :username, :address, :state, :country, :gender, presence: true, unless: :new_record?

  private
  
  def self.ransackable_attributes(auth_object = nil)
    %w[email first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    ["avatar_attachment", "avatar_blob"]
  end

  def generate_username
    # Split email at "@" and append 6 random characters
    prefix, domain = email.split('@')
    random_chars = SecureRandom.hex(3) # 6 random characters in hexadecimal form
    self.username = "#{prefix}_#{random_chars}"
  end
end
