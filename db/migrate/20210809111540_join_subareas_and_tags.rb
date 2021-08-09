class JoinSubareasAndTags < ActiveRecord::Migration[6.1]
    def change
      create_join_table :subject_sub_areas, :tags do |t|
        t.index :subject_sub_area_id
        t.index :tag_id
      end
    end
end
