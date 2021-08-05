require "test_helper"

class SubjectSubAreasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subject_sub_area = subject_sub_areas(:one)
  end

  test "should get index" do
    get subject_sub_areas_url
    assert_response :success
  end

  test "should get new" do
    get new_subject_sub_area_url
    assert_response :success
  end

  test "should create subject_sub_area" do
    assert_difference('SubjectSubArea.count') do
      post subject_sub_areas_url, params: { subject_sub_area: { name: @subject_sub_area.name, subject_area_id: @subject_sub_area.subject_area_id } }
    end

    assert_redirected_to subject_sub_area_url(SubjectSubArea.last)
  end

  test "should show subject_sub_area" do
    get subject_sub_area_url(@subject_sub_area)
    assert_response :success
  end

  test "should get edit" do
    get edit_subject_sub_area_url(@subject_sub_area)
    assert_response :success
  end

  test "should update subject_sub_area" do
    patch subject_sub_area_url(@subject_sub_area), params: { subject_sub_area: { name: @subject_sub_area.name, subject_area_id: @subject_sub_area.subject_area_id } }
    assert_redirected_to subject_sub_area_url(@subject_sub_area)
  end

  test "should destroy subject_sub_area" do
    assert_difference('SubjectSubArea.count', -1) do
      delete subject_sub_area_url(@subject_sub_area)
    end

    assert_redirected_to subject_sub_areas_url
  end
end
