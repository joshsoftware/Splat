!SLIDE 

# Installing SPlat

    $ gem install splat

!SLIDE

# Initializing the SMS gateways

!SLIDE

# Configuring SPlat

!SLIDE bullets

# Mobile number formats

* +1 501-234-8473
* 001 5012348473
* +5012348473
* 5012348473
* All vendors have their own formats.

!SLIDE

# Splat default number format

    @@@ruby
    /^\+\d{1,4}\ \d{8,12}$/  # +91 9812345867


!SLIDE bullets incremental

# Splat callback

* Application can register a callback.
* :before_send 
* Manipulate the number to splat format.

!SLIDE 

# Demo1 - Send a simple SMS

    @@@ruby
    require 'lib/splat'
        
    number = '+91 9960054954'
    gw1 = Splat::Base.new(:vmobo)

    msg = "Fall SPlat on your face!"
    p gw1.send_sms(msg, number)

!SLIDE commandline incremental

# Demo1 - the first run!

    $ ruby test.rb
    #<Splat::Response:0x1015530c8 @phone_numbers...

!SLIDE  

# Demo2 - Using both SMS gateways together

    @@@ruby

    gw = {}
    gw['bulksms'] = Splat::Base.new(:bulksmspune)
    gw['vmobo'] = Splat::Base.new(:vmobo)

    numbers = ['+91 9960054954', '+91 9881395656']
    gw.each do |provider, obj|
        obj.send_bulk_sms(msg, numbers) 
    end

!SLIDE

# Demo3 - Custom messages 

    @@@ruby
    custom_msg = "Hi $1, hold on to your $2."
    options = {
     '+91 9960054954' => ['Jiren', 'shorts'],
     '+91 9881395656' => ['Gautam' , 'stocks'],
     '+91 9880397111' => ['Jane' , 'skirt']
    }

    gw.send_bulk_sms_with_insertion(custom_msg,
                                options)
