require 'rails_helper'

RSpec.describe Timecop, type: :service do
  it '' do
    Timecop.freeze Time.now
    time1 = Time.now
    Timecop.freeze time1 + 1.hour
    time2 = Time.now
    expect(time2 - time1).to be >= 1.hour
  end

end
