class CreateQuestionDifficulties < ActiveRecord::Migration[6.1]
  def change
    create_table :question_difficulties do |t|
      t.string :name
      t.integer :numerical_representation

      t.timestamps
    end
  end
end
