require 'rest-client'

# Restful-booker only has one resource which is a booking resource.
# Module contains separate functions mapped to different endpoints in restful-booker using rest-client.
module Booking
  def all_bookings
    RestClient.get 'https://restful-booker.herokuapp.com/booking'
  rescue StandardError => e
    e.response
  end

  def specific_booking(id, accept)
    RestClient.get "https://restful-booker.herokuapp.com/booking/#{id}", accept: accept
  rescue StandardError => e
    e.response
  end
end
