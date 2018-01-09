ActiveAdmin.register Prayer do
  permit_params :text, :description, :is_free, :is_published, :user_id

  index do
    selectable_column
    id_column
    column :text
    column :description

    column :is_free do |prayer|
      status = prayer.is_free? ? 'YES' : 'NO'
      content_tag(:span, status,
        class: "boolean status_tag #{status.downcase}")
    end

    column :is_published do |prayer|
      status = prayer.is_published? ? 'YES' : 'NO'
      content_tag(:span, status,
        class: "boolean status_tag #{status.downcase}")
    end

    column :user_id
    actions
  end

  filter :text
  filter :description

  form do |f|
    f.inputs 'Prayer Details' do
      f.input :text
      f.input :description
      f.input :is_free
      f.input :is_published
      f.input :user_id

    end
    f.actions
  end

  controller do
    def destroy
      resource.destroy!

      render action: :index
    end
  end
end
