module TDSA
  
  module Parser
    
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
    
  end
  
end