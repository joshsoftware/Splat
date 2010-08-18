
require 'rubygems'
require '../lib/splat'

number = '+91 9960054954'

gateways = {}
gateways['bulksms'] = Splat::Base.new(:bulksmspune)
gateways['vmobo'] = Splat::Base.new(:vmobo)


msg = "Testing for splat"
gateways.each do |provider, obj|
  p "Sending SMS via #{provider}"
  p obj.send_sms(msg, number)
  p "SMS Sent successfully via #{provider}"
end

p "========================"

msg = "Testing for splat"
numbers = ['+91 9960054954', '+91 9960054954']
gateways.each do |provider, obj|
  p obj.send_bulk_sms(msg, numbers) 
  p "Bulk Send successfully via #{provider}"
end
p "========================"

custom_msg = "Hi $1, hold on to your $2."
options = {'+91 9970831117' => ['Sagar', 'coffee'],
           '+91 9860352988' => ['Gautam' , 'stocks']}
           #'+91 9880397111' => ['Jane' , 'skirt']}

gateways.each do |provider, obj|
  p obj.send_bulk_sms_with_insertion(custom_msg, options)
  p "Bulk Send successfully via #{provider}"
end



