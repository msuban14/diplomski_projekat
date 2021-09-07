class AddColumnsToQuestionsAndAnswers < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :format, :string
    add_column :questions, :additional_info, :text
    add_column :answers, :additional_info, :text
  end
end
