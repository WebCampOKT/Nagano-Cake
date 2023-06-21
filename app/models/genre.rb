class Genre < ApplicationRecord
  has_many :items

  validates :name, presence: true
  def self.search_items_for(content, method)
    
    if method == 'perfect'
      tags = Genre.where(name: content)
    end
    
    return tags.inject(init = []) {|result, tag| result + tag.books}
    
  end
end
