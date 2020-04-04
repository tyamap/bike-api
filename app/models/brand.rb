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
class Brand < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 255 }

  has_many :bikes, dependent: :destroy, autosave: true
end
