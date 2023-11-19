class CreateSlipvectorSurveyorsGuild < ActiveRecord::Migration[7.0]
  def change
    create_table :slipvector_star_systems, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.integer :biological_xp, default: 0
      t.integer :material_xp, default: 0
      t.integer :energy_xp, default: 0
      t.timestamps
    end

    create_enum :slipvector_survey_status, [
      "preparing",
      "in_progress",
      "complete"
    ]

    create_table :slipvector_surveys, id: :uuid do |t|
      t.references :star_system, type: :uuid, foreign_key: {to_table: :slipvector_star_systems}
      t.integer :biological_dice_count
      t.integer :material_dice_count
      t.integer :energy_dice_count
      t.integer :biological_data
      t.integer :material_data
      t.integer :energy_data
      t.integer :multiplier
      t.integer :score
      t.integer :efficiency
      t.enum :status, default: "preparing", null: false, enum_type: :slipvector_survey_status
      t.timestamps
    end

    create_table :slipvector_survey_rolls, id: :uuid do |t|
      t.references :preceding_roll, type: :uuid, foreign_key: {to_table: :slipvector_survey_rolls}
      t.references :survey, type: :uuid, foreign_key: {to_table: :slipvector_surveys}
      t.jsonb :biological_dice
      t.jsonb :material_dice
      t.jsonb :energy_dice
      t.integer :turn
      t.timestamps
    end
  end
end
