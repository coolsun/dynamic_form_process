class EmailTemplate < ActiveRecord::Base
  has_paper_trail

  def self.replace_keyworld(txt, procedure, positions, step, user, admin_emails = nil, applicant_user = nil)
    current_year = Year.where(:is_current_year => true).select(:name, :next_year).first
    txt = txt.gsub('[[CurrentYear]]', current_year.name)
    txt = txt.gsub('[[NextYear]]', current_year.next_year)
    if procedure
      txt = txt.gsub('[[ProcessName]]', procedure.name)
      txt = txt.gsub('[[ContactEmail]]', procedure.contact_email ? procedure.contact_email : "")
      txt = txt.gsub('[[HiringManagerName]]', procedure.get_all_hiring_mgr_name)
    end

    txt = txt.gsub('[[Positions]]', positions.collect{|position| position.name}.join(", ")) if positions
    txt = txt.gsub('[[Due Date]]', step.t_end.in_time_zone("Pacific Time (US & Canada)").strftime("%m/%d/%Y %H:%M")) if step
    if user
      if step && step.identify_name == "post_offer_invitations" && applicant_user
        txt = txt.gsub('[[ApplicantName]]', applicant_user.name)
      else
        txt = txt.gsub('[[ApplicantName]]', user.name)
      end
      txt = txt.gsub('[[FirstName]]', user.first_name)
    end
    txt = txt.gsub('[[AdminEmail]]', admin_emails.join(", ").strip) if admin_emails
    if step && step.identify_name == "post_offer_invitations"
      s_path = "saas/app/index.html#/" + Year.find_by_id(procedure.year_id).name + "/" + procedure.acronym + "/apply_now/post-match/invitation"
      if (Rails.env == "production")
        s_domain = (procedure['domain'].present?)? procedure['domain'].to_s : 'selection.stanford.edu';
        s_target_url = 'https://' + s_domain + '/' + s_path;
      else
        if STANFORD68
          s_domain = 'saisappdev68.stanford.edu';
          s_target_url = 'https://' + s_domain + '/' + s_path;
        else
          s_domain = '184.169.165.135:8010';
          s_target_url = 'http://' + s_domain + '/' + s_path;
        end
      end

      s_b64_target_url = Base64.urlsafe_encode64(s_target_url);
      s_url = 'http://' + s_domain + '/trans_url/' + s_b64_target_url;

      txt = txt.gsub('[[PostMatchURL]]', "<a href='"+ s_url + "'>Post Match Invitation" + "</a>")
      txt = txt.gsub('[[Interview]]', "Post Match Interview")
      txt = txt.gsub('[[AlreadySelectedPositions]]', Position.includes(:applications).where(:procedure_id => procedure.id, :applications => {:user_id => user.id}).pluck(:name).join(", "))
    end
    return txt
  end

end
