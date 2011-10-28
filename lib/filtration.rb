module Filtration

  # for method with arity > 0, 'target', intercept arguments and apply
  # method 'filter' or passed 'block' to them before running 'target' with them
  def prefilter(target, filter=nil, &block)
    old_method = instance_method(target)
    raise "Method #{target} takes 0 arguments" if old_method.arity == 0
    raise "Must use either passed filter method or passed block" unless filter.nil? ^ block.nil?

    define_method(target) do |*args|
      if filter.nil?
        old_method.bind(self).call(block.call(*args))
      else
        filter_method = method(filter)
        raise "Filter method #{filter} takes 0 arguments" if filter_method.arity == 0
        old_method.bind(self).call(self.send(filter,*args))
      end
    end
  end

  # for method, 'target', intercept output and apply method 'filter' or
  # passed 'block' to it before returning the value
  def postfilter(target, filter=nil, &block)
    old_method = instance_method(target)
    raise "Must use either passed filter method or passed block" unless filter.nil? ^ block.nil?

    define_method(target) do |*args|
      if filter.nil?
        block.call(old_method.bind(self).call(*args))
      else
        filter_method = method(filter)
        self.send(filter,old_method.bind(self).call(*args))
      end
    end
  end

end

class Object
  extend Filtration
end
