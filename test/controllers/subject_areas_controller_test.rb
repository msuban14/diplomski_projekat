require "test_helper"

class SubjectAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subject_area = subject_areas(:one)
  end

  test "should get index" do
    get subject_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_subject_area_url
    assert_response :success
  end

  test "should create subject_area" do
    assert_difference('SubjectArea.count') do
      post subject_areas_url, params: { subject_area: { name: @subject_area.name } }
    end

    assert_redirected_to subject_area_url(SubjectArea.last)
  end

  test "should show subject_area" do
    get subject_area_url(@subject_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_subject_area_url(@subject_area)
    assert_response :success
  end

  test "should update subject_area" do
    patch subject_area_url(@subject_area), params: { subject_area: { name: @subject_area.name } }
    assert_redirected_to subject_area_url(@subject_area)
  end

  test "should destroy subject_area" do
    assert_difference('SubjectArea.count', -1) do
      delete subject_area_url(@subject_area)
    end

    assert_redirected_to subject_areas_url
  end
end
