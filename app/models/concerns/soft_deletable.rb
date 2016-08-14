require 'active_support/concern'

module SoftDeletable
  extend ActiveSupport::Concern

  def soft_delete
    update(deleted: true)
  end

  module ClassMethods
    # ar_collection is an ActiveRecord_AssociationRelation object
    def soft_delete_all(ar_collection)
      ar_collection.each { |e| e.soft_delete }
    end
  end
end
