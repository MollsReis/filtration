require 'simplecov'
SimpleCov.start { add_filter '/spec/' }

$:.unshift(File.dirname(__FILE__) + '/../lib/')

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default,:test)

require 'filtration'
require 'spec_dummies'