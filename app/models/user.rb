class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :tweets
  has_many :follows  , class_name: "Follow", foreign_key: "user_id"
  has_many :followers, class_name: "Follow", foreign_key: "follow_user_id"

  def already_followed?(user)
    Follow.find_by(follow_user_id: user.id, user_id: self.id)
  end

  LIMIT = 20
  OFFSET = 0

  def self.search_limited(*args)
    options = args[0]
    rows = User.all
    if options.blank?
      return rows.order(id: :DESC).limit(LIMIT).offset(OFFSET)
    end
    unless options[:search].blank?
      rows = rows.where("name LIKE ?", "%#{options[:search]}%")
    end
    offset = options[:offset].blank? ? OFFSET : options[:offset]
    rows = rows.order(id: :DESC).limit(LIMIT).offset(offset)
    return rows
  end
end
