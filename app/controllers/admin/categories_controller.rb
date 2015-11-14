class Admin::CategoriesController < Admin::BaseController
  before_filter :category
  before_filter{ add_crumb("Categories", admin_categories_path) }

  def index
    @admin_page_title = "Categories"
    @q = Admin::Category.ransack(params[:q])
    @categories = @q.result.order("id DESC").page(params[:page]).per(30)
    respond_with @categories
  end

  def show
    @admin_page_title = "##{@category.id} #{@category.name}"
    add_crumb @admin_page_title, "#"
  end

  def new
    @admin_page_title = "New Category"
    add_crumb @admin_page_title, "#"
  end

  def edit
    @admin_page_title = "Edit Category"
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

  def restore
    if category.restore
      flash_message = { success: "category restored" }
    else
      flash_message = { error: "already restored" }
    end
    redirect_to request.referer || admin_categories_path, flash: flash_message
  end

  private

  def category
    @category ||= params[:id] ? Admin::Category.with_deleted.find(params[:id]) : Admin::Category.new(category_params)
  end

  def category_params
    params.fetch(:category, {}).permit(:name, :tag_list)
  end

end
