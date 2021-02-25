class Level < ActiveHash::Base
  self.data = [
    { id: 1, name: '▽ ▽ ▽' },
    { id: 2, name: 'レベル1' },
    { id: 3, name: 'レベル2' },
    { id: 4, name: 'レベル3' }
  ]

  include ActiveHash::Associations
  has_many :recipes
end
