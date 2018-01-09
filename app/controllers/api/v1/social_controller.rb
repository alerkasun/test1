class Api::V1::SocialController < Api::V1::BaseController
  def sing_in
    form = SocialAuthenticationForm.new(authentication_params)
    return api_error(:bad_request, form.errors) unless form.valid?
    SocialUserAuthentication.perform(params[:provider], params[:oauth_token], params[:oauth_secret], self)
  end

  def create_authentication_on_success(session)
    render json: session, serializer: Api::V1::AuthenticationSerializer
  end

  private

  def authentication_params
    params.permit(:provider, :oauth_token, :oauth_secret)
  end
end
