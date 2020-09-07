class CreateBoardTagRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :board_tag_relations do |t|
      t.integer :board_id, foreign_key: true
      t.integer :tag_id, foreign_key: true

      t.timestamps
    end
  end
end
