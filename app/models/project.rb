class Project < ActiveRecord::Base
  include SoftDeletable

  validates :title, :presence => true, :uniqueness => true
  has_many :items, :dependent => :destroy

  def uncleared_items
    items.where(deleted: false)
  end
end
