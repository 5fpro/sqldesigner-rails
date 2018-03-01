class Admin::UsersController < Admin::BaseController
  before_action :user

  add_breadcrumb(breadcrumb_text, :admin_users_path)

  before_action only: [:show, :edit] do
    add_breadcrumb(@user.name, admin_user_path(@user))
  end

  def index
    @q = Admin::User.ransack(params[:q])
    @users = @q.result.order('id DESC').page(params[:page]).per(30)
    respond_with @users
  end

  def show
    set_meta(title: locale_vars)
  end

  def new
    self.action_name = 'new'
    set_meta
    add_breadcrumb t('.breadcrumb')
  end

  def edit
    self.action_name = 'edit'
    set_meta(title: locale_vars)
    add_breadcrumb t('.breadcrumb')
  end

  def create
    if user.save
      redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: t('.success') }
    else
      new
      flash.now[:error] = user.errors.full_messages
      render :new
    end
  end

  def update
    if user.update_attributes(user_params)
      redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: t('.success') }
    else
      edit
      flash.now[:error] = user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if user.destroy
      redirect_to params[:redirect_to] || admin_users_path, flash: { success: t('.success') }
    else
      redirect_to :back, flash: { error: user.errors.full_messages }
    end
  end

  private

  def user
    @user ||= params[:id] ? Admin::User.find(params[:id]) : Admin::User.new(user_params)
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :password, :avatar, :remove_avatar)
  end

  def locale_vars
    {
      identity: @user ? "##{@user.id} #{@user.name}" : nil
    }
  end
end
