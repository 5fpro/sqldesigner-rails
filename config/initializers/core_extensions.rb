class Hash
  def to_utf8
    Hash[
      collect do |k, v|
        if (v.respond_to?(:to_utf8))
          [ k, v.to_utf8 ]
        elsif (v.respond_to?(:force_encoding))
          [ k, v.dup.force_encoding('UTF-8') ]
        else
          [ k, v ]
        end
      end
    ]
  end
end

class Array
  def to_utf8
    map do |v|
      if (v.respond_to?(:to_utf8))
        v.to_utf8
      elsif (v.respond_to?(:force_encoding))
        v.dup.force_encoding('UTF-8')
      else
        v
      end
    end
  end
end
