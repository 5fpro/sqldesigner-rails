module ActsAsVersioning

  extend ActiveSupport::Concern

  module ClassMethods

    def acts_as_versioning(options = {})
      has_paper_trail(options)
      # scope :with_creator, -> { includes(:creator) }
      # belongs_to :creator, class_name: 'User', foreign_key: :user_id
      # after_create :update_creator
    end

  end

  def last_edited?
    originator && true
  end

  def last_editor
    @last_editor ||= User.find originator if last_edited?
    @last_editor
  end

  def full_history
    users = {}
    full_history = versions.map do |v|
      editor = v.whodunnit ? users[v.whodunnit] || (users[v.whodunnit] = User.find(v.whodunnit)) : User.new
      { reify: v.reify,
        index: v.index,
        version: v,
        editor: editor,
        updated_at: v.created_at }
    end
    full_history.reverse!
  end

  # private

  # def update_creator
  #   update_attribute(:user_id, originator) if respond_to?(:created_user_id) && last_edited?
  # end
end
