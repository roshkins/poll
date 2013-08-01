class CreateQuestionaires < ActiveRecord::Migration
  def change
    create_table :questionaires do |t|
      t.integer :author_id

      t.timestamps
    end
    add_index :questionaires, :author_id
  end
end
