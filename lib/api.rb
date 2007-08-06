module TDSA
  
  module API
    
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