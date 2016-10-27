class Admin::UsersController < Admin::BaseController
  before_action :user
  before_action(except: [:index]) { add_crumb('Users', admin_users_path) }

  def index
    @admin_page_title = 'Users'
    add_crumb @admin_page_title, '#'
    @q = Admin::User.ransack(params[:q])
    @users = @q.result.order('id DESC').page(params[:page]).per(30)
    respond_with @users
  end

  def show
    @admin_page_title = "##{@user.id}"
    add_crumb @admin_page_title, '#'
  end

  def new
    @admin_page_title = 'New User'
    add_crumb @admin_page_title, '#'
  end

  def edit
    @admin_page_title = 'Edit User'
    add_crumb @admin_page_title, '#'
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
