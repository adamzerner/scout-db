require 'test_helper'

class PlayerNotesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get player_notes_create_url
    assert_response :success
  end

  test "should get update" do
    get player_notes_update_url
    assert_response :success
  end

end
