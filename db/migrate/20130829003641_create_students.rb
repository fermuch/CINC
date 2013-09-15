# -*- encoding : utf-8 -*-
class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :cuil

      t.references :machine

      t.timestamps
    end
  end
end
