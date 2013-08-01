class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :question_answer_id
      t.integer :voter_id

      t.timestamps
    end
    add_index :votes, :question_answer_id
    add_index :votes, :voter_id

  end
end
