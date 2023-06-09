# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # prepend_before_actionはbefore_actionの前に実行される
  prepend_before_action :check_captcha, only: [:create]

  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_member, only: [:create]

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to root_path, notice:'guest_memberでログインしました'
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_member
    @member = Member.find_by(email: params[:member][:email].downcase)
    if @member
      if (@member.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == false))
        flash[:error] = "退会済みアカウントです。アカウント復旧の際は左記info_menuより運営までお問い合わせ下さい"
        redirect_to new_member_registration_path
      end
    else
      flash[:error] = "必須項目を入力して下さい。"
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private
  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_in_params
      resource.validate # Look for any other validation errors besides reCAPTCHA
      set_minimum_password_length
      respond_with_navigational(resource) { render :new }
    end
  end
end
