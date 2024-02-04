class Slipvector
  class DataLevel
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    attribute :observes, :string
    validates :observes, inclusion: {in: [:energy, :life, :materials, :oddities]}
  end
end
