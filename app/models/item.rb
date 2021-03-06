class Item < ActiveRecord::Base
  include SoftDeletable

  belongs_to :project
  validates :action,
    :presence => true,
    :uniqueness => { :scope => :project,
                     :message => 'should be unique within a project' }
  validates :project_id, :presence => true
  scope :complete, -> { where(:done => true) }
  scope :complete_and_undeleted, -> { where(:done => true, :deleted => false) }
end
