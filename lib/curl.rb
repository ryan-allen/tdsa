module TDSA
  
  module CURL
    
    def curl(args)
      result = `curl #{args} 2>/dev/null`.chomp
      print '.'
      STDOUT.flush
      result
    end
    
  end
  
end