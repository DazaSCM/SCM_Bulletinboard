class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :posts, dependent: :destroy
  has_secure_password
  has_one_attached :profile
  acts_as_paranoid

  def image_url
    profile.attached? ? url_for(profile) : nil
  end
end
