# == Schema Information
#
# Table name: ride_requests
#
#  id              :integer         not null, primary key
#  ride_id         :integer         not null
#  user_id         :integer         not null
#  pickup_date     :date
#  pickup_time     :time
#  dropoff_date    :date
#  dropoff_time    :time
#  pickup_address  :string(255)
#  dropoff_address :string(255)
#  pickup_lat      :float
#  pickup_long     :float
#  dropoff_lat     :float
#  dropoff_long    :float
#  request_code    :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#
# Indexes
#
#  index_ride_requests_on_request_code  (request_code)
#

class RideRequest < ActiveRecord::Base
  #attr_accessible :title, :body
  belongs_to :ride
  belongs_to :user
end
