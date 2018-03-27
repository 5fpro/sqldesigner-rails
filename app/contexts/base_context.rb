class BaseContext
  extend  ActiveModel::Callbacks
  include ActiveModel::AttributeAssignment
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  include ObjectErrorsConcern
  include Rails.application.routes.url_helpers

  define_model_callbacks :perform

  private

  def permit_params(params, *cols)
    params = params.permit! if params.respond_to?(:permit!)
    ActionController::Parameters.new(params.to_h.with_indifferent_access).permit(cols)
  end
end
