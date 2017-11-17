class Admin::UsersController < Admin::BaseController
  before_action :user
  add_breadcrumb('Users', :admin_users_path)
  before_action do
    add_breadcrumb(@user.name, admin_user_path(@user)) if @user.try(:id)
  end

  def index
    set_meta(title: 'Users')
    @q = Admin::User.ransack(params[:q])
    @users = @q.result.order('id DESC').page(params[:page]).per(30)
    respond_with @users
  end

  def show
    set_meta(title: "User ##{@user.id}")
  end

  def new
    set_meta(title: 'New User')
    add_breadcrumb 'New'
  end

  def edit
    set_meta(title: 'Edit User')
    add_breadcrumb 'Edit'
  end

  def create
    if user.save
      redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: 'user created' }
    else
      new
      flash.now[:error] = user.errors.full_messages
      render :new
    end
  end

  def update
    if user.update_attributes(user_params)
      redirect_to params[:redirect_to] || admin_user_path(user), flash: { success: 'user updated' }
    else
      edit
      flash.now[:error] = user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if user.destroy
      redirect_to params[:redirect_to] || admin_users_path, flash: { success: 'user deleted' }
    else
      redirect_to :back, flash: { error: user.errors.full_messages }
    end
  end

  private

  def user
    @user ||= params[:id] ? Admin::User.find(params[:id]) : Admin::User.new(user_params)
  end

  def user_params
    params.fetch(:user, {}).permit(:name, :email, :password, :admin, :avatar, :remove_avatar)
  end
end
