class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: { in: 2..20}
  validates :introduction, length: { maximum: 50 }
  #validates :postcode, presence: true
  #validates :prefecture_code, presence: true
  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #フォロー機能の記載
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :entries
  has_many :direct_messages
  has_many :rooms, through: :entries

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
      self.followings.include?(other_user)
  end

  def self.search(search,word)
      if search == "forward_match"
             @user = User.where("name LIKE?","#{word}%")
      elsif search == "backward_match"
            @user = User.where("name LIKE?","%#{word}")
      elsif search == "perfect_match"
            @user = User.where("#{word}")
        unless @word == "perfect_match"
            @user = User.none
        end
      elsif search == "partial_match"
            @user = User.where("name LIKE?","%#{word}%")
      else
            @user = User.all
      end
  end

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
      JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
      self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

end