class OracleCreateTablesFirst < ActiveRecord::Migration
  def up

    #######################################################################################
    create_table :interviewees do |t|
      t.integer :user_id
      t.integer :time_slot_id
      #t.integer :attend
      t.timestamps
    end
    add_index :interviewees, [:time_slot_id, :user_id], :unique => true
    add_index :interviewees, [:user_id, :time_slot_id], :unique => true

    #######################################################################################
    create_table :interviewers do |t|
      t.integer :user_id
      t.integer :interview_id
      t.boolean :is_by_sunet_id, :default => false
      t.timestamps
    end
    add_index :interviewers, [:interview_id, :user_id], :unique => true
    add_index :interviewers, [:user_id, :interview_id], :unique => true

    #######################################################################################
    create_table :interviews do |t|
      t.integer :vacancy  # Applicant vacancy per time slot
      t.integer :round_id
      t.boolean :one_time_slot_per_applicant      # Maximum number of time slots per applicant is always one.
      t.boolean :interviewer_can_edit          # setting : allow interviewer to edit time slot
      t.boolean :interviewer_can_schedule      # setting : can schedule interviewer
      t.integer :interviewer_vacancy           # follow field: interviewer_can_schedule
      t.integer :max_time_slot_per_interviewer # Maximum number of time slots per interviewer
      t.string :name
      t.timestamps
    end

    #######################################################################################
    create_table :role_mgrs do |t|
      t.integer :role_id
      t.integer :user_id
      t.timestamps
    end
    add_index :role_mgrs, [:role_id, :user_id], :unique => true
    add_index :role_mgrs, [:user_id, :role_id], :unique => true


    #######################################################################################
    create_table :roles do |t|
      t.integer :procedure_id
      t.string :name
      t.string :tag
      t.string :description
      t.timestamps
    end
    add_index :roles, :procedure_id


    #######################################################################################
    create_table :positions do |t|
      t.integer :role_id
      t.integer :procedure_id
      t.integer :location_id
      t.integer :vacancy
      t.boolean :auto_matching, :default => true, :null => false
      t.string  :tag
      t.string  :description
      t.boolean :one_year_up, :default => false, :null => false
      t.timestamps
    end
    add_index :positions, :role_id
    add_index :positions, :procedure_id
    add_index :positions, :location_id


    #######################################################################################
    create_table :location_mgrs do |t|
      t.integer :location_id
      t.integer :user_id
      t.timestamps
    end
    add_index :location_mgrs, [:location_id, :user_id], :unique => true
    add_index :location_mgrs, [:user_id, :location_id], :unique => true


    #######################################################################################
    create_table :locations do |t|
      t.integer :procedure_id
      t.string :name
      t.string :tag
      t.string :description
      t.timestamps
    end
    add_index :locations, :procedure_id


    #######################################################################################
    create_table :applications do |t|
      t.integer :user_id
      t.integer :position_id
      t.integer :user_rank, :default => 999999, :null => false
      t.integer :mgr_rank, :default => 999999, :null => false
      t.string  :offered
      t.boolean :auto_match
      t.string  :offer_accept
      t.integer :rd_flag
      t.timestamps
    end
    add_index :applications, [:position_id, :user_id], :unique => true
    add_index :applications, [:user_id, :position_id], :unique => true


    #######################################################################################
    create_table :procedure_mgrs do |t|
      t.integer :procedure_id
      t.integer :user_id
      t.timestamps
    end
    add_index :procedure_mgrs, [:procedure_id, :user_id], :unique => true
    add_index :procedure_mgrs, [:user_id, :procedure_id], :unique => true


    #######################################################################################
    create_table :rd_mgrs do |t|
      t.integer :procedure_id
      t.integer :user_id
      t.timestamps
    end
    add_index :rd_mgrs, [:procedure_id, :user_id], :unique => true
    add_index :rd_mgrs, [:user_id, :procedure_id], :unique => true


    #######################################################################################
    create_table :procedures do |t|
      t.integer   :year_id
      t.integer   :rank
      t.integer   :select_position_limit, :default => 0, :null => false
      t.boolean   :status
      t.string    :name
      t.string    :acronym, :null => false
      t.string    :link
      t.string    :contact_email
      t.datetime  :lower_mgr_see_time
      t.datetime  :see_end_time
      t.timestamps
    end
    add_index :procedures, :year_id

    #######################################################################################
    create_table :procedure_landings do |t|
      t.integer   :procedure_id
      t.string    :step_name
      t.text      :landing, :default => "About this process info.", :null => false
      t.timestamps
    end
    add_index :procedure_landings, :procedure_id

    #######################################################################################
    create_table :procedure_help_landings do |t|
      t.integer   :procedure_id
      t.string    :doings
      t.string    :department
      t.string    :contact
      t.timestamps
    end
    add_index :procedure_help_landings, :procedure_id

    #######################################################################################
    create_table :procedure_steps do |t|
      t.integer   :procedure_id
      t.string    :url_acronym
      t.integer   :rank
      t.boolean   :enabled, :default => true, :null => false
      t.boolean   :user_view, :default => true, :null => false
      t.string    :name
      t.datetime  :t_start
      t.datetime  :t_end
      t.timestamps
    end
    add_index :procedure_steps, :procedure_id


    #######################################################################################
    create_table :procedure_sub_steps do |t|
      t.integer   :procedure_step_id
      t.string    :url_acronym
      t.integer   :rank
      t.boolean   :enabled, :default => true, :null => false
      t.boolean   :user_view, :default => true, :null => false
      t.string    :name
      t.string    :identify_name
      t.datetime  :t_start
      t.datetime  :t_end
      t.timestamps
    end
    # add_index :procedure_sub_steps, :procedure_step_id
    add_index :procedure_sub_steps, [:procedure_step_id, :identify_name], :unique => true


    #######################################################################################
    create_table :recommendation_records do |t|
      t.integer :user_id
      t.integer :procedure_id
      t.integer :recommendation_form_id
      t.string :name
      t.string :title
      t.string :relationship
      t.string :email
      t.boolean :show_for_std_interviewers, :default => false
      t.boolean :disabled, :default => false
      t.datetime :submit_date
      t.timestamps
    end
    add_index :recommendation_records, [:user_id, :procedure_id]
    add_index :recommendation_records, [:procedure_id, :user_id]


    #######################################################################################
    create_table :recommendation_settings do |t|
      t.integer :procedure_id
      t.integer :number
      t.boolean :show_recommendation, :default => false
      t.text    :requirement
      t.timestamps
    end
    add_index :recommendation_settings, :procedure_id


    #######################################################################################

    create_table :recommendation_forms do |t|
      t.integer :recommendation_record_id
      t.string  :form_name
      t.text    :schema
      t.timestamps
    end
    add_index :recommendation_forms, :recommendation_record_id

    #######################################################################################
    create_table :users do |t|
      t.integer :year_id
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.string  :status
      t.boolean :is_admin, :default => false, :null => false
      t.boolean :is_get_people_soft, :default => false, :null => false

      ## http://saisappdev96.stanford.edu/saservice2/v2.0/students/ewoodson/profile.json?appId=22222-111&requesterId=bsun2  ##
      ## http://saisappdev96.stanford.edu/saservice2/v2.0/students/ewoodson/profile.json?c=22222-111&requesterId=bsun2  ##
      ## fisrt_name middle_name last_name also at reponse
      t.string :suid, :limit => 9
      t.string :email
      t.string :sunet_id
      t.string :gender
      t.float  :academic_year_remaining, :default => 0, :null => false
      # change to peoplesoft_details
      #t.text :academics
      #t.text :addresses
      #t.text :phones
      t.timestamps
    end
    add_index :users, :suid
    add_index :users, [:sunet_id, :year_id], :unique => true
    add_index :users, [:year_id, :sunet_id], :unique => true

    #######################################################################################
    create_table :user_procedures do |t|
      t.integer :user_id
      t.integer :procedure_id
      t.timestamps
    end
    add_index :user_procedures, [:user_id, :procedure_id], :unique => true
    add_index :user_procedures, [:procedure_id, :user_id], :unique => true

    #######################################################################################
    create_table :peoplesoft_details do |t|
      t.integer :user_id
      t.text :academics
      t.text :addresses
      t.text :phones
      t.timestamps
    end
    add_index :peoplesoft_details, :user_id, :unique => true

    #######################################################################################
    create_table :forms do |t|
      t.integer  :procedure_id
      t.string   :form_type
      t.string   :form_name
      t.boolean  :display, :default => true, :null => false
      t.integer  :rank, :default => 999999, :null => false
      t.text     :html
      t.text     :schema
      t.timestamps
    end
    add_index :forms, :procedure_id

    #######################################################################################
    create_table :form_tags do |t|
      t.integer  :form_id
      t.integer  :location_id
      t.integer  :role_id
      t.integer  :position_id
      t.timestamps
    end
    add_index :form_tags, :form_id

    #######################################################################################
    create_table :form_translations do |t|
      t.string   :translate_key
      t.string   :match_column
      t.string   :description
      t.timestamps
    end

    #######################################################################################
    create_table :user_forms do |t|
      t.integer  :form_id
      t.integer  :user_id
      t.integer  :procedure_id
      t.datetime :submit_date
      t.string   :form_name
      t.text     :schema
      t.timestamps
    end
    add_index :user_forms, :form_id
    add_index :user_forms, [:user_id, :procedure_id]

    ######################################################################################
    create_table :email_templates do |t|
      t.string   :title
      t.text     :content
      t.string   :email_type
      t.integer  :procedure_id
      t.timestamps
    end

    #######################################################################################
    create_table :applicants do |t|
      t.integer :user_id
      t.integer :procedure_id
      t.datetime :application_submit_at
      t.string :rd_flag_color, :default => "green"
      t.boolean :disqualify, :default => false, :null => false
      t.timestamps
    end
    add_index :applicants, [:procedure_id, :user_id], :unique => true
    add_index :applicants, [:user_id, :procedure_id], :unique => true

    #######################################################################################
    create_table :applicant_tags do |t|
      t.integer :applicant_id
      t.string :name
      t.timestamps
    end
    add_index :applicant_tags, :applicant_id

    #######################################################################################
    create_table :upload_files do |t|
      t.integer   :user_form_id
      t.integer   :recommendation_form_id
      t.integer   :interview_evaluate_form_id
      t.string    :file_name
      t.text      :original_filename
      t.string    :file_path
      t.datetime  :deleted_at
      t.timestamps
    end
    add_index :upload_files, :user_form_id
    add_index :upload_files, :deleted_at

    #######################################################################################
    create_table :rounds do |t|
      t.integer :procedure_id
      t.string :title
      t.boolean :erasable, :default => true
      t.datetime :t_start
      t.datetime :t_end
      t.timestamps
    end
    add_index :rounds, :procedure_id

    #######################################################################################
    create_table :positions_in_interviews do |t|
      t.integer :position_id
      t.integer :interview_id
      t.timestamps
    end
    add_index :positions_in_interviews, [:interview_id, :position_id], :unique => true
    add_index :positions_in_interviews, [:position_id, :interview_id], :unique => true

    #######################################################################################
    create_table :time_slot_interviewers do |t|
      t.integer :interviewer_id
      t.integer :time_slot_id
      t.timestamps
    end
    add_index :time_slot_interviewers, [:interviewer_id, :time_slot_id], :unique => true
    add_index :time_slot_interviewers, [:time_slot_id, :interviewer_id], :unique => true

    #######################################################################################
    create_table :invites do |t|    # need modify
      t.integer :interview_id
      t.integer :invitee_user_id
      t.integer :inviter_user_id
      t.timestamps
    end
    add_index :invites, [:invitee_user_id, :interview_id], :unique => true
    add_index :invites, [:interview_id, :invitee_user_id], :unique => true
    add_index :invites, :inviter_user_id

    #######################################################################################
    create_table :time_slots do |t|
      t.integer :interview_id
      t.string :place
      t.datetime :t_start
      t.datetime :t_end
      t.timestamps
    end
    add_index :time_slots, :interview_id


    #######################################################################################
    create_table :interview_evaluates do |t|
      t.integer :form_id
      t.integer :interviewee_user_id
      t.integer :interview_id
      t.integer :judge_interviewer_user_id
      #t.integer :evaluate_value  # will change
      t.timestamps
    end
    add_index :interview_evaluates, [:interview_id, :interviewee_user_id, :judge_interviewer_user_id]
    add_index :interview_evaluates, [:interviewee_user_id, :interview_id, :judge_interviewer_user_id]
    add_index :interview_evaluates, [:judge_interviewer_user_id]

    #######################################################################################
    create_table :interview_evaluate_forms do |t|
      t.integer :interview_evaluate_id
      t.text :schema
      t.timestamps
    end
    add_index :interview_evaluate_forms, :interview_evaluate_id

    #######################################################################################
    create_table :years do |t|
      t.string  :name
      t.boolean :is_current_year
      t.float   :current_term
      t.timestamps
    end

    #######################################################################################
    create_table :transcripts do |t|
      t.integer   :user_id
      t.string    :term
      t.string    :level
      t.string    :subject
      t.string    :no
      t.string    :title
      t.string    :grade
      t.integer   :unit
      t.string    :credit
      t.string    :gpa
      t.timestamps
    end
    add_index :transcripts, :user_id

    #######################################################################################
    create_table :system_messages do |t|
      t.integer :procedure_id
      t.string  :name
      t.string  :identify_name
      t.text    :message
      t.timestamps
    end
    add_index :system_messages, [:procedure_id, :identify_name], :unique => true
    add_index :system_messages, [:identify_name, :procedure_id], :unique => true

    #######################################################################################
    create_table :form_inputs do |t|
      t.integer :form_id
      t.string  :form_table
      t.string  :form_type
      t.string  :form_name
      t.integer :schema_row
      t.integer :schema_column
      t.text    :schema_description
      t.string  :schema_type
      t.text    :schema_options
      t.boolean :schema_ps
      t.boolean :schema_rq
      t.text    :schema_value
      t.timestamps
    end
    #######################################################################################

    create_table :versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.datetime :created_at
    end
    add_index :versions, [:item_type, :item_id]
    #######################################################################################
  end

  def down
    drop_table :applicant_tags
    drop_table :applicants
    drop_table :applications
    drop_table :email_templates
    drop_table :form_inputs
    drop_table :form_tags
    drop_table :form_translations
    drop_table :forms
    drop_table :interview_evaluate_forms
    drop_table :interview_evaluates
    drop_table :interviewees
    drop_table :interviewers
    drop_table :interviews
    drop_table :invites
    drop_table :location_mgrs
    drop_table :locations
    drop_table :peoplesoft_details
    drop_table :positions
    drop_table :positions_in_interviews
    drop_table :procedure_help_landings
    drop_table :procedure_landings
    drop_table :procedure_mgrs
    drop_table :procedure_steps
    drop_table :procedure_sub_steps
    drop_table :procedures
    drop_table :rd_mgrs
    drop_table :recommendation_forms
    drop_table :recommendation_records
    drop_table :recommendation_settings
    drop_table :role_mgrs
    drop_table :roles
    drop_table :rounds
    drop_table :system_messages
    drop_table :time_slot_interviewers
    drop_table :time_slots
    drop_table :transcripts
    drop_table :upload_files
    drop_table :user_forms
    drop_table :user_procedures
    drop_table :users
    drop_table :versions
    drop_table :years
  end
end
