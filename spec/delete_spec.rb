include Authorise
include BaseSteps
include Booking

describe '[DELETE] Restful-booker' do
  it 'responds with a 201 when deleting an existing booking', tms: '101' do
    response = Booking.delete_booking(id: BaseSteps.booking_id,
                                      token: BaseSteps.auth_response_token)

    expect(response.code).to be 201
  end

  it 'responds with a 405 when deleting a non existing booking', tms: '102' do
    response = Booking.delete_booking(id: Faker::Number.number(digits: 10),
                                      token: BaseSteps.auth_response_token)

    expect(response.code).to be 405
  end

  it 'responds with a 403 when token is missing', tms: '103' do
    response = Booking.delete_booking(id: BaseSteps.booking_id)

    expect(response.code).to be 403
  end

  it 'responds with a 403 when not authorised', tms: '104' do
    response = Booking.delete_booking(id: BaseSteps.booking_id,
                                      token: BaseSteps.auth_response_token(
                                        username: Faker::Internet.username(specifier: 5..10),
                                        password: Faker::Internet.password
                                      ))

    expect(response.code).to be 403
  end
end
