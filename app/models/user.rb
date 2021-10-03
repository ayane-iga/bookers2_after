class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true
  validates :name, length:{maximum:20}
  validates :name, length:{minimum:2}
  validates :introduction, length:{maximum:50}

  has_many :relationships, foreign_key: 'user_id'
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user) #フォローしているuserを持ってきてother_userがいないか確認
  end



  def self.search(search,content)
    if search == "forward_match"
      @user = User.where("name LIKE?", "#{content}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{content}")
    elsif search == "perfect_match"
      @user = User.where("#{content}")
    elsif search == "pertical_match"
      @user = User.where("name LIKE?", "%#{content}%")
    else
      @user = User.all
    end
  end
end
