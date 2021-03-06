class IssueSummary < ActiveRecord::Base
  has_many :tickets, :dependent => :destroy

  acts_as_paranoid

  validates :name, presence: true, length: { maximum: 20 }, on: [:create, :update]
  validate :unique_name, on: [:create, :update]

  def unique_name
    errors.add :name, 'has already been taken' if IssueSummary.with_deleted.where(name: self.name).exists? && self.changed? && self.name.downcase != self.name_was.try(:downcase)
  end
end
