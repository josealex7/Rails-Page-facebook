class MainComment < ApplicationRecord
    belongs_to :user
    belongs_to :publication

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