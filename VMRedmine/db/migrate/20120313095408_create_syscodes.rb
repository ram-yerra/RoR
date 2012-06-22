class CreateSyscodes < ActiveRecord::Migration
  def change
    create_table :syscodes do |t|
      t.integer :id
      t.string :syscode
      t.string :syscode_desc
      t.integer :isactive
      t.integer :fksyscodeparent
      t.integer :createdby
      t.datetime :datecreated
      t.datetime :datemodified
      t.integer :modifiedby

      t.timestamps
    end
  end
end
