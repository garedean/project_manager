class Project < ActiveRecord::Base
  validates :title, :presence => true, :uniqueness => true
  has_many :items, :dependent => :destroy

  def soft_delete
    update(deleted: true)
  end
end
