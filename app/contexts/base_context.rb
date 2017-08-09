class BaseContext
  extend ActiveModel::Callbacks
  define_model_callbacks :perform

  include Rails.application.routes.url_helpers
  include ErrorHandler

  private

  def permit_params(params, *cols)
    params = params.permit! if params.respond_to?(:permit!)
    ActionController::Parameters.new(params.to_h.with_indifferent_access).permit(cols)
  end
end
