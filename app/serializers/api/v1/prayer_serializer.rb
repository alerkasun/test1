class Api::V1::PrayerSerializer < ::BaseSerializer
  attributes :id, :text, :lists, :groups

  has_many :lists
  has_many :groups

  def lists
    object.lists
  end

  def groups
    object.groups
  end
end
