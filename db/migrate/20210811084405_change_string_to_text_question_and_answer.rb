class ChangeStringToTextQuestionAndAnswer < ActiveRecord::Migration[6.1]
  def change
    change_column :questions, :content, :text
    change_column :answers, :content, :text
  end
end
