class Invite < ActiveRecord::Base
  has_paper_trail

  belongs_to :user
  belongs_to :invitee, class_name: "User", foreign_key: "invitee_user_id";
  belongs_to :inviter, class_name: "User", foreign_key: "inviter_user_id";
  belongs_to :interview;


  def self.new_invite(i_interview_id, i_invitee_id, i_inviter_id)
    invite = Invite.new(
      :interview_id => i_interview_id,
      :invitee_user_id => i_invitee_id,
      :inviter_user_id => i_inviter_id
    );
    invite.save();
    return (invite);
  end



  def self.remove_applicant_procedure_invites(i_user_id, i_procedure_id)
    invites = Invite.joins(:interview => [:round])
                    .where(:invitee_user_id => i_user_id)
                    .where(:rounds => {:procedure_id => i_procedure_id});

    logger.info("invites : #{invites.to_json}")

    invites.delete_all;
  end

end
