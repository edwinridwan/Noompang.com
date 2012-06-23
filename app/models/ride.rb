# == Schema Information
#
# Table name: rides
#
#  id                 :integer         not null, primary key
#  user_id            :integer         not null
#  start_address      :string(255)     not null
#  end_address        :string(255)     not null
#  start_lat          :float
#  start_long         :float
#  end_lat            :float
#  end_long           :float
#  start_date         :date            not null
#  start_time         :time            not null
#  end_date           :date            not null
#  end_time           :time            not null
#  distance_in_meters :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#
# Indexes
#
#  index_rides_on_user_id  (user_id)
#

class Ride < ActiveRecord::Base
  attr_accessible :user_id, :start_address, :end_address, :start_date, 
                  :start_time, :end_date, :end_time, :distance_in_meters, 
                  :start_lat, :start_long, :end_lat, :end_long, :no_seats, :price
  belongs_to :driver, :class_name => "User"
  has_many   :ride_requests, :dependent => :destroy

  validates :no_seats, :numericality => { :greater_than_or_equal_to => 1 }
  validates :price, :numericality => { :greater_than_or_equal_to => 0.00 }

end
