class Publication < ApplicationRecord
    belongs_to :user
    belongs_to :image, optional: true

    has_many :likes
    has_many :main_comments

    has_many :publication_shares
    has_many :publicationshares, through: :publication_shares

    MONTHS_ESP = {
        "January" => "Enero",
        "February" => "Febrero",
        "March" => "Marzo",
        "April" => "Abril",
        "May" => "Mayo",
        "June" => "Junio",
        "July" => "Julio",
        "August" => "Agosto",
        "September" => "Septiembre",
        "October" => "Octubre",
        "November" => "Noviembre",
        "December" => "Diciembre"
      }

    def date_publication
        month_name = MONTHS_ESP[self.created_at.strftime("%B")]
        self.created_at.strftime("%d de #{month_name} del %Y")
    end

    def user_not_liked(current_user)
        like = Like.find_by(user_id: current_user.id, publication_id: self.id)
        !like.is_like
    end

    def user_liked(current_user)
        return false if !exist_liked(current_user)
        like = Like.find_by(user_id: current_user.id, publication_id: self.id)
        return like.is_like
    end

    def exist_liked(current_user)
        like = Like.find_by(user_id: current_user.id, publication_id: self.id)
        if like.nil?
            return false
        else
            return true
        end
    end

    def like_id(current_user)
        like = Like.find_by(user_id: current_user.id, publication_id: self.id)
        return like.id
    end

    def original
        !publication_shares.any?
    end
end