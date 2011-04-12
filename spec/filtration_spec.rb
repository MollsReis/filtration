require 'spec_helper'

describe Filtration do

  it 'executes a code block before the specified method' do
    class Foo
      def foo(x)
        x + 2
      end
    end
    class Test < Foo
      prefilter(:foo){|x| x * 2}
    end
    Test.new.foo(2).should === 6
  end

  it 'executes a code block after the specified method' do
    pending
    class Foo
      def foo(x)
        x + 2
      end
    end
    class Test < Foo
      postfilter(:foo){|x| x * 2}
    end
    Test.new.foo(2).should === 8
  end

  it 'raises an error if the method has no arguments' do
    pending
    class Foo
      def foo
        2
      end
    end
    class Test < Foo
      prefilter(:foo){|x| x * 2}
    end
    lambda { Test.new.foo }.should raise_error
  end

end