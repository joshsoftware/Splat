require 'xsd/qname'

# {}RestException
class RestException
  @@schema_type = "RestException"
  @@schema_ns = nil
  @@schema_element = [["status", ["SOAP::SOAPString", XSD::QName.new(nil, "Status")]], ["message", ["SOAP::SOAPString", XSD::QName.new(nil, "Message")]], ["code", ["SOAP::SOAPString", XSD::QName.new(nil, "Code")]], ["moreInfo", ["SOAP::SOAPString", XSD::QName.new(nil, "MoreInfo")]]]

  def Status
    @status
  end

  def Status=(value)
    @status = value
  end

  def Message
    @message
  end

  def Message=(value)
    @message = value
  end

  def Code
    @code
  end

  def Code=(value)
    @code = value
  end

  def MoreInfo
    @moreInfo
  end

  def MoreInfo=(value)
    @moreInfo = value
  end

  def initialize(status = nil, message = nil, code = nil, moreInfo = nil)
    @status = status
    @message = message
    @code = code
    @moreInfo = moreInfo
  end
end

# {}SMSMessage
class SMSMessage
  @@schema_type = "SMSMessage"
  @@schema_ns = nil
  @@schema_element = [["sid", ["SOAP::SOAPString", XSD::QName.new(nil, "Sid")]], ["dateCreated", ["SOAP::SOAPString", XSD::QName.new(nil, "DateCreated")]], ["dateUpdated", ["SOAP::SOAPString", XSD::QName.new(nil, "DateUpdated")]], ["dateSent", ["SOAP::SOAPString", XSD::QName.new(nil, "DateSent")]], ["accountSid", ["SOAP::SOAPString", XSD::QName.new(nil, "AccountSid")]], ["to", ["SOAP::SOAPString", XSD::QName.new(nil, "To")]], ["from", ["SOAP::SOAPString", XSD::QName.new(nil, "From")]], ["body", ["SOAP::SOAPString", XSD::QName.new(nil, "Body")]], ["status", ["SOAP::SOAPString", XSD::QName.new(nil, "Status")]], ["flags", ["SOAP::SOAPString", XSD::QName.new(nil, "Flags")]], ["price", ["SOAP::SOAPString", XSD::QName.new(nil, "Price")]]]

  def Sid
    @sid
  end

  def Sid=(value)
    @sid = value
  end

  def DateCreated
    @dateCreated
  end

  def DateCreated=(value)
    @dateCreated = value
  end

  def DateUpdated
    @dateUpdated
  end

  def DateUpdated=(value)
    @dateUpdated = value
  end

  def DateSent
    @dateSent
  end

  def DateSent=(value)
    @dateSent = value
  end

  def AccountSid
    @accountSid
  end

  def AccountSid=(value)
    @accountSid = value
  end

  def To
    @to
  end

  def To=(value)
    @to = value
  end

  def From
    @from
  end

  def From=(value)
    @from = value
  end

  def Body
    @body
  end

  def Body=(value)
    @body = value
  end

  def Status
    @status
  end

  def Status=(value)
    @status = value
  end

  def Flags
    @flags
  end

  def Flags=(value)
    @flags = value
  end

  def Price
    @price
  end

  def Price=(value)
    @price = value
  end

  def initialize(sid = nil, dateCreated = nil, dateUpdated = nil, dateSent = nil, accountSid = nil, to = nil, from = nil, body = nil, status = nil, flags = nil, price = nil)
    @sid = sid
    @dateCreated = dateCreated
    @dateUpdated = dateUpdated
    @dateSent = dateSent
    @accountSid = accountSid
    @to = to
    @from = from
    @body = body
    @status = status
    @flags = flags
    @price = price
  end
end

# {}TwilioResponse
class TwilioResponse
  @@schema_type = "TwilioResponse"
  @@schema_ns = nil
  @@schema_element = [["restException", ["RestException", XSD::QName.new(nil, "RestException")]], ["sMSMessage", ["SMSMessage", XSD::QName.new(nil, "SMSMessage")]]]

  def RestException
    @restException
  end

  def RestException=(value)
    @restException = value
  end

  def SMSMessage
    @sMSMessage
  end

  def SMSMessage=(value)
    @sMSMessage = value
  end

  def initialize(restException = nil, sMSMessage = nil)
    @restException = restException
    @sMSMessage = sMSMessage
  end
end
