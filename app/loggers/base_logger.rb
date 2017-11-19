class BaseLogger < ::Logger

  class << self

    def default
      @default ||= self.new
    end

    private

    def file_path(path)
      @file_path = path
    end

    def get_file_path
      @file_path
    end
  end

  def initialize(*args)
    args[0] ||= self.class.send(:get_file_path) || Rails.root.join('log', "#{Rails.env}.log")
    super(*args)
    after_init
  end

  private

  def after_init
  end

end
