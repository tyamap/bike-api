class CreateBikes < ActiveRecord::Migration[6.0]
  def change
    create_table :bikes do |t|

      t.timestamps
    end
  end
end
