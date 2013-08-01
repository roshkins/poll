class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question
      t.integer :questionaire_id

      t.timestamps
    end
    add_index :questions, :questionaire_id
  end
end
