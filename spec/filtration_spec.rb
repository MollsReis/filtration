require 'spec_helper'

describe Filtration do

  it 'executes a code block before the specified method' do
    class Foo1
      def foo(x)
        x + 2
      end
    end
    class Test1 < Foo1
      prefilter(:foo){|x| x * 2}
    end
    Test1.new.foo(2).should === 6
  end

  it 'executes a code block after the specified method' do
    class Foo2
      def foo(x)
        x + 2
      end
    end
    class Test2 < Foo2
      postfilter(:foo){|x| x * 2}
    end
    Test2.new.foo(2).should === 8
  end

  it 'raises an error if the method has no arguments' do
    class Foo3
      def foo
        2
      end
    end
    class Test3 < Foo3
      extend RSpec::Matchers
      lambda { prefilter(:foo){|x| x * 2} }.should raise_error
    end
  end

end