class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :projectname
      t.string :subprojectof
      t.string :description
      t.string :identifier

      t.timestamps
    end
  end
end
