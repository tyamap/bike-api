# == Schema Information
#
# Table name: bikes
#
#  id            :bigint           not null, primary key
#  serial_number :string(255)      not null
#  sold_at       :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  brand_id      :bigint           not null
#
# Indexes
#
#  index_bikes_on_brand_id              (brand_id)
#  index_bikes_on_brand_id_and_sold_at  (brand_id,sold_at)
#  index_bikes_on_serial_number         (serial_number) UNIQUE
#
FactoryBot.define do
  factory :bike do
    brand_id { 1 }
    sequence(:serial_number) { |n| "sn_#{n}" }
  end
end
