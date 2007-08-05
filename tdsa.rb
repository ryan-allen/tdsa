module TDSA
  
  class << self
    
    def test!(&tests)
      instance_eval(&tests)
      puts ' Done.'
    end
    
  private
  
    def with(domain, &paths)
      @domain = domain
      instance_eval(&paths)
      @domain = nil
    end
    
    def get(path, &asserts)
      @path = path
      run!
      instance_eval(&asserts)
      @path = nil
    end
    
    def run!
      raw_headers = curl "-i #{@domain}#{@path}"
      @status = parse_status(raw_headers)
      @headers = parse_headers(raw_headers)
      @body = curl "#{@domain}#{@path}"
    end
    
    def curl(args)
      result = `curl #{args} 2>/dev/null`.chomp
      print '.'
      STDOUT.flush
      result
    end
    
    def parse_status(raw_headers)
      200 # implement this
    end
    
    def parse_headers(raw_headers)
      {'Server' => 'lighttpd/1.4.16', 'X-Powered-By' => 'PHP/5.2.1'} # implement this
    end
    
    def assert_header(assertions = {})
      # implement this, use check!
    end
    
    alias :assert_headers :assert_header
    
    def assert_status(expected_status)
      check!(:assert_status, expected_status, @status)
    end
    
    def check!(assertion, expected_value, actual_value)
      unless expected_value == actual_value
        puts "#{assertion} on #{@domain}#{@path} failed - expected #{expected_value.inspect} got '#{actual_value.inspect}'"
      end
    end
    
    def assert_server(expected_server)
      assert_header 'Server' => expected_server
    end
    
    def assert_body(expected_string_in_body)
      # implement this
    end
    
    
  end
  
end