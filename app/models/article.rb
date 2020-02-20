class Article < ApplicationRecord

  has_many :looks, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  belongs_to :user

  validates :head, presence: true
  validates :announcement, presence: true
  validates :content, presence: true
  
end
