class Admin::CategoriesController < Admin::BaseController
  before_action :category
  add_breadcrumb('Categories', :admin_categories_path)
  before_action do
    add_breadcrumb(@category.name, admin_category_path(@category)) if @category.try(:id)
  end

  def index
    @q = Admin::Category.ransack(params[:q])
    @categories = @q.result.sorted.page(params[:page]).per(30)
    set_meta(title: 'Categories')
    respond_with @categories
  end

  def show
    set_meta(title: "##{@category.id} #{@category.name}")
  end

  def new
    set_meta(title: 'New Category')
    add_breadcrumb 'New'
  end

  def edit
    set_meta(title: 'Edit Category')
    add_breadcrumb 'Edit'
  end

  def revisions
    set_meta(title: "##{@category.id} #{@category.name} - revisions")
    add_breadcrumb 'Revisions'
    @versions = @category.versions
  end

  def create
    if category.save
      redirect_to params[:redirect_to] || admin_category_path(category), flash: { success: 'category created' }
    else
      new
      flash.now[:error] = category.errors.full_messages
      render :new
    end
  end

  def update
    if category.update_attributes(category_params)
      redirect_to params[:redirect_to] || admin_category_path(category), flash: { success: 'category updated' }
    else
      edit
      flash.now[:error] = category.errors.full_messages
      render :edit
    end
  end

  def destroy
    if category.destroy
      redirect_to params[:redirect_to] || admin_categories_path, flash: { success: 'category deleted' }
    else
      redirect_to :back, flash: { error: category.errors.full_messages }
    end
  end

  def restore
    flash_message = if category.restore
                      { success: 'category restored' }
                    else
                      { error: 'already restored' }
                    end
    redirect_to request.referer || admin_categories_path, flash: flash_message
  end

  private

  def category
    @category ||= params[:id] ? Admin::Category.with_deleted.find(params[:id]) : Admin::Category.new(category_params)
  end

  def category_params
    params.fetch(:category, {}).permit([:name, { tag_list: [] }, :sort])
  end

end
