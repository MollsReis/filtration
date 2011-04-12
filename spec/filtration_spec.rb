require 'spec_helper'

class Good
  def foo(x)
    x + 2
  end
end

class Bad
  def foo
    2
  end
end

describe Filtration do

  it 'executes a code block before the specified method' do
    class Test1 < Good 
      prefilter(:foo){|x| x * 2}
    end
    Test1.new.foo(2).should === 6
  end

  it 'executes a code block after the specified method' do
    class Test2 < Good
      postfilter(:foo){|x| x * 2}
    end
    Test2.new.foo(2).should === 8
  end

  it 'executes a code block before the specified method' do
    class Test3 < Good 
      def bar(x)
        x * 2
      end
      prefilter :foo, :bar
    end
    Test1.new.foo(2).should === 6
  end

  it 'executes a code block after the specified method' do
    class Test4 < Good
      def bar(x)
        x * 2
      end
      postfilter :foo, :bar
    end
    Test2.new.foo(2).should === 8
  end

  it 'raises an error if the method has no arguments' do
    class Test5 < Bad
      extend RSpec::Matchers
      lambda { prefilter(:foo){|x| x * 2} }.should raise_error
    end
  end

  it 'raises an error if the filter method has no arguments' do
    class Test6 < Good
      extend RSpec::Matchers
      def bar
        nil
      end
      lambda { prefilter :foo, :bar }.should raise_error
    end
  end

  it 'raises an error if both filter and block are specified' do
    class Test7 < Good
      extend RSpec::Matchers
      def bar(x)
        x * 2
      end
      lambda { prefilter(:foo,:bar){|x| x * 2} }.should raise_error
    end
  end

  it 'raises an error if neither filter nor block are specified' do
    class Test8 < Good
      extend RSpec::Matchers
      def bar(x)
        x * 2
      end
      lambda { prefilter(:foo) }.should raise_error
    end
  end

end