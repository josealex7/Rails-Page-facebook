require 'test_helper'

class LikesControllerTest < ActionController::TestCase
    include Devise::Test::ControllerHelpers

    user = User.create(email: 'john@example.com', password: 'secret')
    login_as(user, scope: :user)

    test "should update like" do
        # Simula una solicitud PUT al método update del controlador
        put :update, params: { publication_id: 1 }

        # Verifica que la respuesta HTTP sea 204 (no content)
        assert_response :no_content

        # Verifica que el valor del campo is_like haya cambiado en la base de datos
        like = Like.find_by(user_id: user.id, publication_id: 1)
        assert_not_nil like
        assert_not_equal like.is_like, true
    end
end