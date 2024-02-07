class CreateSlipvectorSurveyorsGuild < ActiveRecord::Migration[7.0]
  def change
    create_table :slipvector_star_systems, id: :uuid do |t|
      t.references :surveyors_guild, type: :uuid, foreign_key: {to_table: :furnitures}
      t.string :name
      t.jsonb :experience
      t.timestamps
    end

    create_enum :slipvector_survey_status, [
      "preparing",
      "active",
      "complete"
    ]

    create_table :slipvector_surveys, id: :uuid do |t|
      t.references :star_system, type: :uuid, foreign_key: {to_table: :slipvector_star_systems}
      t.enum :status, default: "preparing", null: false, enum_type: :slipvector_survey_status
      t.timestamps
    end
  end
end
