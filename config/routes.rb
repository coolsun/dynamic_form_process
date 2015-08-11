Rails.application.routes.draw do

  resources :import do
    collection do
      post :import_mgrs_by_xlsx
      post :import_pre_offered_applicants_by_xlsx
    end
  end

  resources :db_data do
    collection do
      get :insert_ranking_explanation
      #get :insert_post_match_position_notification
      #get :update_application_disqualify_to_wait
      #get :insert_offer_status
      #get :insert_ranked_at
      #get :update_position_name
      #get :insert_pre_location_mgrs_20150114
      #get :insert_location_mgrs_20150113
      #get :insert_location_mgrs_20141215
      #get :create_500_applicants
      #get :update_500_applicants
      #get :delete_500_applicants
    end
  end

  resources :application do
    collection do
      get :test
    end
  end

  resources :test do
    collection do
      get :test_suntid
      get :test_email
      get :test_get_match_data
    end
  end

  resource :interviewees do
    collection do
      delete '/:time_slot_id' => 'interviewees#destroy'
    end
  end

  resources :interviews do
    collection do
      get :admin_get_interviews
      get :admin_get_my_interviews
      get :admin_calendar_view
      get :get_round_admin_selected_interviews
      get :user_get_interviews
      get :user_process_calendar_view
      get :get_procedure_positions
      get :get_procedure_rounds
      get :get_procedure_round_interviews
      get :get_interviewers
      get :get_round_interviews
      get :get_one_round
      get :get_applicant_list
      get :get_interview_applicant_list
      get :get_interview_scheduled_applicants
      get :get_interview_selected_applicants
      post :set_positions
      post :set_interviewers
      post :set_invitees
      post :set_time_slots
      post :user_reserve_time_slot
      post :user_cancel_time_slot
      post :send_email_to_applicants
      post :send_email_to_interviewers
      post :get_positions
    end
  end

  resources :files do
    collection do
      post :upload
      post :form_file_list
      post :download_forms_files
    end
  end

  resources :forms do
    collection do
      post :show_process_forms
      post :save_new_form
      post :edit_old_form
      post :delete_form
      post :toggle_show
      get  :get_application_form_list
      post :update_form_rank
      post :clone_form
    end
  end

  resources :procedures do
    collection do
      post :show_all_procedure
      post :clone_process
      get  :clone_all_process
      post :check_recommendation_form_open
      post :get_locations_and_roles
      get  :mgr_procedures_select
    end
  end

  resources :procedure_steps do
    collection do
      #post :show_procedure_steps
      post :show_manager_procedure_steps
      get :show_manager_procedure_steps
      post :show_applicant_procedure_steps
      post :applicant_status
      get  :get_step_landing
      post :update_step_landing
    end
  end

  resources :procedure_sub_steps do
    collection do
      post :update_sub_steps_time
    end
  end

  resources :user_forms do
    collection do
      post :show_user_filled_forms
      post :delete_user_forms
      post  :applicant_forms
      get  :form_translations
    end
  end

  resources :interview_evaluates do
    collection do
      post :show_evaluate_forms
      post :show_review_forms
    end
  end

  resources :users do
    collection do
      get :remove_user
      get :get_user_authority
      get :get_user_all
      get :logout
      get :check_user_manager
    end
  end

  resources :user_procedures do
    collection do
      get :get_select_list
      post :update_user_procedures
    end
  end

  resources :locations do
    collection do
    end
  end

  resources :roles do
    collection do
    end
  end

  resources :positions do
    collection do
      get  :get_select_lists
      post :invitation_create_position
    end
  end

  resources :applications do
    collection do
      get  :get_select_position_list
      post :update_positions_select
      get  :get_select_position_settings
      post :update_select_position_settings
      post :manual_positions_list
      post :manual_update_positions
    end
  end

  resources :applicants do
    collection do
      post :applicant_list
      post :submit_application
      post :set_lower_mgr_time
      post :applicant_disqualify
      post :send_email_to_applicants
      get  :get_user_authority
      post :force_submit
      post :download_answer_xls_file
    end
  end

  resources :applicant_tags do
    collection do
      get  :get_applicant_tags
      post :update_applicant_tags
    end
  end

  resources :email_templates do
    collection do
      post :use_it
    end
  end

  resources :recommendation_records do
    collection do
      post :send_reminder_email
    end
  end

  resources :recommendation_settings do
    collection do
      post :get_setting
    end
  end

  resources :recommendation_forms do
    collection do
      post :fill_recommendation_form
      get :redir
    end
  end

  resources :location_mgrs do
    collection do
      get :get_select_list
      post :update_location_mgrs
    end
  end

  resources :procedure_mgrs do
    collection do
      get :get_select_list
      post :update_procedure_mgrs
    end
  end

  resources :rd_mgrs do
    collection do
      get :get_select_list
      post :update_rd_mgrs
    end
  end

  resources :apply_white_lists do
    collection do
    end
  end

  resources :role_mgrs do
    collection do
      get :get_select_list
      post :update_role_mgrs
    end
  end

  resources :position_interview_mgrs do
    collection do
      get :get_select_list
      post :update_position_interview_mgrs
    end
  end

  resources :ranking do
    collection do
      get  :get_user_rank_list
      post :update_user_rank
      get  :get_mgr_rank_list
      post :update_mgr_rank
    end
  end

  resources :matching do
    collection do
      post :match
      get :get_match_data
    end
  end

  resources :offer do
    collection do
      post :offer_list
      post :pre_offer_applicants
      post :pre_offer_all
      get  :user_offer_list
      get  :offer_all_list
      get  :position_pre_offered_list
      get  :offer_mail_template
      post :send_offered_email
      post :offer_confirm
      post :quick_send_offer_list
      post :quick_send_offer
      get  :get_offered_response_applicants
      post :update_offered_response
    end
  end

  resources :post_offer do
    collection do
      get  :invitation_list
      get  :post_offer_mail_template
      post :send_invite_email
    end
  end

  resources :mail do
    collection do
      post :user_mail_list
      post :send_mail
    end
  end

  resources :rounds do
    collection do
    end
  end

  resources :time_slots do
    collection do
      #get :admin_get_time_slots
      get :get_interviewers
      get :get_applicant_list
      post :set_interviewers
      post :set_interviewees
    end
  end

  resources :download_pdfs do
    collection do
      get  :test_new_pdf
      post :down_load_applicants_forms
      #post :download_interview_review_pdf
      get  :pdf_form
      post :pdf_form
      post :interview_scheduled_applicants_pdf
      post :interview_scheduled_applicant_list_pdf
      #get :interview_scheduled_applicant_list_pdf
      post :review_pdf
      #get :review_pdf
    end
  end

  resources :years do
    collection do
      get  :get_year_list
      get  :set_current_year
      get  :admin_switch_year
      post :check_url_year_and_procedure
      get  :set_return_url
    end
  end

  resources :rd_flags do
    collection do
      post :get_involved_student
    end
  end

  resources :time_slot_interviewers do
    collection do
    end
  end

  resources :transcripts do
    collection do
      get   :create123
      get   :applicant_transcripts
    end
  end

  resources :system_messages do
    collection do
    end
  end

  resources :batch_jobs do
    collection do
      get :delete_version
      get :translate_form_schema
      get :delete_zip_files
      get :clear_garbage
      get :get_applicant_user_rd_records
      get :get_applicant_user_rd_records_ver0
    end
  end

  resources :procedure_help_landings

  resources :reports do
    collection do
      post :applicant_list_report
      post :academic_record_report
      post :ranking_report
      post :offered_unoffered_report
      post :manager_ranking_report
    end
  end

  resources :limit_periods

  resources :saas do
    collection do
      get :repair_running_email_template
      post :send_question
    end
  end

  resources :permission do
    collection do
      get  :get_permission_list
      get  :insert_substep_roles_and_permissions
      post :update_permissions
    end
  end


  get '/trans_url/:url', :to => "transfers#trans_url_b64_param"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  #root 'application#index'

  get '/saas/', :to => redirect('/saas/index.html')
  get '/saas', :to => redirect('/saas/index.html')

  get 'saas/', :to => redirect('/saas/index.html')
  get 'saas', :to => redirect('/saas/index.html')
  get '/', :to => redirect('/saas/index.html')
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     applicant do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
