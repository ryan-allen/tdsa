module TDSA
  
  module API
    
    def test!(&tests)
      @failures = []
      instance_eval(&tests)
      report_on_failures!
    end

  private

    def with(*domains, &paths)
      @domains = domains
      instance_eval(&paths)
      @domains = nil
    end

    def get(path, &asserts)
      @path = path
      @domains.each do |domain|
        @domain = domain
        run!(domain)
        instance_eval(&asserts)
        @domain = nil
      end
      @path = nil
    end

    def run!(domain)
      # eventually do one request instead of two with -i
      raw_headers = curl("-I #{domain}#{@path}").split("\n")
      @status = parse_status(raw_headers.shift)
      @headers = parse_headers(raw_headers)
      @body = curl("#{domain}#{@path}")
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
