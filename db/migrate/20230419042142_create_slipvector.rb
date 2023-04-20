class CreateSlipvector < ActiveRecord::Migration[7.0]
  def change
    create_table :slipvector_star_systems, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.integer :science_xp, default: 0
      t.integer :materials_xp, default: 0
      t.integer :energy_xp, default: 0
      t.timestamps
    end

    create_table :slipvector_surveys, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.references :star_system, type: :uuid, foreign_key: {to_table: :furnitures}
      t.integer :science_xp, default: 0
      t.integer :materials_xp, default: 0
      t.integer :energy_xp, default: 0
      t.timestamps
    end
  end
end
