module TDSA
  
  class << self
    
    def test!(&tests)
      @failures = []
      instance_eval(&tests)
      report_on_failures!
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
      # eventually do one request instead of two with -i
      raw_headers = curl("-I #{@domain}#{@path}").split("\n")
      @status = parse_status(raw_headers.shift)
      @headers = parse_headers(raw_headers)
      @body = curl("#{@domain}#{@path}")
    end
    
    def curl(args)
      result = `curl #{args} 2>/dev/null`.chomp
      print '.'
      STDOUT.flush
      result
    end
    
    def parse_status(raw_status)
      raw_status =~ /^HTTP\/1\.\d (\d+)/
      $1
    end
    
    def parse_headers(raw_headers)
      parsed_headers = {}
      raw_headers.each do |line|
        key, value = line.split(':')
        parsed_headers[key.strip] = value.strip
      end
      parsed_headers
    end
    
    def assert_header(expected_headers = {})
      for header, value in expected_headers
        check_equal! :assert_header, value, @headers[header]
      end
    end
    
    alias :assert_headers :assert_header
    
    def assert_status(expected_status)  
      check_equal!(:assert_status, expected_status.to_s, @status) # convert expected_status.to_s so we don't have to cast $1.to_s in parse_status()
    end
    
    def check_equal!(assertion, expected_value, actual_value)
      unless expected_value == actual_value
        @failures << "#{assertion} on #{@domain}#{@path} failed - expected #{expected_value.inspect} got #{actual_value.inspect}"
      end
    end
    
    def check_include!(assertion, expected_substring, string)
      unless string.include?(expected_substring)
        @failures << "#{assertion} on #{@domain}#{@path} failed - string did not include #{expected_substring.inspect}"
      end
    end
    
    def assert_server(expected_server)
      assert_header 'Server' => expected_server
    end
    
    def assert_body(expected_string_in_body)
      check_include!(:assert_body, expected_string_in_body, @body)
    end
    
    def report_on_failures!
      puts ''
      @failures.each { |failure| puts failure }
      if @failures.any?
        puts "Done (#{@failures.length} failure(s)!)."
      else
        puts "Done (no worries!)."
      end
    end
    
  end
  
end