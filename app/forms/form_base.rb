class FormBase
  include ActiveModel::Model
  include ActiveModel::Validations
  include Virtus.model

  def validate!
    raise ActiveRecord::RecordInvalid.new(self) unless valid?
  end
end
