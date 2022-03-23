class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :posts
  has_secure_password
  has_one_attached :profile
  acts_as_paranoid

  def image_url
    #Get the URL of the associated image
    profile.attached? ? url_for(profile) : nil
  end
end
