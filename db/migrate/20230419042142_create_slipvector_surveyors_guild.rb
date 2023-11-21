class CreateSlipvectorSurveyorsGuild < ActiveRecord::Migration[7.0]
  def change
    create_table :slipvector_star_systems, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.integer :energy_data, default: 0
      t.integer :life_data, default: 0
      t.integer :material_data, default: 0
      t.integer :oddities_data, default: 0
      t.timestamps
    end

    create_enum :slipvector_survey_status, [
      "preparing",
      "in_progress",
      "complete"
    ]

    create_table :slipvector_surveys, id: :uuid do |t|
      t.references :star_system, type: :uuid, foreign_key: {to_table: :slipvector_star_systems}
      t.integer :energy_dice_count
      t.integer :life_dice_count
      t.integer :material_dice_count
      t.integer :oddity_dice_count
      t.integer :energy_data
      t.integer :life_data
      t.integer :material_data
      t.integer :oddity_data
      t.integer :turns
      t.integer :score
      t.integer :efficiency
      t.enum :status, default: "preparing", null: false, enum_type: :slipvector_survey_status
      t.timestamps
    end

    create_table :slipvector_survey_rolls, id: :uuid do |t|
      t.references :preceding_roll, type: :uuid, foreign_key: {to_table: :slipvector_survey_rolls}
      t.references :survey, type: :uuid, foreign_key: {to_table: :slipvector_surveys}
      t.jsonb :energy_dice
      t.jsonb :life_dice
      t.jsonb :material_dice
      t.jsonb :oddity_dice
      t.integer :turn
      t.timestamps
    end
  end
end
