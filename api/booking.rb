require 'rest-client'

# Restful-booker only has one resource which is a booking resource.
# Module contains separate functions mapped to different endpoints in restful-booker using rest-client.
module Booking
  URL = 'https://restful-booker.herokuapp.com/booking'.freeze

  def all_bookings
    RestClient.get URL
  rescue StandardError => e
    e.response
  end

  def specific_booking(id, accept)
    RestClient.get "#{URL}/#{id}", accept: accept
  rescue StandardError => e
    e.response
  end

  def create_booking(payload, content_type)
    RestClient.post URL, payload, accept: :json, content_type: content_type
  rescue StandardError => e
    e.response
  end
end
