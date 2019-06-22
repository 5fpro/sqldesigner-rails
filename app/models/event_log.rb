# == Schema Information
#
# Table name: event_logs
#
#  id          :bigint(8)        not null, primary key
#  event_type  :string
#  description :string
#  identity    :string
#  created_on  :date
#  data        :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class EventLog < Tyr::EventLog
end
