# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151202053442) do

  create_table "applicant_tags", force: true do |t|
    t.integer  "applicant_id", precision: 38, scale: 0
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applicant_tags", ["applicant_id"], name: "i_applicant_tags_applicant_id"

  create_table "applicants", force: true do |t|
    t.integer  "user_id",               precision: 38, scale: 0
    t.integer  "procedure_id",          precision: 38, scale: 0
    t.datetime "application_submit_at"
    t.string   "rd_flag_color",                                  default: "green"
    t.boolean  "disqualify",            precision: 1,  scale: 0, default: false,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "ranked_at"
  end

  add_index "applicants", ["procedure_id", "user_id"], name: "i_app_pro_id_use_id", unique: true
  add_index "applicants", ["user_id", "procedure_id"], name: "i_app_use_id_pro_id", unique: true

  create_table "applications", force: true do |t|
    t.integer  "user_id",            precision: 38, scale: 0
    t.integer  "position_id",        precision: 38, scale: 0
    t.integer  "user_rank",          precision: 38, scale: 0, default: 999999, null: false
    t.integer  "mgr_rank",           precision: 38, scale: 0, default: 999999, null: false
    t.string   "offered"
    t.boolean  "auto_match",         precision: 1,  scale: 0
    t.string   "offer_accept"
    t.integer  "rd_flag",            precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "disable_user_rank",  precision: 1,  scale: 0
    t.boolean  "disable_mgr_rank",   precision: 1,  scale: 0
    t.datetime "mgr_ranked_at"
    t.integer  "mgr_ranked_user_id", precision: 38, scale: 0
  end

  add_index "applications", ["position_id", "user_id"], name: "i_app_pos_id_use_id", unique: true
  add_index "applications", ["user_id", "position_id"], name: "i_app_use_id_pos_id", unique: true

  create_table "apply_white_lists", force: true do |t|
    t.integer "procedure_id", precision: 38, scale: 0
    t.integer "user_id",      precision: 38, scale: 0
  end

  add_index "apply_white_lists", ["procedure_id", "user_id"], name: "i_app_whi_lis_pro_id_use_id", unique: true
  add_index "apply_white_lists", ["user_id", "procedure_id"], name: "i_app_whi_lis_use_id_pro_id", unique: true

  create_table "email_templates", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "email_type"
    t.integer  "procedure_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",    precision: 1,  scale: 0
  end

  create_table "form_inputs", force: true do |t|
    t.integer  "form_id",            precision: 38, scale: 0
    t.string   "form_table"
    t.string   "form_type"
    t.string   "form_name"
    t.integer  "schema_row",         precision: 38, scale: 0
    t.integer  "schema_column",      precision: 38, scale: 0
    t.text     "schema_description"
    t.string   "schema_type"
    t.text     "schema_options"
    t.boolean  "schema_ps",          precision: 1,  scale: 0
    t.boolean  "schema_rq",          precision: 1,  scale: 0
    t.text     "schema_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_inputs", ["form_id"], name: "index_form_inputs_on_form_id"

  create_table "form_tags", force: true do |t|
    t.integer  "form_id",     precision: 38, scale: 0
    t.integer  "location_id", precision: 38, scale: 0
    t.integer  "role_id",     precision: 38, scale: 0
    t.integer  "position_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "form_tags", ["form_id"], name: "index_form_tags_on_form_id"

  create_table "form_translations", force: true do |t|
    t.string   "translate_key"
    t.string   "match_column"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "form_type"
    t.string   "form_name"
    t.boolean  "display",      precision: 1,  scale: 0, default: true,   null: false
    t.integer  "rank",         precision: 38, scale: 0, default: 999999, null: false
    t.text     "html"
    t.text     "schema"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms", ["procedure_id"], name: "index_forms_on_procedure_id"

  create_table "interview_evaluate_forms", force: true do |t|
    t.integer  "interview_evaluate_id", precision: 38, scale: 0
    t.text     "schema"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interview_evaluate_forms", ["interview_evaluate_id"], name: "i_int_eva_for_int_eva_id"

  create_table "interview_evaluates", force: true do |t|
    t.integer  "form_id",                   precision: 38, scale: 0
    t.integer  "interviewee_user_id",       precision: 38, scale: 0
    t.integer  "interview_id",              precision: 38, scale: 0
    t.integer  "judge_interviewer_user_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interview_evaluates", ["interview_id", "interviewee_user_id", "judge_interviewer_user_id"], name: "i3c6f6226060fcf40facd298b479be"
  add_index "interview_evaluates", ["interviewee_user_id", "interview_id", "judge_interviewer_user_id"], name: "ib5996f20ad06a24a4d46c53a3a2f2"
  add_index "interview_evaluates", ["judge_interviewer_user_id"], name: "i_int_eva_jud_int_use_id"

  create_table "interviewees", force: true do |t|
    t.integer  "user_id",      precision: 38, scale: 0
    t.integer  "time_slot_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviewees", ["time_slot_id", "user_id"], name: "i_int_tim_slo_id_use_id", unique: true
  add_index "interviewees", ["user_id", "time_slot_id"], name: "i_int_use_id_tim_slo_id", unique: true

  create_table "interviewers", force: true do |t|
    t.integer  "user_id",        precision: 38, scale: 0
    t.integer  "interview_id",   precision: 38, scale: 0
    t.boolean  "is_by_sunet_id", precision: 1,  scale: 0, default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interviewers", ["interview_id", "user_id"], name: "i_int_int_id_use_id", unique: true
  add_index "interviewers", ["user_id", "interview_id"], name: "i_int_use_id_int_id", unique: true

  create_table "interviews", force: true do |t|
    t.integer  "vacancy",                       precision: 38, scale: 0
    t.integer  "round_id",                      precision: 38, scale: 0
    t.boolean  "one_time_slot_per_applicant",   precision: 1,  scale: 0
    t.boolean  "interviewer_can_edit",          precision: 1,  scale: 0
    t.boolean  "interviewer_can_schedule",      precision: 1,  scale: 0
    t.integer  "interviewer_vacancy",           precision: 38, scale: 0
    t.integer  "max_time_slot_per_interviewer", precision: 38, scale: 0
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "schedule_due_time"
  end

  add_index "interviews", ["round_id"], name: "index_interviews_on_round_id"

  create_table "invites", force: true do |t|
    t.integer  "interview_id",    precision: 38, scale: 0
    t.integer  "invitee_user_id", precision: 38, scale: 0
    t.integer  "inviter_user_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["interview_id", "invitee_user_id"], name: "i_inv_int_id_inv_use_id", unique: true
  add_index "invites", ["invitee_user_id", "interview_id"], name: "i_inv_inv_use_id_int_id", unique: true
  add_index "invites", ["inviter_user_id"], name: "i_invites_inviter_user_id"

  create_table "limit_managers", force: true do |t|
    t.integer  "limit_period_id", precision: 38, scale: 0
    t.integer  "role_id",         precision: 38, scale: 0
    t.integer  "location_id",     precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "limit_managers", ["limit_period_id"], name: "i_lim_man_lim_per_id"

  create_table "limit_periods", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.datetime "t_start"
    t.datetime "t_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "limit_periods", ["procedure_id"], name: "i_limit_periods_procedure_id"

  create_table "location_mgrs", force: true do |t|
    t.integer  "location_id", precision: 38, scale: 0
    t.integer  "user_id",     precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "location_mgrs", ["location_id", "user_id"], name: "i_loc_mgr_loc_id_use_id", unique: true
  add_index "location_mgrs", ["user_id", "location_id"], name: "i_loc_mgr_use_id_loc_id", unique: true

  create_table "locations", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "name"
    t.string   "tag"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["procedure_id"], name: "i_locations_procedure_id"

  create_table "peoplesoft_details", force: true do |t|
    t.integer  "user_id",            precision: 38, scale: 0
    t.text     "academics"
    t.text     "addresses"
    t.text     "phones"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "academic_standings"
  end

  add_index "peoplesoft_details", ["user_id"], name: "i_peoplesoft_details_user_id", unique: true

  create_table "positions", force: true do |t|
    t.integer  "role_id",       precision: 38, scale: 0
    t.integer  "procedure_id",  precision: 38, scale: 0
    t.integer  "location_id",   precision: 38, scale: 0
    t.integer  "vacancy",       precision: 38, scale: 0
    t.boolean  "auto_matching", precision: 1,  scale: 0, default: true,  null: false
    t.string   "tag"
    t.string   "description"
    t.boolean  "one_year_up",   precision: 1,  scale: 0, default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "positions", ["location_id"], name: "index_positions_on_location_id"
  add_index "positions", ["procedure_id"], name: "i_positions_procedure_id"
  add_index "positions", ["role_id"], name: "index_positions_on_role_id"

  create_table "positions_in_interviews", force: true do |t|
    t.integer  "position_id",  precision: 38, scale: 0
    t.integer  "interview_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions_in_interviews", ["interview_id", "position_id"], name: "i_pos_in_int_int_id_pos_id", unique: true
  add_index "positions_in_interviews", ["position_id", "interview_id"], name: "i_pos_in_int_pos_id_int_id", unique: true

  create_table "procedure_help_landings", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "doings"
    t.string   "department"
    t.string   "contact"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedure_help_landings", ["procedure_id"], name: "i_pro_hel_lan_pro_id"

  create_table "procedure_landings", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "step_name"
    t.text     "landing",                               default: "About this process info.", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedure_landings", ["procedure_id"], name: "i_pro_lan_pro_id"

  create_table "procedure_mgrs", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.integer  "user_id",      precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedure_mgrs", ["procedure_id", "user_id"], name: "i_pro_mgr_pro_id_use_id", unique: true
  add_index "procedure_mgrs", ["user_id", "procedure_id"], name: "i_pro_mgr_use_id_pro_id", unique: true

  create_table "procedure_steps", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "url_acronym"
    t.integer  "rank",         precision: 38, scale: 0
    t.boolean  "enabled",      precision: 1,  scale: 0, default: true, null: false
    t.boolean  "user_view",    precision: 1,  scale: 0, default: true, null: false
    t.string   "name"
    t.datetime "t_start"
    t.datetime "t_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "procedure_steps", ["procedure_id"], name: "i_procedure_steps_procedure_id"

  create_table "procedure_sub_steps", force: true do |t|
    t.integer  "procedure_step_id", precision: 38, scale: 0
    t.string   "url_acronym"
    t.integer  "rank",              precision: 38, scale: 0
    t.boolean  "enabled",           precision: 1,  scale: 0, default: true, null: false
    t.boolean  "user_view",         precision: 1,  scale: 0, default: true, null: false
    t.string   "name"
    t.string   "identify_name"
    t.datetime "t_start"
    t.datetime "t_end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "lm_see",            precision: 1,  scale: 0, default: true
  end

  add_index "procedure_sub_steps", ["procedure_step_id", "identify_name"], name: "i5ea09e621885b5f36de641bf5e08a", unique: true

  create_table "procedures", force: true do |t|
    t.integer  "year_id",               precision: 38, scale: 0
    t.integer  "rank",                  precision: 38, scale: 0
    t.integer  "select_position_limit", precision: 38, scale: 0, default: 0, null: false
    t.boolean  "status",                precision: 1,  scale: 0
    t.string   "name"
    t.string   "acronym",                                                    null: false
    t.string   "link"
    t.string   "contact_email"
    t.datetime "lower_mgr_see_time"
    t.datetime "see_end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "domain"
    t.string   "faq_url"
  end

  add_index "procedures", ["year_id"], name: "index_procedures_on_year_id"

  create_table "rd_mgrs", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.integer  "user_id",      precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rd_mgrs", ["procedure_id", "user_id"], name: "i_rd_mgrs_procedure_id_user_id", unique: true
  add_index "rd_mgrs", ["user_id", "procedure_id"], name: "i_rd_mgrs_user_id_procedure_id", unique: true

  create_table "rd_records", force: true do |t|
    t.integer  "user_id",               precision: 38, scale: 0
    t.string   "case_id"
    t.string   "primary_student_id"
    t.string   "primary_student_name"
    t.string   "case_type"
    t.string   "created_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "involved_student_id"
    t.text     "involved_student_name"
  end

  add_index "rd_records", ["user_id"], name: "index_rd_records_on_user_id"

  create_table "recommendation_forms", force: true do |t|
    t.integer  "recommendation_record_id", precision: 38, scale: 0
    t.string   "form_name"
    t.text     "schema"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recommender_sunet_id"
  end

  add_index "recommendation_forms", ["recommendation_record_id"], name: "i_rec_for_rec_rec_id"

  create_table "recommendation_records", force: true do |t|
    t.integer  "user_id",                   precision: 38, scale: 0
    t.integer  "procedure_id",              precision: 38, scale: 0
    t.integer  "recommendation_form_id",    precision: 38, scale: 0
    t.string   "name"
    t.string   "title"
    t.string   "relationship"
    t.string   "email"
    t.boolean  "show_for_std_interviewers", precision: 1,  scale: 0, default: false
    t.boolean  "disabled",                  precision: 1,  scale: 0, default: false
    t.datetime "submit_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "recommendation_records", ["procedure_id", "user_id"], name: "i_rec_rec_pro_id_use_id"
  add_index "recommendation_records", ["user_id", "procedure_id"], name: "i_rec_rec_use_id_pro_id"

  create_table "recommendation_settings", force: true do |t|
    t.integer  "procedure_id",        precision: 38, scale: 0
    t.integer  "number",              precision: 38, scale: 0
    t.boolean  "show_recommendation", precision: 1,  scale: 0, default: false
    t.text     "requirement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recommendation_settings", ["procedure_id"], name: "i_rec_set_pro_id"

  create_table "role_mgrs", force: true do |t|
    t.integer  "role_id",    precision: 38, scale: 0
    t.integer  "user_id",    precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_mgrs", ["role_id", "user_id"], name: "i_role_mgrs_role_id_user_id", unique: true
  add_index "role_mgrs", ["user_id", "role_id"], name: "i_role_mgrs_user_id_role_id", unique: true

  create_table "roles", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "name"
    t.string   "tag"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["procedure_id"], name: "index_roles_on_procedure_id"

  create_table "round_tags", force: true do |t|
    t.integer  "round_id",    precision: 38, scale: 0
    t.integer  "location_id", precision: 38, scale: 0
    t.integer  "role_id",     precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "round_tags", ["round_id", "location_id", "role_id"], name: "i_rou_tag_rou_id_loc_id_rol_id", unique: true

  create_table "rounds", force: true do |t|
    t.integer  "procedure_id", precision: 38, scale: 0
    t.string   "title"
    t.boolean  "erasable",     precision: 1,  scale: 0, default: true
    t.datetime "t_start"
    t.datetime "t_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rounds", ["procedure_id"], name: "index_rounds_on_procedure_id"

  create_table "system_messages", force: true do |t|
    t.integer  "procedure_id",  precision: 38, scale: 0
    t.string   "name"
    t.string   "identify_name"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "system_messages", ["identify_name", "procedure_id"], name: "i_sys_mes_ide_nam_pro_id", unique: true
  add_index "system_messages", ["procedure_id", "identify_name"], name: "i_sys_mes_pro_id_ide_nam", unique: true

  create_table "time_slot_interviewers", force: true do |t|
    t.integer  "interviewer_id", precision: 38, scale: 0
    t.integer  "time_slot_id",   precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_slot_interviewers", ["interviewer_id", "time_slot_id"], name: "ie6307d5988570c9515b7a0d13ca06", unique: true
  add_index "time_slot_interviewers", ["time_slot_id", "interviewer_id"], name: "i4b6373ae2e7bc1ff7c9cf529de816", unique: true

  create_table "time_slots", force: true do |t|
    t.integer  "interview_id", precision: 38, scale: 0
    t.string   "place"
    t.datetime "t_start"
    t.datetime "t_end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "time_slots", ["interview_id"], name: "i_time_slots_interview_id"

  create_table "transcripts", force: true do |t|
    t.integer  "user_id",    precision: 38, scale: 0
    t.string   "term"
    t.string   "level"
    t.string   "subject"
    t.string   "no"
    t.string   "title"
    t.string   "grade"
    t.integer  "unit",       precision: 38, scale: 0
    t.string   "credit"
    t.string   "gpa"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transcripts", ["user_id"], name: "index_transcripts_on_user_id"

  create_table "upload_files", force: true do |t|
    t.integer  "user_form_id",               precision: 38, scale: 0
    t.integer  "recommendation_form_id",     precision: 38, scale: 0
    t.integer  "interview_evaluate_form_id", precision: 38, scale: 0
    t.string   "file_name"
    t.text     "original_filename"
    t.string   "file_path"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "upload_files", ["deleted_at"], name: "i_upload_files_deleted_at"
  add_index "upload_files", ["user_form_id"], name: "i_upload_files_user_form_id"

  create_table "user_forms", force: true do |t|
    t.integer  "form_id",      precision: 38, scale: 0
    t.integer  "user_id",      precision: 38, scale: 0
    t.integer  "procedure_id", precision: 38, scale: 0
    t.datetime "submit_date"
    t.string   "form_name"
    t.text     "schema"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_forms", ["form_id"], name: "index_user_forms_on_form_id"
  add_index "user_forms", ["user_id", "procedure_id"], name: "i_use_for_use_id_pro_id"

  create_table "user_procedures", force: true do |t|
    t.integer  "user_id",      precision: 38, scale: 0
    t.integer  "procedure_id", precision: 38, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_procedures", ["procedure_id", "user_id"], name: "i_use_pro_pro_id_use_id", unique: true
  add_index "user_procedures", ["user_id", "procedure_id"], name: "i_use_pro_use_id_pro_id", unique: true

  create_table "users", force: true do |t|
    t.integer  "year_id",                           precision: 38, scale: 0
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "status"
    t.boolean  "is_admin",                          precision: 1,  scale: 0, default: false, null: false
    t.boolean  "is_get_people_soft",                precision: 1,  scale: 0, default: false, null: false
    t.string   "suid",                    limit: 9
    t.string   "email"
    t.string   "sunet_id"
    t.string   "gender"
    t.decimal  "academic_year_remaining",                                    default: 0.0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_transcript_date"
    t.string   "preferred_name"
  end

  add_index "users", ["suid"], name: "index_users_on_suid"
  add_index "users", ["sunet_id", "year_id"], name: "i_users_sunet_id_year_id", unique: true
  add_index "users", ["year_id", "sunet_id"], name: "i_users_year_id_sunet_id", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",                           null: false
    t.integer  "item_id",    precision: 38, scale: 0, null: false
    t.string   "event",                               null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "i_versions_item_type_item_id"

  create_table "years", force: true do |t|
    t.string   "name"
    t.boolean  "is_current_year", precision: 1, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "next_year"
  end

end
