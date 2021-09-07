# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_03_160637) do

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.boolean "isCorrect"
    t.integer "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "additional_info"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.string "name"
    t.integer "week"
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_lectures_on_course_id"
  end

  create_table "lectures_subject_sub_areas", id: false, force: :cascade do |t|
    t.integer "lecture_id", null: false
    t.integer "subject_sub_area_id", null: false
    t.index ["lecture_id"], name: "index_lectures_subject_sub_areas_on_lecture_id"
    t.index ["subject_sub_area_id"], name: "index_lectures_subject_sub_areas_on_subject_sub_area_id"
  end

  create_table "question_difficulties", force: :cascade do |t|
    t.string "name"
    t.integer "numerical_representation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "question_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "question_type_id", null: false
    t.integer "lecture_id", null: false
    t.integer "question_difficulty_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "dependant_question_id"
    t.string "format"
    t.text "additional_info"
    t.index ["dependant_question_id"], name: "index_questions_on_dependant_question_id"
    t.index ["lecture_id"], name: "index_questions_on_lecture_id"
    t.index ["question_difficulty_id"], name: "index_questions_on_question_difficulty_id"
    t.index ["question_type_id"], name: "index_questions_on_question_type_id"
  end

  create_table "questions_tags", id: false, force: :cascade do |t|
    t.integer "question_id", null: false
    t.integer "tag_id", null: false
    t.index ["question_id"], name: "index_questions_tags_on_question_id"
    t.index ["tag_id"], name: "index_questions_tags_on_tag_id"
  end

  create_table "subject_areas", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subject_sub_areas", force: :cascade do |t|
    t.string "name"
    t.integer "subject_area_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_area_id"], name: "index_subject_sub_areas_on_subject_area_id"
  end

  create_table "subject_sub_areas_tags", id: false, force: :cascade do |t|
    t.integer "subject_sub_area_id", null: false
    t.integer "tag_id", null: false
    t.index ["subject_sub_area_id"], name: "index_subject_sub_areas_tags_on_subject_sub_area_id"
    t.index ["tag_id"], name: "index_subject_sub_areas_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "lectures", "courses"
  add_foreign_key "questions", "lectures"
  add_foreign_key "questions", "question_difficulties"
  add_foreign_key "questions", "question_types"
  add_foreign_key "questions", "questions", column: "dependant_question_id"
  add_foreign_key "subject_sub_areas", "subject_areas"
end
