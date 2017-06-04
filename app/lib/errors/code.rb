class Errors::Code
  STATUS = {
    error_code_not_defined: 400,
    params_required: 400,
    data_not_found: 404,
    data_create_fail: 400,
    data_update_fail: 400,
    data_delete_fail: 400
  }.freeze

  class << self
    def exists?(name)
      status(name).present?
    end

    def status(name)
      STATUS[name.to_sym]
    end

    def desc(name)
      I18n.t("errors.#{name}")
    end
  end

end
