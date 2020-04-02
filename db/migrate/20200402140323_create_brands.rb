# 自転車メーカーのブランド名を設定
class CreateBrands < ActiveRecord::Migration[6.0]
  def change
    create_table :brands do |t|
      t.string        :name,   null: false       # ブランド名

      t.timestamps
    end
    add_index :brands, 'name', unique: true
  end
end
