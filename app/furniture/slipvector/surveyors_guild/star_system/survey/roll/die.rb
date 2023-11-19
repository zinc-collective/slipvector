class Slipvector
  class SurveyorsGuild::StarSystem::Survey::Roll
    class Die
      include ActiveModel::Model
      include ActiveModel::Attributes

      attribute :sides, :integer, default: 6
      attribute :value, :integer, default: 1
      attribute :index, :integer, default: nil
      attribute :kept, :boolean, default: false
      alias_method :kept?, :kept

      def keep!
        self.kept = true
      end

      def leave!
        self.kept = false
      end
    end
  end
end
