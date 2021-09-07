class AddDependantQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :dependant_question, foreign_key:{to_table: :questions}
  end
end
