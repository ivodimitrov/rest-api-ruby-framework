require 'spec_helper'

include Booking

describe Booking do
  it('GET /booking should return a 200') do
    response = described_class.all_bookings

    expect(response.code).to be(200)
  end

  it('GET /booking/{id} should return a 200') do
    response = described_class.specific_booking(2367, :json)

    expect(response.code).to be(200)
  end

  it('GET /booking/{id} should return a 418 when sent a bad accept header') do
    response = described_class.specific_booking(2367, :text)

    expect(response.code).to be(418)
  end
end
