module Redactor2Concern
  def redactor2_authenticate_user!
    authenticate_user!
  end

  def redactor2_current_user
    current_user
  end
end
