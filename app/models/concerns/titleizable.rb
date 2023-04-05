module Titleizable
  extend ActiveSupport::Concern
  included do
    before_save :titleize_attributes!
  end
  module ClassMethods
    def titleize_attributes(*attributes)
      define_method :attributes_to_titleize do
        attributes
      end
    end
  end

  def titleize_attributes!
    attributes_to_titleize.each do |attr|
      val = send(attr)
      # add regex para ignorar as preposições e capitalizar somente as primeiras letras
      send("#{attr}=", val.try(:strip).to_s.titleize.gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e '))
    end
  end
end
