class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  process scale: [1200, 900]

  # Create different versions of your uploaded files:
  version :thumb_min do
    process resize_to_fit: [100, 300]
  end

  version :thumb_large do
    process resize_to_fit: [400, 600]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def filename
    return unless original_filename
    if model && model.read_attribute(mounted_as).present?
      model.read_attribute(mounted_as)
    else
      "#{secure_token}.#{file.extension}"
    end
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(
      var,
      SecureRandom.uuid
    )
  end

  private

  def scale(width, height)
    manipulate! do |img|
      img.combine_options do |c|
        c.resize "#{width}x#{height}"
      end
      img
    end
  end
end
