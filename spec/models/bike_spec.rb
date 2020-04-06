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
require 'rails_helper'

RSpec.describe Bike, type: :model do
  describe '#valid' do
    before do
      brand = FactoryBot.create(:brand)
      @bike = FactoryBot.create(:bike, brand: brand)
    end

    example '有効ならtrueを返す' do
      expect(@bike.valid?).to be_truthy
    end

    example 'シリアルナンバーが255文字以下ならtrueを返す' do
      @bike.serial_number = 'a' * 255
      expect(@bike.valid?).to be_truthy
    end
    
    example 'シリアルナンバーが256文字以上ならfalseを返す' do
      @bike.serial_number = 'a' * 256
      expect(@bike.valid?).to be_falsey
    end
  end
end
