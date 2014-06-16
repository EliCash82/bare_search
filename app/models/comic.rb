class Comic < ActiveRecord::Base


  validates :name, presence: true, uniqueness: true
  validates :summary, presence: true, uniqueness: true
  validates :issue, presence: true, uniqueness: true

  def self.search(query)
    where("name like ?", "%#{query}%")
  end

end
