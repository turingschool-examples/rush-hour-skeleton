sample_user = User.create({"identifier" => "jumpstartlab",
        "rootUrl" => "http://jumpstartlab.com"})

  payload1 = User.find(1).payloads.create({
           "requestedAt"      => "2013-02-16 21:38:28 -0700",
           "respondedIn"      => 37,
           "referredBy"       => "http://jumpstartlab.com",
           "requestType"      => "GET",
           "parameters"       => [],
           "eventName"        => "socialLogin",
           "userAgent"        => "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
           "resolutionWidth"  => "1920",
           "resolutionHeight" => "1280",
           "ip"               => "63.29.38.211"
           })
  payload2 = User.find(1).payloads.create({
           "requestedAt"      => "2013-02-16 21:38:28 -0700",
           "respondedIn"      => 45,
           "referredBy"       => "http://google.com",
           "requestType"      => "GET",
           "parameters"       => [],
           "eventName"        => "socialLogi",
           "userAgent"        => "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_5_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
           "resolutionWidth"  => "1500",
           "resolutionHeight" => "1300",
           "ip"               => "63.29.38.211"
           })


   payload3 = User.find(1).payloads.create({
           "requestedAt"      => "2013-02-16 21:38:28 -0700",
           "respondedIn"      => 12,
           "referredBy"       => "http://github.com",
           "requestType"      => "POST",
           "parameters"       => [],
           "eventName"        => "socialLog",
           "userAgent"        => "Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_5_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
           "resolutionWidth"  => "1500",
           "resolutionHeight" => "1300",
           "ip"               => "63.22.38.128"
           })

   payload4 = User.find(1).payloads.create({
           "requestedAt"      => "2013-02-16 21:38:28 -0700",
           "respondedIn"      => 92,
           "referredBy"       => "http://bing.com",
           "requestType"      => "POST",
           "parameters"       => [],
           "eventName"        => "socialLo",
           "userAgent"        => "Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
           "resolutionWidth"  => "1500",
           "resolutionHeight" => "1900",
           "ip"               => "61.99.18.911"
           })
