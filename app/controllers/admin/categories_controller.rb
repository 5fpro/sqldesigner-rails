class Admin::CategoriesController < Admin::BaseController
  before_filter :category
  before_filter(except: [:index]){ add_crumb("Users", admin_categories_path) }

  def index
    @admin_page_title = "Users"
    add_crumb @admin_page_title, "#"
    @q = Admin::Category.ransack(params[:q])
    @categories = @q.result.order("id DESC").page(params[:page]).per(30)
    respond_with @categories
  end

  def show
    @admin_page_title = "##{category.id}"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "New User"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "Edit User"
    add_crumb @admin_page_title, "#"
  end

  def revisions
    @admin_page_title = "##{@category.id} #{@category.name} - revisions"
    add_crumb @category.name, admin_category_path(@category)
    add_crumb "revisions", "#"
    @versions = @category.versions
  end

  def create
    if category.save
      redirect_to admin_category_path(category), flash: { success: "category created" }
    else
      new()
      flash.now[:error] = category.errors.full_messages
      render :new
    end
  end

  def update
    if category.update_attributes(category_params)
      redirect_to admin_category_path(category), flash: { success: "category updated" }
    else
      edit()
      flash.now[:error] = category.errors.full_messages
      render :edit
    end
  end

  def destroy
    if category.destroy
      redirect_to admin_categories_path, flash: { success: "category deleted" }
    else
      redirect_to :back, flash: { error: category.errors.full_messages }
    end
  end

  private

  def category
    @category ||= params[:id] ? Admin::Category.find(params[:id]) : Admin::Category.new(category_params)
  end

  def category_params
    params.fetch(:category, {}).permit(:name, :email, :password, :admin, :avatar, :remove_avatar)
  end

end
