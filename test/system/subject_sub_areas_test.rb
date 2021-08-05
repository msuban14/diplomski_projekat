require "application_system_test_case"

class SubjectSubAreasTest < ApplicationSystemTestCase
  setup do
    @subject_sub_area = subject_sub_areas(:one)
  end

  test "visiting the index" do
    visit subject_sub_areas_url
    assert_selector "h1", text: "Subject Sub Areas"
  end

  test "creating a Subject sub area" do
    visit subject_sub_areas_url
    click_on "New Subject Sub Area"

    fill_in "Name", with: @subject_sub_area.name
    fill_in "Subject area", with: @subject_sub_area.subject_area_id
    click_on "Create Subject sub area"

    assert_text "Subject sub area was successfully created"
    click_on "Back"
  end

  test "updating a Subject sub area" do
    visit subject_sub_areas_url
    click_on "Edit", match: :first

    fill_in "Name", with: @subject_sub_area.name
    fill_in "Subject area", with: @subject_sub_area.subject_area_id
    click_on "Update Subject sub area"

    assert_text "Subject sub area was successfully updated"
    click_on "Back"
  end

  test "destroying a Subject sub area" do
    visit subject_sub_areas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subject sub area was successfully destroyed"
  end
end
