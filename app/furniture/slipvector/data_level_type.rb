class Slipvector
  class DataLevelType < ActiveRecord::Type::Json
    def deserialize(string)
      return [] if string.nil?
      super.map do |data_level|
        DataLevel.new(**data_level)
      end
    end
  end
end
