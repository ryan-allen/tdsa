module TDSA
  
  module Assertions
    
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
    
  end
  
end