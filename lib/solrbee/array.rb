Array.class_eval do

  # Inspired by Rails's Array.wrap
  def self.wrap(obj)
    return [] if obj.nil?
    return obj.to_ary if obj.respond_to?(:to_ary)
    Array.new(1, obj)
  end

end
