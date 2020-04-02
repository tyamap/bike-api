# 自転車の在庫テーブルを設定
class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|
      t.references    :brand,          null: false       # brandsテーブルのFK 
      t.string        :serial_number,   null: false       # シリアルナンバー
      t.datetime      :sold_at                            # 売却日 

      t.timestamps
    end
    add_index :bikes, 'serial_number', unique: true
    add_index :bikes, [ :brand_id, :sold_at ]
  end
end
