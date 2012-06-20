# == Schema Information
#
# Table name: ride_requests
#
#  id            :integer         not null, primary key
#  ride_id       :integer         not null
#  user_id       :integer         not null
#  start_date    :date
#  start_time    :time
#  end_date      :date
#  end_time      :time
#  start_address :string(255)
#  end_address   :string(255)
#  start_lat     :float
#  start_long    :float
#  end_lat       :float
#  end_long      :float
#  request_code  :string(255)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#
# Indexes
#
#  index_ride_requests_on_request_code  (request_code)
#

class RideRequest < ActiveRecord::Base
  #attr_accessible :title, :body
  belongs_to :ride
  belongs_to :user

  default_scope :order => 'created_at DESC'
end
