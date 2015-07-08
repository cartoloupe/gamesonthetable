require 'test_helper'

include Devise::TestHelpers

class PlayersControllerTest < ActionController::TestCase
  test "should get index" do
    sign_in users(:three)

    get :index
    assert_response :success
    assert_not_nil assigns(:players)

    sign_out users(:three)

  end

  test "should allow a player to join a game" do
    sign_in users(:three)

    assert_difference('Player.where(game_id: games(:one).id).count') do
      get(:join, {'game_id' => games(:one).id})
      assert_redirected_to game_path(games(:one))
      assert_equal "Successfully joined game.", flash[:notice]      
    end

    sign_out users(:three)
  end

  test "should allow a player to join a game they are already in" do
    sign_in users(:one)

    assert_no_difference('Player.where(game_id: games(:one).id).count') do
      get(:join, {'game_id' => games(:one).id})
      assert_redirected_to game_path(games(:one))
      assert_equal "Already in game.", flash[:notice]
    end

    sign_out users(:one)

  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should create player" do
  #   assert_difference('Player.count') do
  #     post :create, player: { comment: @player.comment, game_id: @player.game_id, game_id: @player.game_id, move: @player.move }
  #   end
  #
  #   assert_redirected_to player_path(assigns(:player))
  # end
  #
  # test "should show player" do
  #   get :show, id: @player
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @player
  #   assert_response :success
  # end
  #
  # test "should update player" do
  #   patch :update, id: @player, player: { comment: @player.comment, game_id: @player.game_id, game_id: @player.game_id, move: @player.move }
  #   assert_redirected_to player_path(assigns(:player))
  # end
  #
  # test "should destroy player" do
  #   assert_difference('Player.count', -1) do
  #     delete :destroy, id: @player
  #   end
  #
  #   assert_redirected_to players_path
  # end
end
