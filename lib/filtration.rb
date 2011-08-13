module Filtration

  # for method with arity > 0, 'method', intercept arguments and apply
  # method 'filter' or passed 'block' to them before running 'method' with them
  def prefilter(method, filter=nil, &block)
    old_method = instance_method(method)
    raise "Method #{method} takes 0 arguments" if old_method.arity == 0
    raise "Must use either passed filter method or passed block" unless filter.nil? ^ block.nil?

    define_method(method) do |*args|
      if filter.nil?
        old_method.bind(self).call(block.call(*args))
      else
        filter_method = method(filter)
        raise "Filter method #{filter} takes 0 arguments" if filter_method.arity == 0
        old_method.bind(self).call(self.send(filter,*args))
      end
    end
  end

  # for method, 'method', intercept output and apply method 'filter' or 
  # passed 'block' to it before returning the value
  def postfilter(method, filter=nil, &block)
    old_method = instance_method(method)
    raise "Must use either passed filter method or passed block" unless filter.nil? ^ block.nil?

    define_method(method) do |*args|
      if filter.nil?
        block.call(old_method.bind(self).call(*args))
      else
        filter_method = method(filter)
        raise "Filter method #{filter} takes 0 arguments" if filter_method.arity == 0
        self.send(filter,old_method.bind(self).call(*args))
      end
    end
  end

end

class Object
  extend Filtration
end
