class Admin::Category < ::Category

  class << self
    def ransackable_scopes(auth_object = nil)
      [ :delete_state ]
    end
  end
end
