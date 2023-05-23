class MainComment < ApplicationRecord
    belongs_to :user
    belongs_to :publication

    validates :text_comment, presence: true
    validates :text_comment, length: { minimum: 5, maximum: 1000 }
    validates :user_id, :publication_id, presence: true
    validates_associated :user, :publication

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

    def date_comment
        month_name = MONTHS_ESP[self.created_at.strftime("%B")]
        self.created_at.strftime("%d de #{month_name} del %Y")
    end

end