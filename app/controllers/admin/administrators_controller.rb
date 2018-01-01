module Admin
  class AdministratorsController < BaseController
    before_action :authenticate_root_administrator!

    before_action :administrator
    add_breadcrumb('Administrators', :admin_administrators_path)
    before_action do
      add_breadcrumb(@administrator.name, admin_administrator_path(@administrator)) if @administrator.try(:id)
    end

    def index
      set_meta(title: 'Administrators')
      @q = Admin::Administrator.ransack(params[:q])
      @administrators = @q.result.order('id DESC').page(params[:page]).per(30)
      respond_with @administrators
    end

    def show
      set_meta(title: "Administrator ##{@administrator.id}")
    end

    def new
      set_meta(title: 'New Administrator')
      add_breadcrumb 'New'
    end

    def edit
      set_meta(title: 'Edit Administrator')
      add_breadcrumb 'Edit'
    end

    def create
      if administrator.save
        redirect_to params[:redirect_to] || admin_administrator_path(administrator), flash: { success: 'administrator created' }
      else
        new
        flash.now[:error] = administrator.errors.full_messages
        render :new
      end
    end

    def update
      delete_password_params_if_blank
      if administrator.update_attributes(administrator_params)
        redirect_to params[:redirect_to] || admin_administrator_path(administrator), flash: { success: 'administrator updated' }
      else
        edit
        flash.now[:error] = administrator.errors.full_messages
        render :edit
      end
    end

    def destroy
      if administrator.destroy
        redirect_to params[:redirect_to] || admin_administrators_path, flash: { success: 'administrator deleted' }
      else
        redirect_to :back, flash: { error: administrator.errors.full_messages }
      end
    end

    private

    def administrator
      @administrator ||= params[:id] ? Admin::Administrator.find(params[:id]) : Admin::Administrator.new(administrator_params)
    end

    def delete_password_params_if_blank
      if administrator_params[:password].blank?
        @administrator_params.delete(:password)
        @administrator_params.delete(:password_confirmation)
      end
    end

    def administrator_params
      @administrator_params ||= params.fetch(:administrator, {}).permit(
        :name, :email, :root, :password, :password_confirmation
      )
    end
  end
end
