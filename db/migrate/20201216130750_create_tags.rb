class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, null:false, uniqueness: true
      # 「uniqueness: true」重複避けるための制約
      t.timestamps
    end
  end
end
