class Slipvector
  class DataLevel
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :elmo, :string
    validates :elmo, inclusion: {in: [:energy, :life, :materials, :oddities]}

    attribute :xp, :integer
    validates :xp, numericality: true

    def label
      ELMOS.fetch(elmo.to_sym)
    end
  end
end
