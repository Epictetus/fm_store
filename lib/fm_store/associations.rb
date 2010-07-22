# encoding: utf-8
require 'fm_store/associations/proxy'
require 'fm_store/associations/options'
require 'fm_store/associations/has_many'
require 'fm_store/associations/belongs_to'

module FmStore
  module Associations
    extend ActiveSupport::Concern
    
    module ClassMethods
      def has_many(name, options = {})
        associate(Associations::HasMany, optionize(name, options))
      end
      
      def belongs_to(name, options= {})
        associate(Associations::BelongsTo, optionize(name, options))
      end
      
      protected
      
      def associate(type, options)
        name = options.name.to_s
        
        define_method(name) { @_type ||= type.new(self, options) }
        define_method("#{name}=") do |object|
          type.update(object, self, options)
        end
      end
      
      def optionize(name, options)
        Associations::Options.new(options.merge(:name => name))
      end
      
    end
  end
end