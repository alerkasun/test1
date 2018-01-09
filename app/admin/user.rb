ActiveAdmin.register User do
  permit_params :email, :password, :first_name, :last_name, :avatar

  form do |f|
    f.inputs 'User Details', multipart: true do
      f.input :email
      f.input :password
      f.input :last_name
      f.input :first_name
      f.input :avatar, as: :file, hint:
        image_tag(f.object.avatar.url(:thumb_min) || 0)
    end
    f.actions
  end

  controller do
    def new
      @resource = User.new
      @resource.profile = Profile.new
    end

    def destroy
      if resource.destroy
        flash[:notice] = 'Successfully destroyed'
      else
        flash[:error] = 'You can\'t destroy this user'
      end

      render action: :index
    end

    def update
      @resource = User.find(params[:id])
      users_params = {}
      profile_params = {}
      users_params.merge!(email: params[:user][:email],
        password: params[:user][:password]
      )
      profile_params.merge!(
        first_name: params[:user][:first_name],
        last_name:  params[:user][:last_name],
        avatar: params[:user][:avatar] )
      ActiveRecord::Base.transaction do
        @resource.update_attributes(users_params)
        @resource.save!
      end
      ActiveRecord::Base.transaction do
        @resource.profile.update_attributes(profile_params)
        @resource.profile.save!
      end

      if @resource.errors.blank?
        flash[:notice] = "#{@resource.email} was updated successfully!"
        redirect_to action: :index
      else
        flash[:notice] = "#{@resource.email} wasn't updated!"
        render action: :edit
      end

    end

    def create
      @resource = User.create_with_profile!(permitted_params[:user])
      if @resource.errors.blank?
        flash[:notice] = "#{@resource} was created"
        redirect_to action: :index
      else
        render action: :new
      end
    end
  end
end






