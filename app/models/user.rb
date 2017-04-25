class User < ApplicationRecord
  has_many :accounts, dependent: :destroy

  validates :username, presence: true
  validates :registration_code, uniqueness: true, presence: true

  after_initialize :generate_registration_code

  private

  def generate_registration_code
    self.registration_code ||= SecureRandom.uuid
  end
end
