class Admin::CategoriesController < Admin::BaseController
  before_action :category

  add_breadcrumb(breadcrumb_text, :admin_categories_path)

  before_action only: [:show, :edit, :revisions] do
    add_breadcrumb(@category.name, admin_category_path(@category))
  end

  def index
    @q = Admin::Category.ransack(params[:q])
    @categories = @q.result.sorted.page(params[:page]).per(30)
    respond_with @categories
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

  def revisions
    set_meta(title: locale_vars)
    add_breadcrumb t('.breadcrumb')
    @versions = @category.versions
  end

  def create
    if category.save
      redirect_to params[:redirect_to] || admin_category_path(category), flash: { success: t('.success') }
    else
      new
      flash.now[:error] = category.errors.full_messages
      render :new
    end
  end

  def update
    if category.update_attributes(category_params)
      redirect_to params[:redirect_to] || admin_category_path(category), flash: { success: t('.success') }
    else
      edit
      flash.now[:error] = category.errors.full_messages
      render :edit
    end
  end

  def destroy
    if category.destroy
      redirect_to params[:redirect_to] || admin_categories_path, flash: { success: t('.success') }
    else
      redirect_to :back, flash: { error: category.errors.full_messages }
    end
  end

  def restore
    flash_message = if category.restore
                      { success: t('.success', locale_vars) }
                    else
                      { error: t('.error', locale_vars.merge(message: category.errors.full_messages.to_sentence)) }
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

  def locale_vars
    {
      identity: @category ? "##{@category.id} #{@category.name}" : nil
    }
  end
end
