class User < ApplicationRecord

    has_secure_password

    has_many :looks, :dependent => :destroy
    has_many :favorites, :dependent => :destroy
    has_many :articles

    scope :non_authors, -> { where('NOT EXISTS(SELECT 1 FROM articles WHERE user_id = users.id)') }

    validates :login, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 } 
    validates :name, presence: true
    validates :sign, presence: true

end
