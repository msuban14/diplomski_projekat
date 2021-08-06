class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :content
      t.references :question_type, null: false, foreign_key: true
      t.references :lecture, null: false, foreign_key: true
      t.references :question_difficulty, null: false, foreign_key: true

      t.timestamps
    end
  end
end
