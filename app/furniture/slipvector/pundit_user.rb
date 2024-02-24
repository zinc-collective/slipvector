class Slipvector
  class PunditUser < SimpleDelegator
    attr_accessor :surveyor

    def initialize(object, surveyor:)
      self.surveyor = surveyor
      super(object)
    end
  end
end
