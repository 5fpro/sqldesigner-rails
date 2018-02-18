module Admin
  class AccountsController < BaseController

    add_breadcrumb breadcrumb_text, :admin_account_path

    def show; end

    def update
      context = ChangePasswordContext.new(current_administrator, administrator_params)
      if context.perform && current_administrator.update(administrator_params)
        redirect_to admin_account_path, flash: { success: t('.success') }
      else
        flash.now[:error] = current_administrator.errors.full_messages.to_sentence
        render :show
      end
    end

    private

    def administrator_params
      @administrator_params ||= params.require(:administrator).permit(
        :name, :current_password, :password, :password_confirmation
      )
    end
  end
end
