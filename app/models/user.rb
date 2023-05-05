require 'date'

class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :images
  has_many :publications
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :userpages
  has_many :pages, through: :userpages, source: :page

  has_many :likes
  has_many :main_comments

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  MONTHS_ESP = {
    "x" => "No especificado",
    "f" => "Mujer",
    "m" => "Hombre",
    "o" => "Temas varios",
    "e" => "Entretenimiento",
    "c" => "Ciencia y Educación",
    "d" => "Deportes",
    "n" => "Noticias",
  }

  def type_gender
    MONTHS_ESP[self.sex]
  end


  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous"
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def not_friends_with?(id_of_friend)
    !self.friends.where(id: id_of_friend).exists?
  end

  def find_users_by_userpage_id
    usersAdmin = Userpage.where(userpage_id: self.id).pluck(:user_id)
  end

  def birthday_today
    self.friends.where("strftime('%m-%d', birthday) = ?", Date.today.strftime('%m-%d'))
  end

end
