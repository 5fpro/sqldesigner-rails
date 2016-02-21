class Admin::Category < ::Category

  class << self
    def ransackable_scopes(_auth_object = nil)
      [:delete_state, :tagged]
    end
  end
end
