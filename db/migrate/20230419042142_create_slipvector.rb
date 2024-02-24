class CreateSlipvector < ActiveRecord::Migration[7.0]
  def change
    create_table :slipvector_star_systems, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.string :name
      t.jsonb :experience
      t.timestamps
    end

    create_table :slipvector_surveys, id: :uuid do |t|
      t.references :star_system, type: :uuid, foreign_key: {to_table: :slipvector_star_systems}
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.integer :maximum_crewmates, default: 1, null: false
      t.string :status, default: "preparing", null: false
      t.timestamps
    end

    add_index :slipvector_surveys, [:surveyors_guild_id, :status]

    create_table :slipvector_surveyors, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.references :person, type: :uuid
      t.string :name, null: false
      t.string :pronouns, null: true
      t.timestamps
    end

    create_table :slipvector_crewmates, id: :uuid do |t|
      t.references :surveyor, type: :uuid, foreign_key: {to_table: :slipvector_surveyors}
      t.references :survey, type: :uuid, foreign_key: {to_table: :slipvector_surveys}
      t.timestamps
    end
  end
end
