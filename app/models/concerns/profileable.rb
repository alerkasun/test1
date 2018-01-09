module Profileable
  extend ActiveSupport::Concern

  included do
    has_one :profile, as: :profileable, dependent: :destroy

    delegate :first_name, :last_name, :avatar,  to: :profile

    extend ClassMethods
  end

  module ClassMethods
    def create_with_profile!(attributes)
      entity_attributes = {
        email: attributes.delete(:email),
        password: attributes.delete(:password)
      }

      self.transaction do
        entity = self.create! entity_attributes
        entity.create_profile! attributes

        entity
      end
    end
  end
end
