class CssClass
  def initialize(class_name)
    @list = process(class_name)
  end

  def add(*args)
    args.each do |class_name|
      @list += process(class_name)
    end
    @list.uniq!
    self
  end

  def remove(*args)
    args.each do |class_name|
      @list -= process(class_name)
    end
    self
  end

  def to_s
    @list.join(' ')
  end

  def to_a
    @list
  end

  private

  def process(class_name)
    class_name = class_name.to_s.split(' ') unless class_name.is_a?(Array)
    class_name.map { |s| s.to_s.delete(' ') }.select(&:present?).uniq
  end
end
