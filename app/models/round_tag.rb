class RoundTag < ActiveRecord::Base
  has_paper_trail

  belongs_to :round;
  belongs_to :location;
  belongs_to :role;


  def self.set_all_round_has_all_location_and_role_per_procedure
    procedures = Procedure.all;

    procedures.each do |procedure|
      i_procedure_id = procedure.id.to_i;

      roles = Role.where(:procedure_id => i_procedure_id);
      locations = Location.where(:procedure_id => i_procedure_id);
      rounds = Round.where(:procedure_id => i_procedure_id);

      rounds.each do |round|
        i_round_id = round.id;

        locations.each do |location|
          i_location_id = location.id.to_i;

          round_tag = RoundTag.where(:round_id => i_round_id)
                              .where(:location_id => i_location_id);

          if (round_tag.blank?)
            RoundTag.create(
              :round_id => i_round_id,
              :location_id => i_location_id
            );
          end
        end

        roles.each do |role|
          i_role_id = role.id.to_i;

          round_tag = RoundTag.where(:round_id => i_round_id)
                              .where(:role_id => i_role_id);

          if (round_tag.blank?)
            RoundTag.create(
              :round_id => i_round_id,
              :role_id => i_role_id
            );
          end
        end
      end
    end

    return nil;
  end
end
