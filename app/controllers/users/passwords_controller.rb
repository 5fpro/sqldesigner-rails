module Users
  class PasswordsController < Devise::PasswordsController

    def new
      set_meta(title: '忘記密碼')
      super
    end

    # POST /resource/password
    def create
      super do
        flash_if_has_error
      end
    end

    # GET /resource/password/edit?reset_password_token=abcdef
    def edit
      set_meta(title: '設定新密碼')
      super
    end

    # PUT /resource/password
    def update
      super do
        flash_if_has_error
      end
    end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
