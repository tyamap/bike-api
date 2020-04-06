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
class Bike < ApplicationRecord
  validates :serial_number, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 255 }
  validate :is_already_sold, on: :update

  belongs_to :brand

  # すでに売却されていないかチェック
  def is_already_sold
    if sold_at_was.present?
      errors.add(:sold_at, "is already sold")
    end
  end
end
