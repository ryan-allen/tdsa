require 'tdsa'

TDSA.test! do
  
  with 'freelanceswitch.com' do
    
    get '/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'The Freelance Blog - Freelance Switch'
    end
    
    get '/productivity/gtd-for-freelancers/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_header 'X-Powered-By' => 'PHP/5.2.1'
      assert_body 'Working without a boss, freelance workers need to find ways to motivate themselves'
    end
    
  end
  
  with 'jobs.freelanceswitch.com' do
    
    get '/' do 
      assert_status 200
      assert_server 'Mongrel 1.0.1'
      assert_body 'Freelance Jobs - FreelanceSwitch'
    end
    
    get '/jobs/208' do
      assert_status 200
      assert_server 'Mongrel 1.0.1'
      assert_body 'Have you branded an optometrist in Aus?'
    end
    
  end
  
  with 'zenhabits.net' do
    
    get '/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'zen habits | Simple Productivity'
    end
    
    get '/feed/rss2' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'Simple Productivity'
    end
    
  end
  
  # problem here - feedburner returns different page in safari to curl...
  #
  # with 'feeds.feedburner.com' do
  #   
  #   get '/zenhabits' do
  #     assert_status 200
  #     assert_server 'Apache'
  #     assert_body 'Current Feed Content'
  #   end
  #   
  # end
  
end