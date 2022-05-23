include Booking

describe Booking do
  it('GET /booking should return a 200') do
    response = described_class.all_bookings

    expect(response.code).to be(200)
  end

  it('GET /booking/{id} should return a 200') do
    response = described_class.specific_booking(1, :json)

    expect(response.code).to be(200)
  end

  it('GET /booking/{id} should return a 418 when sent a bad accept header') do
    response = described_class.specific_booking(1, :text)

    expect(response.code).to be(418)
  end

  it('POST /booking should return a 200') do
    payload = BookingPayload.new do
      self.firstname = Faker::Name.first_name
      self.lastname = Faker::Name.last_name
      self.totalprice = Faker::Commerce.price
      self.depositpaid = true
      self.checkin = '11-11-2010'
      self.checkout = '12-11-2010'
      self.additionalneeds = 'Breakfast'
    end

    response = described_class.create_booking(payload.to_json, :json)

    expect(response.code).to be(200)
  end
end
