require "application_system_test_case"

class QuestionDifficultiesTest < ApplicationSystemTestCase
  setup do
    @question_difficulty = question_difficulties(:one)
  end

  test "visiting the index" do
    visit question_difficulties_url
    assert_selector "h1", text: "Question Difficulties"
  end

  test "creating a Question difficulty" do
    visit question_difficulties_url
    click_on "New Question Difficulty"

    fill_in "Name", with: @question_difficulty.name
    fill_in "Numerical representation", with: @question_difficulty.numerical_representation
    click_on "Create Question difficulty"

    assert_text "Question difficulty was successfully created"
    click_on "Back"
  end

  test "updating a Question difficulty" do
    visit question_difficulties_url
    click_on "Edit", match: :first

    fill_in "Name", with: @question_difficulty.name
    fill_in "Numerical representation", with: @question_difficulty.numerical_representation
    click_on "Update Question difficulty"

    assert_text "Question difficulty was successfully updated"
    click_on "Back"
  end

  test "destroying a Question difficulty" do
    visit question_difficulties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Question difficulty was successfully destroyed"
  end
end
