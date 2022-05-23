class BookingPayload
  attr_accessor :firstname, :lastname, :totalprice, :depositpaid, :checkin, :checkout, :additionalneeds

  def initialize(&)
    instance_eval(&) if block_given?
  end

  def to_json(*_args)
    { firstname: firstname,
      lastname: lastname,
      totalprice: totalprice,
      depositpaid: depositpaid,
      bookingdates: { checkin: checkin,
                      checkout: checkout },
      additionalneeds: additionalneeds }.to_json
  end
end
