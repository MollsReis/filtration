require 'spec_helper'

describe Filtration do

  describe '#prefilter' do

    context 'given a valid target method' do

      context 'and a code block for filtering' do
        it 'executes the block on the target method argument' do
          test = Class.new(Good) { prefilter(:foo){|x| x * 2} }
          test.new.foo(2).should === 6
        end
      end

      context 'and a valid filter method' do
        it 'executes the filter method on the target method argument' do
          test = Class.new(Good) do
            prefilter :foo, :double
            def double(x) x * 2; end
          end
          test.new.foo(2).should === 6
        end
      end

      context 'and an invalid filter method' do
        it 'raises an error' do
          test = Class.new(Good) do
            prefilter :foo, :double
            def double() 2; end
          end
          expect { test.new.foo(2) }.to raise_error
        end
      end

      context 'and both a filter method and a block' do
        it 'raises an error' do
          test = Class.new(Good) do
            extend RSpec::Matchers
            expect { prefilter(:foo,:double) {|x| x * 2} }.to raise_error
            def double(x) x * 2; end
          end
        end
      end

    end

    context 'given an invalid target method' do

      context 'and a code block for filtering' do
        it 'raises an error' do
          Class.new(Bad) do
            extend RSpec::Matchers
            expect { prefilter(:foo){|x| x * 2} }.to raise_error
          end
        end
      end

      context 'and a valid filter method' do
        it 'raises an error' do
          test = Class.new(Bad) do
            extend RSpec::Matchers
            expect { prefilter :foo, :double }.to raise_error
            def double(x) x * 2; end
          end
        end
      end

      context 'and an invalid filter method' do
        it 'raises an error' do
          test = Class.new(Bad) do
            extend RSpec::Matchers
            expect { prefilter :foo, :double }.to raise_error
            def double() 2; end
          end
        end
      end

      context 'and both a filter method and a block' do
        it 'raises an error' do
          test = Class.new(Bad) do
            extend RSpec::Matchers
            expect { prefilter(:foo,:double) {|x| x * 2} }.to raise_error
            def double(x) x * 2; end
          end
        end
      end

    end

  end

  describe '#postfilter' do

    context 'given a valid target method' do

      context 'and a code block for filtering' do
        it 'executes the block on the target method argument' do
          test = Class.new(Good) { postfilter(:foo){|x| x * 2} }
          test.new.foo(2).should === 8
        end
      end

      context 'and a valid filter method' do
        it 'executes the filter method on the target method argument' do
          test = Class.new(Good) do
            postfilter :foo, :double
            def double(x) x * 2; end
          end
          test.new.foo(2).should === 8
        end
      end

      context 'and an invalid filter method' do
        it 'raises an error' do
          test = Class.new(Good) do
            postfilter :foo, :double
            def double() 2; end
          end
          expect { test.new.foo(2) }.to raise_error
        end
      end

      context 'and both a filter method and a block' do
        it 'raises an error' do
          test = Class.new(Bad) do
            extend RSpec::Matchers
            expect { postfilter(:foo,:double) {|x| x * 2} }.to raise_error
            def double(x) x * 2; end
          end
        end
      end

    end

  end

end
