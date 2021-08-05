class CreateLectures < ActiveRecord::Migration[6.1]
  def change
    create_table :lectures do |t|
      t.string :name
      t.integer :week
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
