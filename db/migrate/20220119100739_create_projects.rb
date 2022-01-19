class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :project_url
      t.string :stack
      t.text :description

      t.timestamps
    end
  end
end
