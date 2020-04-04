# == Schema Information
#
# Table name: brands
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "brand#{n}" }
  end
end