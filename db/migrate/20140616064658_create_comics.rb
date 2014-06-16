class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.integer :issue
      t.text :summary

      t.timestamps
    end
  end
end
