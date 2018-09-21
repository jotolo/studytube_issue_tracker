class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.references :user
      t.references :manager
      t.integer :status

      t.timestamps
    end
  end
end
