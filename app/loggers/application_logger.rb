class ApplicationLogger < ::Logger

  class << self

    def default
      @default ||= new
    end

    private

    def file_path(path)
      @log_file_path = path
      @default = nil
    end

    def get_file_path
      @log_file_path
    end
  end

  def initialize(*args)
    args[0] ||= self.class.send(:get_file_path) || Rails.root.join('log', "#{Rails.env}.log")
    super(*args)
    after_init
  end

  def file_path
    @file_path ||= self.class.send(:get_file_path) || Rails.root.join('log', "#{Rails.env}.log")
  end

  private

  def after_init; end

end
