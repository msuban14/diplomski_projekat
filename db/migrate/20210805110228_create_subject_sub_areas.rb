class CreateSubjectSubAreas < ActiveRecord::Migration[6.1]
  def change
    create_table :subject_sub_areas do |t|
      t.string :name
      t.references :subject_area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
