require 'tdsa'

TDSA.test! do
  
  with 'flashden.net' do
    
    get '/' do
      assert_status 200
      assert_server 'Mongrel 1.0.1'
      assert_body 'FlashDen - Download Stock Flash, Audio, Video and Pixel Fonts'
    end
    
    get '/user/ryan' do
      assert_status 200
      assert_server 'Mongrel 1.0.1'
      assert_body 'FlashDen - ryan'      
    end
    
    get '/new/stylesheets/forms.css' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
    end
    
    get '/new/javascript/swfobject.js' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
    end
    
    get '/files/7531.png' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
    end
    
    get '/assets/foxmail/Newsletter3.html' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'Welcome to our third edition of FoxMail'
    end
    
    get '/videomaru' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'Change the way you use Video in Flash'
    end
    
    get '/showroom' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'Stock Flash, Audio, Video and Font files in Action'
    end
    
  end
  
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
      assert_body 'Working without a boss, freelance workers need to find ways to'
    end
    
    get '/unite/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'The First Annual Global Freelancer Survey for 2007'
    end
    
    get '/rates/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'We have developed this hourly rate calculator to give you a guide'
    end
    
  end
  
  # don't forget a assert_redirected_to for freelanceswitch.com/jobs !!
  
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
    
    get '/forums/' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'The Zen Habits Forums'
    end    
    
    get '/feed/rss2' do
      assert_status 200
      assert_server 'lighttpd/1.4.16'
      assert_body 'Simple Productivity'
    end
    
  end
  
  with 'feeds.feedburner.com' do
    
    get '/zenhabits' do
      assert_status 200
      assert_server 'Apache'
      assert_body 'Simple Productivity'
    end
    
  end
  
end