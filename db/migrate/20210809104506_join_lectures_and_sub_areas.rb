class JoinLecturesAndSubAreas < ActiveRecord::Migration[6.1]
  def change
    create_join_table :lectures, :subject_sub_areas do |t|
      t.index :lecture_id
      t.index :subject_sub_area_id
    end
  end
end
