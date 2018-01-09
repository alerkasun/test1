class Profile < ApplicationRecord

  validates :profileable, presence: true

  belongs_to :profileable, polymorphic: true

  mount_uploader :avatar, AvatarUploader

  def edit!(params)
    update! params
    delete_avatar! if params.key?(:avatar) && params[:avatar].nil?
  end

  private

  def delete_avatar!
    remove_avatar!
    update!(avatar: nil)
  end
end
