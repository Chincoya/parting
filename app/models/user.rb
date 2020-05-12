class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}     
  has_many :tasks, foreign_key: 'author_id', inverse_of: 'author'    
end
