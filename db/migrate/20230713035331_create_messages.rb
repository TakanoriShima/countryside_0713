class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.integer :to_id
      t.text :content

      t.timestamps
    end
    add_index :messages, :from_id
    add_index :messages, :to_id
  end
end
