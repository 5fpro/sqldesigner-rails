class Admin::Category < ::Category

  class << self
    def ransackable_scopes(auth_object = nil)
      [  ]
    end
  end
end
