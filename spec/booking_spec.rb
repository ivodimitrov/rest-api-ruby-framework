include Booking

describe Booking do
  let(:payload) do
    BookingPayload.new do
      self.firstname = Faker::Name.first_name
      self.lastname = Faker::Name.last_name
      self.totalprice = Faker::Number.number(digits: 3)
      self.depositpaid = true
      self.checkin = '2010-11-11'
      self.checkout = '2010-12-11'
      self.additionalneeds = 'Breakfast'
    end
  end

  let(:booking_id) do
    response = described_class.create_booking(payload.to_json, :json)
    JSON.parse(response.body)['bookingid']
  end

  it('GET /booking should return a 200') do
    response = described_class.all_bookings

    expect(response.code).to be 200
  end

  it('GET /booking/{id} should return a 200') do
    response = described_class.specific_booking(booking_id, :json)

    expect(response.code).to be 200
  end

  it('GET /booking/{id} should return a 418 when sent a bad accept header') do
    response = described_class.specific_booking(booking_id, :text)

    expect(response.code).to be 418
  end

  it('POST /booking should return a 200') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(response.code).to be 200
  end

  it('POST /booking should return first name') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['firstname']).to eq payload.firstname
  end

  it('POST /booking should return last name') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['lastname']).to eq payload.lastname
  end

  it('POST /booking should return total price') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['totalprice']).to eq payload.totalprice
  end

  it('POST /booking should return deposit paid') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['depositpaid']).to be true
  end

  it('POST /booking should return check in') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['bookingdates']['checkin']).to eq payload.checkin
  end

  it('POST /booking should return check out') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['bookingdates']['checkout']).to eq payload.checkout
  end

  it('POST /booking should return additional needs') do
    response = described_class.create_booking(payload.to_json, :json)

    expect(JSON.parse(response.body)['booking']['additionalneeds']).to eq payload.additionalneeds
  end
end
