require "test_helper"

class QuestionDifficultiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question_difficulty = question_difficulties(:one)
  end

  test "should get index" do
    get question_difficulties_url
    assert_response :success
  end

  test "should get new" do
    get new_question_difficulty_url
    assert_response :success
  end

  test "should create question_difficulty" do
    assert_difference('QuestionDifficulty.count') do
      post question_difficulties_url, params: { question_difficulty: { name: @question_difficulty.name, numerical_representation: @question_difficulty.numerical_representation } }
    end

    assert_redirected_to question_difficulty_url(QuestionDifficulty.last)
  end

  test "should show question_difficulty" do
    get question_difficulty_url(@question_difficulty)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_difficulty_url(@question_difficulty)
    assert_response :success
  end

  test "should update question_difficulty" do
    patch question_difficulty_url(@question_difficulty), params: { question_difficulty: { name: @question_difficulty.name, numerical_representation: @question_difficulty.numerical_representation } }
    assert_redirected_to question_difficulty_url(@question_difficulty)
  end

  test "should destroy question_difficulty" do
    assert_difference('QuestionDifficulty.count', -1) do
      delete question_difficulty_url(@question_difficulty)
    end

    assert_redirected_to question_difficulties_url
  end
end
