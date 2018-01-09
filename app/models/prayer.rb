class Prayer < ApplicationRecord
  has_many :lists
  has_many :groups
  validates :text, presence: true
  self.table_name = "prayers"
end
