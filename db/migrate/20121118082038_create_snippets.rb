class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.text :source

      t.timestamps
    end
  end
end
