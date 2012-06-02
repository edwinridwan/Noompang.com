# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "MyString"
    password_digest "MyString"
    first_name "MyString"
    last_name "MyString"
    date_of_birth "2012-05-30"
    location "MyString"
    remember_token ""
    admin false
    mobile_number "MyString"
  end
end
