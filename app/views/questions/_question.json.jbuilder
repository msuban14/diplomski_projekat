json.extract! question, :id, :content, :question_type_id, :lecture_id, :question_difficulty_id, :format, :additional_info ,:created_at, :updated_at
json.url question_url(question, format: :json)
