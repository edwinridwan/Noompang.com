# == Schema Information
#
# Table name: notifications
#
#  id         :integer         not null, primary key
#  subject_id :integer         not null
#  verb       :string(255)     not null
#  target_id  :integer
#  type       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  object_id  :integer
#
# Indexes
#
#  index_notifications_on_target_id   (target_id)
#  index_notifications_on_subject_id  (subject_id)
#

class Notification < ActiveRecord::Base
  attr_accessible :subject_id, :target_id, :object_id, :type, :verb
  
  after_initialize :init

  validates :subject_id, presence: true
  validates :verb, presence: true
  validates :type, presence: true

  default_scope :order => 'created_at DESC'
end
