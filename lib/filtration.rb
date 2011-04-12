module Filtration

  def prefilter(method,&block)
    old_method = instance_method(method)
    raise "Method #{method} takes 0 arguments" if old_method.arity == 0
    define_method(method) do |*args|
      old_method.bind(self).call(block.call(*args))
    end
  end

  def postfilter(method,&block)
    old_method = instance_method(method)
    raise "Method #{method} takes 0 arguments" if old_method.arity == 0
    define_method(method) do |*args|
      block.call(old_method.bind(self).call(*args))
    end
  end

end

class Object
  extend Filtration
end