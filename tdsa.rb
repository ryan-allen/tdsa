%w(api assertions curl parser).each { |file| require "#{File.dirname(__FILE__)}/lib/#{file}" }

module TDSA  
  class << self
    %w(API Assertions CURL Parser).each { |mixin| include eval(mixin) }
  end
end
