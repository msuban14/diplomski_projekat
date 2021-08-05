require "application_system_test_case"

class SubjectAreasTest < ApplicationSystemTestCase
  setup do
    @subject_area = subject_areas(:one)
  end

  test "visiting the index" do
    visit subject_areas_url
    assert_selector "h1", text: "Subject Areas"
  end

  test "creating a Subject area" do
    visit subject_areas_url
    click_on "New Subject Area"

    fill_in "Name", with: @subject_area.name
    click_on "Create Subject area"

    assert_text "Subject area was successfully created"
    click_on "Back"
  end

  test "updating a Subject area" do
    visit subject_areas_url
    click_on "Edit", match: :first

    fill_in "Name", with: @subject_area.name
    click_on "Update Subject area"

    assert_text "Subject area was successfully updated"
    click_on "Back"
  end

  test "destroying a Subject area" do
    visit subject_areas_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subject area was successfully destroyed"
  end
end
