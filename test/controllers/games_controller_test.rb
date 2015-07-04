require 'test_helper'

include Devise::TestHelpers


class GamesControllerTest < ActionController::TestCase
  setup do
    @game = games(:one)

    sign_in users(:one)
  end

  teardown do
    @game = nil

    sign_out users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:games)
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should create game" do
    assert_difference('Game.count') do
      post :create, game: { name: @game.name, num_users: @game.num_users, status: @game.status, end_time: @game.end_time }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "should show game" do
    get :show, id: @game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game
    assert_response :success
  end

  test "should update game" do
    patch :update, id: @game, game: { name: @game.name, num_users: @game.num_users, status: @game.status, end_time: @game.end_time }
    assert_redirected_to game_path(assigns(:game))
  end

  test "should destroy game" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end

    assert_redirected_to games_path
  end

  test "should destroy game with players and delete the players" do
    assert_difference('Game.count', -1) do
      delete :destroy, id: @game
    end
    
    assert_equal(0, Player.where(game_id: @Game).count)

    assert_redirected_to games_path
  end


end
