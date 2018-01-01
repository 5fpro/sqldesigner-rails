class ChangePasswordContext < BaseContext
  def initialize(instance, params)
    @instance = instance
    @params = params
  end

  def perform
    return @instance.update_with_password(update_params) if update_params[:password].present?
    true
  end

  private

  def update_params
    @update_params ||= {
      current_password: @params.delete(:current_password),
      password: @params.delete(:password),
      password_confirmation: @params.delete(:password_confirmation)
    }
  end
end
