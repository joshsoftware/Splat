
require 'rubygems'
require 'lib/splat'


gateways = {}
#gateways['bulksms'] = Splat::Base.new(:bulksmspune)
#gateways['vmobo'] = Splat::Base.new(:vmobo)
#gateways['clickatell'] = Splat::Base.new(:clickatell)
gateways['twilio'] = Splat::Base.new(:twilio)


#number = '+1 5599726538'
number = '+91 9960054954'
msg = "Testing for splat"
gateways.each do |provider, obj|
  p "Sending SMS via #{provider}"
  p obj.send_sms(msg, number)
  p "SMS Sent successfully via #{provider}"
end
p "========================"

=begin
msg = "Testing for splat"
numbers = ['+91 9960054954', '+91 9850888082']
gateways.each do |provider, obj|
  p obj.send_bulk_sms(msg, numbers) 
  p "Bulk Send successfully via #{provider}"
end
p "========================"


custom_msg = "Hi, $1, hold on to your $2."
options = {'+91 9960054954' => ['Sagar', 'coffee']}
           #'+91 9850888082' => ['Gautam' , 'stocks']}
           #'+91 9880397111' => ['Jane' , 'skirt']}

gateways.each do |provider, obj|
  p obj.send_bulk_sms_with_insertion(custom_msg, options)
  p "Bulk Send successfully via #{provider}"
end

=end


