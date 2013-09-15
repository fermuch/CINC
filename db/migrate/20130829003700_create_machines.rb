# -*- encoding : utf-8 -*-
class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :sn
      t.string :model

      t.references :student

      t.timestamps
    end
  end
end
