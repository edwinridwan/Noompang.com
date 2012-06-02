# == Schema Information
#
# Table name: rides
#
#  id                 :integer         not null, primary key
#  user_id            :integer         not null
#  origin_address     :string(255)     not null
#  dst_address        :string(255)     not null
#  origin_lat         :float
#  origin_long        :float
#  dst_lat            :float
#  dst_long           :float
#  pickup_date        :date            not null
#  pickup_time        :time            not null
#  dropoff_date       :date            not null
#  dropoff_time       :date            not null
#  approx_arrival     :time
#  distance_in_meters :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#
# Indexes
#
#  index_rides_on_user_id  (user_id)
#

class Ride < ActiveRecord::Base
  attr_accessible :user_id, :origin_address, :dst_address, :pickup_date, :pickup_time, :dropoff_date, :dropoff_time
  belongs_to :driver, :class_name => "User"
  has_many   :passengers, :class_name => "User"
end
