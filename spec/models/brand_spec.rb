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
require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe '#valid?' do
    before do
      @brand = FactoryBot.create(:brand)
    end

    example '有効ならtrueを返す' do
      expect(@brand.valid?).to be_truthy
    end

    example 'ブランド名が255文字以下ならtrueを返す' do
      @brand.name = 'a' * 255
      expect(@brand.valid?).to be_truthy
    end
    
    example 'ブランド名が256文字以上ならfalseを返す' do
      @brand.name = 'a' * 256
      expect(@brand.valid?).to be_falsey
    end
  end
end