class Errors::Exception < ::RuntimeError
  attr_accessor :name, :info

  def initialize(name, info = {})
    @name = name
    @info = info
  end

  def message
    info.delete(:message) || Errors::Code.desc(@name)
  end

  def status
    Errors::Code.status(@name)
  end
end
