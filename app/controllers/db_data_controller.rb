class DbDataController < ApplicationController

  def create_email_template
    EmailTemplate.create(procedure_id: 0, email_type: "offer_confirm_notice_email", title: "Offer Confirmed Notice to [[ApplicantName]] for [[OfferPostion]]", content: "<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n<p><strong>Dear&nbsp;</strong><strong>[[ApplicantName]],</strong>&nbsp;<br /><br /> <br /> You have accepted the assignment of the following position. <br /> <br /> <strong>Process:</strong>&nbsp;[[ProcessName]]</p>\n<p><strong>Position:&nbsp;</strong>[[OfferPostion]]</p>\n<p>&nbsp;</p>\n<p>Welcome to the [[ProcessName]] Program. We're very excited to have you join our team, and look forward to be working with you .</p>\n<p>&nbsp;</p>\n<p>Sincerely Yours,</p>\n<p>Hiring Manager</p>\n<p>[[HiringManagerName]]</p>\n<p>Stanford University</p>\n</body>\n</html>")
    EmailTemplate.create(procedure_id: 0, email_type: "applicants_submit_ranked_list", title: "Ranked List Notice for Applicant", content: "<p><strong>Dear [[ApplicantName]],</strong><br />\n<br />\nYou have submitted a ranked list successfully.  Please see the attached copy of ranked list you have submitted.\n<p><br />Sincerely Yours,</p>\n<p><br />Hiring Manager</p>\n<p>[[HiringManagerName]]</p>\n<p>Stanford University</p>\n")
    EmailTemplate.create(procedure_id: 0, email_type: "location_managers_submit_ranked_list", title: "Ranked List Notice for Location Manager", content: "<strong>Dear [[LocationManagerName]],</strong><br>\n<br>\nDear [[LocationManagerName]],<br>\n<br>\nYou have submitted a ranked list successfully.  Please see the attached copy of ranked list you have submitted.<br>\n<br>\nSincerely Yours,<br>\n<br>\nHiring Manager<br>\n[[HiringManagerName]]<br>\nStanford University\n")
  end

  def insert_ranking_explanation
    SystemMessage.create(:procedure_id => 0, :name => "Rank Position-Applicant View", :identify_name => "rank_position_applicant_view", :message => "Rank by dragging")
    SystemMessage.create(:procedure_id => 0, :name => "Rank Position-Manager View", :identify_name => "rank_position_manager_view", :message => "Rank by dragging")
    Procedure.all.each do |procedure|
      SystemMessage.create(:procedure_id => procedure.id, :name => "Rank Position-Applicant View", :identify_name => "rank_position_applicant_view", :message => "Rank by dragging")
      SystemMessage.create(:procedure_id => procedure.id, :name => "Rank Position-Manager View", :identify_name => "rank_position_manager_view", :message => "Rank by dragging")
    end

    render :text => "Done"
  end

  def update_application_disqualify_to_wait
    Application.where(:offered => "disqualify").update_all(:offered => "wait")
    render :text => "Done"
  end

  def insert_offer_status
    SystemMessage.create(:procedure_id => 0, :name => "Offer Status - Accept", :identify_name => "offer_status_accept", :message => "Congratulations! You have officially accepted the offer.")
    SystemMessage.create(:procedure_id => 0, :name => "Offer Status - Decline", :identify_name => "offer_status_decline", :message => "You have officially declined the offer.")
    Procedure.all.each do |procedure|
      SystemMessage.create(:procedure_id => procedure.id, :name => "Offer Status - Accept", :identify_name => "offer_status_accept", :message => "Congratulations! You have officially accepted the offer.")
      SystemMessage.create(:procedure_id => procedure.id, :name => "Offer Status - Decline", :identify_name => "offer_status_decline", :message => "You have officially declined the offer.")
    end
    render :text => "Done"
  end

  def insert_ranked_at
    Applicant.all.each do |applicant|
      application = Application.joins(:position).where(:positions => {:procedure_id => applicant.procedure_id}, :user_id => applicant.user_id, :user_rank => 1).first
      applicant.ranked_at = application.updated_at if application
      applicant.save
    end
    render :text => "Done"
  end

  def update_position_name
    Position.includes(:location, :role).where(:name => nil).each do |position|
      if position.location && position.role
        position.name = [position.location.name, position.role.name].join("-")
        position.save
      end
    end

    render :text => "Done"
  end

  def insert_pre_location_mgrs_20150114
    user_datas = [
      {:last_name => 'Schnaubelt', :first_name => 'Thomas', :sunet_id => 'thomasjs', :email => 'thomas.schnaubelt@stanford.edu', :location_name => 'Branner', :status => 'Staff'},
      {:last_name => 'Schnaubelt', :first_name => 'Mary Esther', :sunet_id => 'meschnau', :email => 'meschnau@stanford.edu', :location_name => 'Branner', :status => 'Staff'},
      {:last_name => 'Chan', :first_name => 'Raymond', :sunet_id => 'rchan2', :email => 'rchan2@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Cibils', :first_name => 'Cristian', :sunet_id => 'ccibils', :email => 'ccibils@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Dinh', :first_name => 'Cong', :sunet_id => 'dinhcong', :email => 'dinhcong@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'El-Gabalawy', :first_name => 'Osama', :sunet_id => 'osamae', :email => 'osamae@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Huynh', :first_name => 'Connie', :sunet_id => 'chuynh', :email => 'chuynh@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Nguyen', :first_name => 'Brian', :sunet_id => 'bnguyen8', :email => 'bnguyen8@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Shank', :first_name => 'Sophie', :sunet_id => 'sshank', :email => 'sshank@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Shorty', :first_name => 'Santana', :sunet_id => 'sshorty', :email => 'sshorty@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Sov', :first_name => 'Wendy', :sunet_id => 'wendysov', :email => 'wendysov@stanford.edu', :location_name => 'Branner', :status => 'Student'},
      {:last_name => 'Randolph', :first_name => 'Jason', :sunet_id => 'jrand', :email => 'jrand@stanford.edu', :location_name => 'Casa Zapata', :status => 'Staff'},
      {:last_name => 'Randolph', :first_name => 'Joanne', :sunet_id => 'jorand', :email => 'joaneeg68@yahoo.com', :location_name => 'Casa Zapata', :status => 'Staff'},
      {:last_name => 'Brito', :first_name => 'Alemar', :sunet_id => 'abrito', :email => 'abrito@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Hernandez', :first_name => 'Luis', :sunet_id => 'luisrh93', :email => 'luisrh93@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Hyatt', :first_name => 'Genie', :sunet_id => 'ghyatt', :email => 'ghyatt@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Madsen', :first_name => 'Peter', :sunet_id => 'pmadsen', :email => 'pmadsen@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'McDowell', :first_name => 'Erica', :sunet_id => 'ericamcd', :email => 'ericamcd@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Mendoza', :first_name => 'Joshua', :sunet_id => 'joshua93', :email => 'joshua93@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Mitchell', :first_name => 'Catherine', :sunet_id => 'catmitch', :email => 'catmitch@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Ramirez', :first_name => 'Yvette', :sunet_id => 'yramirez', :email => 'yramirez@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Zarafshar', :first_name => 'Shayda', :sunet_id => 'shaydaz', :email => 'shaydaz@stanford.edu', :location_name => 'Casa Zapata', :status => 'Student'},
      {:last_name => 'Jones', :first_name => 'James Holland', :sunet_id => 'jhj1', :email => 'jhj1@stanford.edu', :location_name => 'Castano', :status => 'Staff'},
      {:last_name => 'Hilde', :first_name => 'Libra', :sunet_id => 'lhilde', :email => 'lhilde@stanford.edu', :location_name => 'Castano', :status => 'Staff'},
      {:last_name => 'Brant', :first_name => 'Arthur', :sunet_id => 'abrant', :email => 'abrant@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Collins', :first_name => 'Emma Mather', :sunet_id => 'emma16', :email => 'emma16@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Fearon', :first_name => 'Robert', :sunet_id => 'rafearon', :email => 'rafearon@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Gabor', :first_name => 'Alexandra', :sunet_id => 'agabor', :email => 'agabor@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Irvine', :first_name => 'Eddie Buford', :sunet_id => 'eirvine', :email => 'eirvine@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Lakshman', :first_name => 'Vihan Sankaran', :sunet_id => 'vihan', :email => 'vihan@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Lopez', :first_name => 'Eric', :sunet_id => 'elopez7', :email => 'elopez7@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Park', :first_name => 'Do-Hyoung', :sunet_id => 'dpark027', :email => 'dpark027@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Quintero', :first_name => 'Julia', :sunet_id => 'juliaq', :email => 'juliaq@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Tiu', :first_name => 'Wesley', :sunet_id => 'wdtiu', :email => 'wdtiu@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Troderman', :first_name => 'Joe Louis', :sunet_id => 'jtrod93', :email => 'jtrod93@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Williams', :first_name => 'Kristyn Blaire', :sunet_id => 'kristynw', :email => 'kristynw@stanford.edu', :location_name => 'Castano', :status => 'Student'},
      {:last_name => 'Stedman', :first_name => 'Stephen', :sunet_id => 'sstedman', :email => 'sstedman@stanford.edu', :location_name => 'Crothers', :status => 'Staff'},
      {:last_name => 'Thomas', :first_name => 'Corinne', :sunet_id => 'corinne1', :email => 'corinnethomas@stanford.edu', :location_name => 'Crothers', :status => 'Staff'},
      {:last_name => 'Adamjee', :first_name => 'Rehan', :sunet_id => 'radamjee', :email => 'radamjee@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Akana', :first_name => 'Palani', :sunet_id => 'palakana', :email => 'palakana@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Butler', :first_name => 'Jordan', :sunet_id => 'jdbutler', :email => 'jdbutler@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Datta', :first_name => 'Varun', :sunet_id => 'varund', :email => 'varund@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Goodman', :first_name => 'Ilan', :sunet_id => 'igoodman', :email => 'igoodman@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Gregory', :first_name => 'Kat', :sunet_id => 'katg', :email => 'katg@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Guan', :first_name => 'Charles', :sunet_id => 'cguan2', :email => 'charles.guan@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Gueble', :first_name => 'Isabel', :sunet_id => 'isgueble', :email => 'isgueble@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Hannell', :first_name => 'Jordan', :sunet_id => 'jfhannell', :email => 'jfhannell@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Hare', :first_name => 'Vivian', :sunet_id => 'vhare', :email => 'vhare@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Johnson', :first_name => 'Stuart', :sunet_id => 'stuman22', :email => 'stuman22@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Kalkus', :first_name => 'Kira', :sunet_id => 'kirak', :email => 'kirak@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Khoo', :first_name => 'Jason', :sunet_id => 'jwskhoo', :email => 'jwskhoo@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Kobashi', :first_name => 'Atsuhide', :sunet_id => 'akbsh', :email => 'akbsh@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Kyarunts', :first_name => 'Mariam', :sunet_id => 'mariamk', :email => 'mariamk@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Prasad', :first_name => 'Ritika', :sunet_id => 'ritikap', :email => 'ritikap@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Sarkar', :first_name => 'Aditya', :sunet_id => 'sarkar17', :email => 'sarkar17@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Sheils', :first_name => 'Hope', :sunet_id => 'hsheils', :email => 'hsheils@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Singh', :first_name => 'Parabal', :sunet_id => 'parabal', :email => 'parabal@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Speiser', :first_name => 'Jacqueline', :sunet_id => 'jspeiser', :email => 'jspeiser@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Steinkellner', :first_name => 'Emma', :sunet_id => 'emstein', :email => 'emstein@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Zerbe', :first_name => 'Amanda', :sunet_id => 'azerbe', :email => 'azerbe@stanford.edu', :location_name => 'Crothers', :status => 'Student'},
      {:last_name => 'Antonio', :first_name => 'Anthony lising', :sunet_id => 'aantonio', :email => 'aantonio@stanford.edu', :location_name => 'EAST', :status => 'Staff'},
      {:last_name => 'Wotipka', :first_name => 'Christine Min', :sunet_id => 'cwotipka', :email => 'cwotipka@stanford.edu', :location_name => 'EAST', :status => 'Staff'},
      {:last_name => 'Do', :first_name => 'Kelvin', :sunet_id => 'kelvindo', :email => 'kelvindo@stanford.edu', :location_name => 'EAST', :status => 'Student'},
      {:last_name => 'Frank-Fisher', :first_name => 'Luna', :sunet_id => 'luna16', :email => 'luna16@stanford.edu', :location_name => 'EAST', :status => 'Student'},
      {:last_name => 'Kim', :first_name => 'Nicole', :sunet_id => 'nkim1', :email => 'nkim1@stanford.edu', :location_name => 'EAST', :status => 'Student'},
      {:last_name => 'Ortiz', :first_name => 'Estefania', :sunet_id => 'eaortiz', :email => 'eaortiz@stanford.edu', :location_name => 'EAST', :status => 'Student'},
      {:last_name => 'Zhu', :first_name => 'Julie', :sunet_id => 'lijingz', :email => 'lijingz@stanford.edu', :location_name => 'EAST', :status => 'Student'},
      {:last_name => 'Thiemann', :first_name => 'Henry', :sunet_id => 'henryat', :email => 'henryat@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Buchsbaum', :first_name => 'Alison', :sunet_id => 'alison16', :email => 'alison16@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Dreyer', :first_name => 'Amelia', :sunet_id => 'adreyer', :email => 'adreyer@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Gamo', :first_name => 'Eri', :sunet_id => 'egamo', :email => 'egamo@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Hamilton', :first_name => 'Will', :sunet_id => 'wjlham91', :email => 'wjlham91@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Howard', :first_name => 'Imani', :sunet_id => 'ihoward', :email => 'ihoward@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Schmidt', :first_name => 'Lina', :sunet_id => 'lina93', :email => 'lina93@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Simon', :first_name => 'Harry', :sunet_id => 'hasimon', :email => 'hasimon@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Thiemann', :first_name => 'Henry', :sunet_id => 'henryat', :email => 'henryat@stanford.edu', :location_name => 'EBF', :status => 'Student'},
      {:last_name => 'Barron', :first_name => 'Cisco', :sunet_id => 'ciscobarron', :email => 'ciscobarron@stanford.edu', :location_name => 'FroSoCo', :status => 'Staff'},
      {:last_name => 'Woltman', :first_name => 'LaCona', :sunet_id => 'lwoltmon', :email => 'lwoltmon@stanford.edu', :location_name => 'FroSoCo', :status => 'Staff'},
      {:last_name => 'Brown', :first_name => 'Bryan', :sunet_id => 'brbrown', :email => 'brbrown@stanford.edu', :location_name => 'FroSoCo', :status => 'Staff'},
      {:last_name => 'Brown', :first_name => 'Cheryl', :sunet_id => 'cbrown4', :email => 'cheryl.brown@stanford.edu', :location_name => 'FroSoCo', :status => 'Staff'},
      {:last_name => 'Allison', :first_name => 'Jenni', :sunet_id => 'jennia44', :email => 'jennia44@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Dannenmaier', :first_name => 'Katherine', :sunet_id => 'kdanne', :email => 'kdanne@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Freybler', :first_name => 'Nicholas', :sunet_id => 'nickfrey', :email => 'nickfrey@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Garland', :first_name => 'Rex', :sunet_id => 'rgarland', :email => 'rgarland@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Gorlorwulu', :first_name => 'Garmai', :sunet_id => 'garmaig', :email => 'garmaig@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Hong', :first_name => 'Lena', :sunet_id => 'lenahong', :email => 'lenahong@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Huang', :first_name => 'Mindy', :sunet_id => 'mindyh', :email => 'mindyh@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Liu', :first_name => 'Larry', :sunet_id => 'hrlarry', :email => 'hrlarry@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Lizzappi', :first_name => 'Malcolm', :sunet_id => 'mlizzapp', :email => 'mlizzapp@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Slaughter', :first_name => 'Allison', :sunet_id => 'alli17', :email => 'alli17@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Smith', :first_name => 'Schuyler', :sunet_id => 'skysmith', :email => 'skysmith@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Williams', :first_name => 'Elliot', :sunet_id => 'elliotw', :email => 'elliotw@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Zhou', :first_name => 'Bright', :sunet_id => 'brightz', :email => 'brightz@stanford.edu', :location_name => 'FroSoCo', :status => 'Student'},
      {:last_name => 'Leal', :first_name => 'Christian', :sunet_id => 'cleal93', :email => 'cleal93@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Michelson', :first_name => 'Kyle', :sunet_id => 'kylem3', :email => 'kylem3@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Nader', :first_name => 'Sarah', :sunet_id => 'snader2', :email => 'snader2@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Sayiner', :first_name => 'Sibel', :sunet_id => 'ssayiner', :email => 'ssayiner@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Spielberg Verdejo', :first_name => 'Victor', :sunet_id => 'victor15', :email => 'victor15@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Topasna', :first_name => 'Joseph', :sunet_id => 'jtopasna', :email => 'jtopasna@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Wambersie', :first_name => 'Leopold', :sunet_id => 'leopoldw', :email => 'leopoldw@stanford.edu', :location_name => 'Hammarskjold', :status => 'Student'},
      {:last_name => 'Axler', :first_name => 'Ariella', :sunet_id => 'aaxler', :email => 'aaxler@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Fitzpatrick', :first_name => 'Haley', :sunet_id => 'haleyf', :email => 'haleyf@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Jacoby', :first_name => 'Mackenzie', :sunet_id => 'mjacoby', :email => 'mjacoby@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Kolb', :first_name => 'Kathryn', :sunet_id => 'kkolb', :email => 'kkolb@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Lieberman', :first_name => 'Erica', :sunet_id => 'ericakl', :email => 'ericakl@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Scott', :first_name => 'Sean', :sunet_id => 'stscott', :email => 'stscott@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Wang', :first_name => 'Peter', :sunet_id => 'xywang', :email => 'freezing@stanford.edu', :location_name => 'Haus Mitteleuropa', :status => 'Student'},
      {:last_name => 'Edelstein', :first_name => 'Dan', :sunet_id => 'danedels', :email => 'danedels@stanford.edu', :location_name => 'Humanities House "Manzanita"', :status => 'Staff'},
      {:last_name => 'Bower', :first_name => 'Zoe', :sunet_id => 'zbower', :email => 'zbower@stanford.edu', :location_name => 'Humanities House "Manzanita"', :status => 'Staff'},
      {:last_name => 'Atkinson', :first_name => 'Tracey', :sunet_id => 'traceya', :email => 'traceya@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Ball', :first_name => 'Frances', :sunet_id => 'fball', :email => 'fball@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Leonardo', :first_name => 'Jenna', :sunet_id => 'jennaleo', :email => 'jennaleo@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Leonardo', :first_name => 'Jenna', :sunet_id => 'jennaleo', :email => 'jennaleo@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Ramos', :first_name => 'Lazara', :sunet_id => 'lazarar', :email => 'lazarar@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Rosenthal', :first_name => 'Noam', :sunet_id => 'nrose', :email => 'nrose@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Tindall', :first_name => 'Nathan', :sunet_id => 'ntindall', :email => 'ntindall@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Walendom', :first_name => 'Laetitia', :sunet_id => 'walendom', :email => 'walendom@stanford.edu', :location_name => 'Kairos', :status => 'Student'},
      {:last_name => 'Todhunter', :first_name => 'Andrew', :sunet_id => 'todhuntr', :email => 'andrew.todhunter@stanford.edu', :location_name => 'Kimball', :status => 'Staff'},
      {:last_name => 'Todhunter', :first_name => 'Erin', :sunet_id => 'etodhunt', :email => 'erin.todhunter@gmail.com', :location_name => 'Kimball', :status => 'Staff'},
      {:last_name => 'Aguirre', :first_name => 'Jorge', :sunet_id => 'jag20101', :email => 'jag20101@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Baena', :first_name => 'Joseph', :sunet_id => 'jbaena', :email => 'jbaena@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Bonab', :first_name => 'Shahab', :sunet_id => 'sfadavi', :email => 'sfadavi@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Coelho', :first_name => 'Kevin', :sunet_id => 'katc', :email => 'katc@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Hamaguchi', :first_name => 'Ryoko', :sunet_id => 'ryokoh', :email => 'ryokoh@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Huynh', :first_name => 'James', :sunet_id => 'jhuynh93', :email => 'jhuynh93@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Lee', :first_name => 'Christina', :sunet_id => 'esclee', :email => 'esclee@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Legoski', :first_name => 'Saamon', :sunet_id => 'slegoski', :email => 'slegoski@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Liker', :first_name => 'Karina', :sunet_id => 'kliker', :email => 'kliker@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Low', :first_name => 'Jackie', :sunet_id => 'jlow215', :email => 'jlow215@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Nencheva', :first_name => 'Mira', :sunet_id => 'miran', :email => 'miran@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Rials', :first_name => 'Matthew', :sunet_id => 'mjrials', :email => 'mjrials@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Vijayakumar', :first_name => 'Nithya', :sunet_id => 'nithyapv', :email => 'nithyapv@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Weierich', :first_name => 'Kendall', :sunet_id => 'kendallw', :email => 'kendallw@stanford.edu', :location_name => 'Kimball', :status => 'Student'},
      {:last_name => 'Lummus', :first_name => 'David', :sunet_id => 'dlummus', :email => 'dlummus@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Staff'},
      {:last_name => 'Culler', :first_name => 'McKenzie', :sunet_id => 'mculler', :email => 'mculler@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Cussen', :first_name => 'Laura', :sunet_id => 'lcussen', :email => 'lcussen@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Geo', :first_name => 'Ashley', :sunet_id => 'ageo', :email => 'ageo@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Glasser', :first_name => 'Annabah', :sunet_id => 'aglasser', :email => 'aglasser@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Henri', :first_name => 'Pearson', :sunet_id => 'phenri', :email => 'phenri@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Knapp', :first_name => 'Daniel', :sunet_id => 'dknapp1', :email => 'dknapp1@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Malloy', :first_name => 'Dylan', :sunet_id => 'dylanm', :email => 'dylanm@stanford.edu', :location_name => 'La Casa Italiana', :status => 'Student'},
      {:last_name => 'Cornman', :first_name => 'Naomi', :sunet_id => 'ncornman', :email => 'ncornman@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Le Roux', :first_name => 'Alex', :sunet_id => 'afleroux', :email => 'afleroux@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Martinez', :first_name => 'Maria', :sunet_id => 'mariam6', :email => 'mariam6@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Seira Silva-Herzog', :first_name => 'Santiago', :sunet_id => 'sseira', :email => 'sseira@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Shapiro', :first_name => 'Jordan', :sunet_id => 'jordansh', :email => 'jordansh@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Thakur', :first_name => 'Natalya', :sunet_id => 'nthakur9', :email => 'nthakur9@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Vela', :first_name => 'Michael', :sunet_id => 'mhvela1', :email => 'mhvela1@stanford.edu', :location_name => 'La Maison Francaise', :status => 'Student'},
      {:last_name => 'Flink', :first_name => 'Chris', :sunet_id => 'cflink', :email => 'cflink@stanford.edu', :location_name => 'Lantana', :status => 'Staff'},
      {:last_name => 'Flink', :first_name => 'Lauren', :sunet_id => 'lflink', :email => 'lauren@twilightrodeo.com', :location_name => 'Lantana', :status => 'Staff'},
      {:last_name => 'Deutsch', :first_name => 'Brian', :sunet_id => 'bdeutsch', :email => 'bdeutsch@stanford.edu', :location_name => 'Lantana', :status => 'Student'},
      {:last_name => 'Ezeokoli', :first_name => 'Benjamin', :sunet_id => 'ezeokoli', :email => 'ezeokoli@stanford.edu', :location_name => 'Lantana', :status => 'Student'},
      {:last_name => 'Lee', :first_name => 'George', :sunet_id => 'glee3', :email => 'glee3@stanford.edu', :location_name => 'Lantana', :status => 'Student'},
      {:last_name => 'Liodakis', :first_name => 'Nikos', :sunet_id => 'ngl', :email => 'ngl@stanford.edu', :location_name => 'Lantana', :status => 'Student'},
      {:last_name => 'Smith', :first_name => 'Lilliana', :sunet_id => 'lilliana', :email => 'lilliana@stanford.edu', :location_name => 'Lantana', :status => 'Student'},
      {:last_name => 'Blake', :first_name => 'Ray', :sunet_id => 'rayblake', :email => 'rayblake@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Staff'},
      {:last_name => 'Hixson-Blake', :first_name => 'Shoney', :sunet_id => 'missann', :email => 'missann@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Staff'},
      {:last_name => 'Cammers-Goodwin', :first_name => 'Sage', :sunet_id => 'sageis', :email => 'sageis@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Chatoor', :first_name => 'Nehan', :sunet_id => 'nchatoor', :email => 'nchatoor@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Kaopuiki', :first_name => 'Jana', :sunet_id => 'janak', :email => 'janak@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Lee', :first_name => 'Awapuhi', :sunet_id => 'awapuhil', :email => 'awapuhil@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Wood', :first_name => 'Alexis', :sunet_id => 'amw00d', :email => 'amw00d@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Yaghi', :first_name => 'Alia', :sunet_id => 'ayaghi', :email => 'ayaghi@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Zhao', :first_name => 'Michelle', :sunet_id => 'mzhao94', :email => 'mzhao94@stanford.edu', :location_name => 'Muwekma-Tah-Ruk', :status => 'Student'},
      {:last_name => 'Takemoto', :first_name => 'Anne', :sunet_id => 'annet', :email => 'annet@stanford.edu', :location_name => 'Okada', :status => 'Staff'},
      {:last_name => 'Cao', :first_name => 'Rachel', :sunet_id => 'rachenc', :email => 'rachenc@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Giron', :first_name => 'Nicole', :sunet_id => 'ngiron', :email => 'ngiron@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Lee', :first_name => 'Andrew', :sunet_id => 'alee16', :email => 'alee16@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Orozco', :first_name => 'Ivana', :sunet_id => 'iiorozco', :email => 'iiorozco@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Phan', :first_name => 'Annie', :sunet_id => 'anphan', :email => 'anphan@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Schow', :first_name => 'Brandon', :sunet_id => 'bmschow', :email => 'bmschow@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Tran', :first_name => 'Tony', :sunet_id => 'tntran17', :email => 'tntran17@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Zaw', :first_name => 'Catherine', :sunet_id => 'czaw13', :email => 'czaw13@stanford.edu', :location_name => 'Okada', :status => 'Student'},
      {:last_name => 'Ciurea Ilcus', :first_name => 'Silviana', :sunet_id => 'smci', :email => 'smci@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Empinotti', :first_name => 'Gustavo', :sunet_id => 'gustavoe', :email => 'gustavoe@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Ho', :first_name => 'Lana', :sunet_id => 'lanaho', :email => 'lanaho@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Johnson', :first_name => 'Max', :sunet_id => 'maxj15', :email => 'maxj15@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Randall', :first_name => 'Lucy', :sunet_id => 'lucyr1', :email => 'lucyr1@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Weiler', :first_name => 'Gideon', :sunet_id => 'gweiler', :email => 'gweiler@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Wilcox', :first_name => 'Ethan', :sunet_id => 'wilcoxeg', :email => 'wilcoxeg@stanford.edu', :location_name => 'Slavianskii Dom', :status => 'Student'},
      {:last_name => 'Cervantes', :first_name => 'Rocco', :sunet_id => 'roccoc', :email => 'roccoc@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'Chen', :first_name => 'Matthew', :sunet_id => 'mchenja', :email => 'mchenja@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'Greenberg', :first_name => 'Gabi', :sunet_id => 'gdg', :email => 'gdg@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'Heng', :first_name => 'Wei Ling', :sunet_id => 'wlheng', :email => 'wlheng@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'Kadavy', :first_name => 'Alison', :sunet_id => 'amkadavy', :email => 'amkadavy@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'McKenzie', :first_name => 'Costner', :sunet_id => 'costnerm', :email => 'costnerm@stanford.edu', :location_name => 'Storey', :status => 'Student'},
      {:last_name => 'Hughes', :first_name => 'Solomon', :sunet_id => 'syhughes', :email => 'syhughes@stanford.edu', :location_name => 'SubFree', :status => 'Staff'},
      {:last_name => 'Barazani', :first_name => 'Sharon', :sunet_id => 'macaroni', :email => 'macaroni@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Hanissian', :first_name => 'Alise', :sunet_id => 'aliseh', :email => 'aliseh@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Laux', :first_name => 'Cody', :sunet_id => 'claux', :email => 'claux@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Munoz', :first_name => 'Julian', :sunet_id => 'jmunoz1', :email => 'jmunoz1@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Qin', :first_name => 'Kenneth', :sunet_id => 'kqin', :email => 'kqin@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Sangani', :first_name => 'Kunal', :sunet_id => 'ksangani', :email => 'ksangani@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Twarzynski', :first_name => 'Marek', :sunet_id => 'marekt', :email => 'marekt@stanford.edu', :location_name => 'Synergy', :status => 'Student'},
      {:last_name => 'Gulati', :first_name => 'Sukhi', :sunet_id => 'sgulati3', :email => 'sgulati3@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Lopez', :first_name => 'MaryJo', :sunet_id => 'mjolopez', :email => 'mjolopez@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Morris', :first_name => 'Sean', :sunet_id => 'smorris3', :email => 'smorris3@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Oneal', :first_name => 'Owen', :sunet_id => 'ooneal', :email => 'ooneal@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Pancoast', :first_name => 'Darcey', :sunet_id => 'darceyp', :email => 'darceyp@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Rodriguez Buchillon', :first_name => 'Ruben', :sunet_id => 'rubenr2', :email => 'rubenr2@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Shumate', :first_name => 'Alaina', :sunet_id => 'ashumate', :email => 'ashumate@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Stein', :first_name => 'Andrea', :sunet_id => 'astein2', :email => 'astein2@stanford.edu', :location_name => 'Terra', :status => 'Student'},
      {:last_name => 'Parker', :first_name => 'Grant', :sunet_id => 'grparker', :email => 'grparker@stanford.edu', :location_name => 'Toyon', :status => 'Staff'},
      {:last_name => 'Catsalis', :first_name => 'Marie-Louise', :sunet_id => 'mlcats', :email => 'mlcats@stanford.edu', :location_name => 'Toyon', :status => 'Staff'},
      {:last_name => 'Abraham', :first_name => 'Kyle', :sunet_id => 'kjabra', :email => 'kjabra@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Bane', :first_name => 'Shalmali', :sunet_id => 'sbane', :email => 'sbane@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Bharadwaj', :first_name => 'Maheetha', :sunet_id => 'maheetha', :email => 'maheetha@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Bui', :first_name => 'Kevin', :sunet_id => 'kevinbui', :email => 'kevinbui@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Herries', :first_name => 'Chris', :sunet_id => 'herriesc', :email => 'herriesc@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Luk', :first_name => 'Alina', :sunet_id => 'alinaluk', :email => 'alinaluk@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Moffett', :first_name => 'Jeremy', :sunet_id => 'jmoffett', :email => 'jmoffett@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Troccoli', :first_name => 'Nick', :sunet_id => 'troccoli', :email => 'troccoli@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Zepeda', :first_name => 'Stephanie', :sunet_id => 'szepeda2', :email => 'szepeda2@stanford.edu', :location_name => 'Toyon', :status => 'Student'},
      {:last_name => 'Barker-Alexander', :first_name => 'Jan', :sunet_id => 'jbarker', :email => 'jbarker@stanford.edu', :location_name => 'Ujamaa', :status => 'Staff'},
      {:last_name => 'Alexander', :first_name => 'Fred', :sunet_id => 'alexande', :email => 'alexander@stanford.edu', :location_name => 'Ujamaa', :status => 'Staff'},
      {:last_name => 'De la Cruz', :first_name => 'Robbie', :sunet_id => 'robbiejd', :email => 'robbiejd@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Hightower', :first_name => 'Brandon', :sunet_id => 'bhigh15', :email => 'bhigh15@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Martin', :first_name => 'Christopher', :sunet_id => 'cmartin4', :email => 'cmartin4@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Miller', :first_name => 'Jordan', :sunet_id => 'jordanm1', :email => 'jordanm1@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Momah', :first_name => 'Gabriella', :sunet_id => 'gmomah', :email => 'gmomah@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Reed', :first_name => 'Jessica', :sunet_id => 'jkreed', :email => 'jkreed@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Sonuyi', :first_name => 'Olutosin', :sunet_id => 'toast144', :email => 'toast144@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Spratley', :first_name => 'Jonathan', :sunet_id => 'spratley', :email => 'spratley@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
      {:last_name => 'Walker', :first_name => 'Dyvon', :sunet_id => 'walkdyvo', :email => 'walkdyvo@stanford.edu', :location_name => 'Ujamaa', :status => 'Student'},
    ]

    user_datas.each do |user_data|
      user = User.create(
        :year_id => 1,
        :first_name => user_data[:first_name],
        :last_name => user_data[:last_name],
        :status => user_data[:status],
        :email => user_data[:email],
        :sunet_id => user_data[:sunet_id],
      )
      if !user || !user.id
        user = User.where(:year_id => 1, :sunet_id => user_data[:sunet_id]).first
      end
      location = Location.where(:procedure_id => 5, :name => user_data[:location_name]).first
      UserProcedure.create(:procedure_id => 5, :user_id => user.id) if user
      LocationMgr.create(:location_id => location.id, :user_id => user.id) if user && location
    end

    render :text => "Done"
  end
  def insert_location_mgrs_20150113
    user_datas = [
      {:suid => "5816134", :last_name => "Chan", :first_name => "Raymond", :sunet_id => "rchan2", :email => "rchan2@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5783075", :last_name => "Cibils", :first_name => "Cristian", :sunet_id => "ccibils", :email => "ccibils@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5716377", :last_name => "Dinh", :first_name => "Cong", :sunet_id => "dinhcong", :email => "dinhcong@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5718735", :last_name => "El-Gabalawy", :first_name => "Osama", :sunet_id => "osamae", :email => "osamae@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5756209", :last_name => "Huynh", :first_name => "Connie", :sunet_id => "chuynh", :email => "chuynh@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5717012", :last_name => "Nguyen", :first_name => "Brian", :sunet_id => "bnguyen8", :email => "bnguyen8@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5814795", :last_name => "Shank", :first_name => "Sophie", :sunet_id => "sshank", :email => "sshank@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5744975", :last_name => "Shorty", :first_name => "Santana", :sunet_id => "sshorty", :email => "sshorty@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5738248", :last_name => "Sov", :first_name => "Wendy", :sunet_id => "wendysov", :email => "wendysov@stanford.edu", :location_name => "Branner", :status => "Student"},
      {:suid => "5788302", :last_name => "Adamjee", :first_name => "Rehan", :sunet_id => "radamjee", :email => "radamjee@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5755712", :last_name => "Akana", :first_name => "Palani", :sunet_id => "palakana", :email => "palakana@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5719657", :last_name => "Butler", :first_name => "Jordan", :sunet_id => "jdbutler", :email => "jdbutler@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5787127", :last_name => "Datta", :first_name => "Varun", :sunet_id => "varund", :email => "varund@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5711198", :last_name => "Goodman", :first_name => "Ilan", :sunet_id => "igoodman", :email => "igoodman@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5790172", :last_name => "Gregory", :first_name => "Kat", :sunet_id => "katg", :email => "katg@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5787908", :last_name => "Guan", :first_name => "Charles", :sunet_id => "cguan2", :email => "charles.guan@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5785155", :last_name => "Gueble", :first_name => "Isabel", :sunet_id => "isgueble", :email => "isgueble@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5784486", :last_name => "Hannell", :first_name => "Jordan", :sunet_id => "jfhannell", :email => "jfhannell@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5799333", :last_name => "Hare", :first_name => "Vivian", :sunet_id => "vhare", :email => "vhare@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5719234", :last_name => "Johnson", :first_name => "Stuart", :sunet_id => "stuman22", :email => "stuman22@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5811720", :last_name => "Kalkus", :first_name => "Kira", :sunet_id => "kirak", :email => "kirak@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5773827", :last_name => "Khoo", :first_name => "Jason", :sunet_id => "jwskhoo", :email => "jwskhoo@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5717097", :last_name => "Kobashi", :first_name => "Atsuhide", :sunet_id => "akbsh", :email => "akbsh@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5787606", :last_name => "Kyarunts", :first_name => "Mariam", :sunet_id => "mariamk", :email => "mariamk@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5755948", :last_name => "Prasad", :first_name => "Ritika", :sunet_id => "ritikap", :email => "ritikap@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5818415", :last_name => "Sarkar", :first_name => "Aditya", :sunet_id => "sarkar17", :email => "sarkar17@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5788702", :last_name => "Sheils", :first_name => "Hope", :sunet_id => "hsheils", :email => "hsheils@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5768728", :last_name => "Singh", :first_name => "Parabal", :sunet_id => "parabal", :email => "parabal@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5787030", :last_name => "Speiser", :first_name => "Jacqueline", :sunet_id => "jspeiser", :email => "jspeiser@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5784009", :last_name => "Steinkellner", :first_name => "Emma", :sunet_id => "emstein", :email => "emstein@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5713127", :last_name => "Zerbe", :first_name => "Amanda", :sunet_id => "azerbe", :email => "azerbe@stanford.edu", :location_name => "Crothers", :status => "Student"},
      {:suid => "5812939", :last_name => "Carley", :first_name => "Meaghan", :sunet_id => "mcarley3", :email => "mcarley3@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5816562", :last_name => "Levin", :first_name => "Brian", :sunet_id => "blevin94", :email => "blevin94@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5752887", :last_name => "Ngai", :first_name => "Edward", :sunet_id => "edngai", :email => "edngai@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5742476", :last_name => "Tjossem", :first_name => "Nora", :sunet_id => "ntjossem", :email => "ntjossem@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5574102", :last_name => "Jiang", :first_name => "Raven", :sunet_id => "jcx", :email => "jcx@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5810472", :last_name => "Lamb", :first_name => "Andrew", :sunet_id => "andrewl3", :email => "andrewl3@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5656690", :last_name => "Lee", :first_name => "Michelle", :sunet_id => "mishlee", :email => "mishlee@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5784153", :last_name => "McKenna", :first_name => "Michael", :sunet_id => "mckenna2", :email => "mckenna2@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5799368", :last_name => "Zhai", :first_name => "Kevin", :sunet_id => "kzhai", :email => "kzhai@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5717920", :last_name => "Lee", :first_name => "Tae", :sunet_id => "taeshinl", :email => "taeshinl@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5820041", :last_name => "Livermore", :first_name => "Keegan", :sunet_id => "keegan", :email => "keegan@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5741181", :last_name => "Sweetwood", :first_name => "Dylan", :sunet_id => "dhs", :email => "dhs@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5819880", :last_name => "Von Erb", :first_name => "Federica", :sunet_id => "fvonerb", :email => "fvonerb@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5742223", :last_name => "Bowes", :first_name => "Johnathan", :sunet_id => "jbowes", :email => "jbowes@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5784982", :last_name => "Chin", :first_name => "Megan", :sunet_id => "mlchin", :email => "mlchin@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5661846", :last_name => "Evans", :first_name => "Sarah", :sunet_id => "sevans1", :email => "sevans1@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5785140", :last_name => "Son", :first_name => "Jae-Young", :sunet_id => "jaeyoung", :email => "jaeyoung@stanford.edu", :location_name => "East FloMo", :status => "Student"},
      {:suid => "5787366", :last_name => "Crow", :first_name => "Allison", :sunet_id => "acrow", :email => "acrow@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5789842", :last_name => "Whitmeyer", :first_name => "Max", :sunet_id => "mwhitmey", :email => "mwhitmey@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5819922", :last_name => "Cisse", :first_name => "Abdoulaye", :sunet_id => "cisse", :email => "cisse@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5786164", :last_name => "Goldberg", :first_name => "Jen", :sunet_id => "jegoldbe", :email => "jegoldbe@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5827902", :last_name => "Oxley", :first_name => "Mariah", :sunet_id => "moxley", :email => "moxley@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5816990", :last_name => "Getz", :first_name => "Joseph", :sunet_id => "jogetz", :email => "jogetz@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5787341", :last_name => "Fazeli", :first_name => "Saba", :sunet_id => "sfazeli", :email => "sfazeli@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5791262", :last_name => "Morris", :first_name => "Dylan", :sunet_id => "dcmorris", :email => "dcmorris@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5788312", :last_name => "Woythaler", :first_name => "Gus", :sunet_id => "gusw1", :email => "gusw1@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5790235", :last_name => "Johnson", :first_name => "Nicholas", :sunet_id => "nlj2016", :email => "nlj2016@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5784136", :last_name => "Kawawa-Beaudan", :first_name => "Julien", :sunet_id => "julienkb", :email => "julienkb@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5720166", :last_name => "Wibowo", :first_name => "Melissa", :sunet_id => "mwibowo", :email => "mwibowo@stanford.edu", :location_name => "West FloMo", :status => "Student"},
      {:suid => "5750700", :last_name => "Do", :first_name => "Kelvin", :sunet_id => "kelvindo", :email => "kelvindo@stanford.edu", :location_name => "EAST", :status => "Student"},
      {:suid => "5785149", :last_name => "Frank-Fisher", :first_name => "Luna", :sunet_id => "luna16", :email => "luna16@stanford.edu", :location_name => "EAST", :status => "Student"},
      {:suid => "5710735", :last_name => "Kim", :first_name => "Nicole", :sunet_id => "nkim1", :email => "nkim1@stanford.edu", :location_name => "EAST", :status => "Student"},
      {:suid => "5789528", :last_name => "Ortiz", :first_name => "Estefania", :sunet_id => "eaortiz", :email => "eaortiz@stanford.edu", :location_name => "EAST", :status => "Student"},
      {:suid => "5826404", :last_name => "Zhu", :first_name => "Julie", :sunet_id => "lijingz", :email => "lijingz@stanford.edu", :location_name => "EAST", :status => "Student"},
      {:suid => "5748746", :last_name => "Thiemann", :first_name => "Henry", :sunet_id => "henryat", :email => "henryat@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:suid => "5810933", :last_name => "Allison", :first_name => "Jenni", :sunet_id => "jennia44", :email => "jennia44@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5787356", :last_name => "Dannenmaier", :first_name => "Katherine", :sunet_id => "kdanne", :email => "kdanne@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5785999", :last_name => "Freybler", :first_name => "Nicholas", :sunet_id => "nickfrey", :email => "nickfrey@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5724975", :last_name => "Garland", :first_name => "Rex", :sunet_id => "rgarland", :email => "rgarland@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5750764", :last_name => "Gorlorwulu", :first_name => "Garmai", :sunet_id => "garmaig", :email => "garmaig@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5720025", :last_name => "Hong", :first_name => "Lena", :sunet_id => "lenahong", :email => "lenahong@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5741244", :last_name => "Huang", :first_name => "Mindy", :sunet_id => "mindyh", :email => "mindyh@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5790047", :last_name => "Liu", :first_name => "Larry", :sunet_id => "hrlarry", :email => "hrlarry@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5907841", :last_name => "Lizzappi", :first_name => "Malcolm", :sunet_id => "mlizzapp", :email => "mlizzapp@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5715279", :last_name => "Slaughter", :first_name => "Allison", :sunet_id => "alli17", :email => "alli17@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5719376", :last_name => "Smith", :first_name => "Schuyler", :sunet_id => "skysmith", :email => "skysmith@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5740986", :last_name => "Williams", :first_name => "Elliot", :sunet_id => "elliotw", :email => "elliotw@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5820954", :last_name => "Zhou", :first_name => "Bright", :sunet_id => "brightz", :email => "brightz@stanford.edu", :location_name => "FroSoCo", :status => "Student"},
      {:suid => "5756460", :last_name => "Carpenter", :first_name => "Chance", :sunet_id => "chancec", :email => "chancec@stanford.edu", :location_name => "Murray", :status => "Student"},
      {:suid => "5786752", :last_name => "Kautz", :first_name => "Carson", :sunet_id => "ckautz", :email => "ckautz@stanford.edu", :location_name => "Murray", :status => "Student"},
      {:suid => "5716808", :last_name => "Nayebi", :first_name => "Aran", :sunet_id => "anayebi", :email => "anayebi@stanford.edu", :location_name => "Murray", :status => "Student"},
      {:suid => "5742239", :last_name => "Baughn", :first_name => "Cameron", :sunet_id => "cbaughn", :email => "cbaughn@stanford.edu", :location_name => "Potter", :status => "Student"},
      {:suid => "5758511", :last_name => "Dlamini", :first_name => "Selamile", :sunet_id => "sdlamini", :email => "sdlamini@stanford.edu", :location_name => "Potter", :status => "Student"},
      {:suid => "5785730", :last_name => "Shah", :first_name => "Mina", :sunet_id => "minashah", :email => "minashah@stanford.edu", :location_name => "Potter", :status => "Student"},
      {:suid => "5655498", :last_name => "Ulrich", :first_name => "Mark", :sunet_id => "mulrich", :email => "mulrich@stanford.edu", :location_name => "Potter", :status => "Student"},
      {:suid => "5791241", :last_name => "Nguyen", :first_name => "Christie", :sunet_id => "chrbnguy", :email => "chrbnguy@stanford.edu", :location_name => "Robinson", :status => "Student"},
      {:suid => "5747415", :last_name => "Palacios-Barrios", :first_name => "Esther", :sunet_id => "estpal", :email => "estpal@stanford.edu", :location_name => "Robinson", :status => "Student"},
      {:suid => "5826073", :last_name => "Wessendorf", :first_name => "Karl", :sunet_id => "karlwess", :email => "karlwess@stanford.edu", :location_name => "Robinson", :status => "Student"},
      {:suid => "5718723", :last_name => "Xue", :first_name => "Angela (Remy)", :sunet_id => "angelax", :email => "angelax@stanford.edu", :location_name => "Robinson", :status => "Student"},
      {:suid => "5718840", :last_name => "Asfour", :first_name => "Moustafa", :sunet_id => "masfour", :email => "masfour@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5826037", :last_name => "Butler", :first_name => "Brielle", :sunet_id => "brielle", :email => "brielle@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5786358", :last_name => "Dewey", :first_name => "Jack", :sunet_id => "jhdewey", :email => "jhdewey@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5713473", :last_name => "Hollberg", :first_name => "Joanie", :sunet_id => "hollberg", :email => "hollberg@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5717217", :last_name => "Jiang", :first_name => "Shirley", :sunet_id => "yunqij", :email => "yunqij@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5715772", :last_name => "Olivo", :first_name => "Dilia", :sunet_id => "dcolivo", :email => "dcolivo@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5730546", :last_name => "Riviere", :first_name => "Paul", :sunet_id => "priviere", :email => "priviere@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5743711", :last_name => "Saephanh", :first_name => "Nai", :sunet_id => "saephanh", :email => "saephanh@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5784227", :last_name => "Steele", :first_name => "Sammy", :sunet_id => "sammyst", :email => "sammyst@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5709875", :last_name => "Stein", :first_name => "Mackenzie", :sunet_id => "mstein1", :email => "mstein1@stanford.edu", :location_name => "Suites", :status => "Student"},
      {:suid => "5734880", :last_name => "Hang", :first_name => "Michael", :sunet_id => "mhang", :email => "mhang@stanford.edu", :location_name => "Yost", :status => "Student"},
      {:suid => "5805746", :last_name => "Johnson", :first_name => "Indigo", :sunet_id => "indigo25", :email => "indigo25@stanford.edu", :location_name => "Yost", :status => "Student"},
      {:suid => "5656730", :last_name => "Wigstrom", :first_name => "Sebastian", :sunet_id => "wigstrom", :email => "wigstrom@stanford.edu", :location_name => "Yost", :status => "Student"},
      {:suid => "5715289", :last_name => "Fine", :first_name => "Julia", :sunet_id => "jcfine", :email => "jcfine@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5715095", :last_name => "Talreja", :first_name => "Rohit", :sunet_id => "rtalreja", :email => "rtalreja@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5714399", :last_name => "Adam", :first_name => "Alisha", :sunet_id => "aadam", :email => "aadam@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5781860", :last_name => "Alexander-Hills", :first_name => "Makulumy", :sunet_id => "makulumy", :email => "makulumy@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5818550", :last_name => "Boutros", :first_name => "Hannah", :sunet_id => "hboutros", :email => "hboutros@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5774884", :last_name => "Whitworth", :first_name => "John", :sunet_id => "johnwhit", :email => "johnwhit@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5784088", :last_name => "Godbole", :first_name => "Poorwa", :sunet_id => "pgodbole", :email => "pgodbole@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5788400", :last_name => "Singer", :first_name => "Erin", :sunet_id => "esinger2", :email => "esinger2@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5788204", :last_name => "Swerdlow", :first_name => "Mark", :sunet_id => "swerd", :email => "swerd@stanford.edu", :location_name => "West Lag", :status => "Student"},
      {:suid => "5786691", :last_name => "Reynoso", :first_name => "Alejandra", :sunet_id => "alerey94", :email => "alerey94@stanford.edu", :location_name => "Naranja", :status => "Student"},
      {:suid => "9667647", :last_name => "Semma", :first_name => "Yoseph", :sunet_id => "zyoseph", :email => "zyoseph@stanford.edu", :location_name => "Naranja", :status => "Student"},
      {:suid => "5718867", :last_name => "De la Cruz", :first_name => "Robbie", :sunet_id => "robbiejd", :email => "robbiejd@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5716873", :last_name => "Hightower", :first_name => "Brandon", :sunet_id => "bhigh15", :email => "bhigh15@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5713867", :last_name => "Martin", :first_name => "Christopher", :sunet_id => "cmartin4", :email => "cmartin4@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5750519", :last_name => "Miller", :first_name => "Jordan", :sunet_id => "jordanm1", :email => "jordanm1@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5713340", :last_name => "Momah", :first_name => "Gabriella", :sunet_id => "gmomah", :email => "gmomah@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5717100", :last_name => "Reed", :first_name => "Jessica", :sunet_id => "jkreed", :email => "jkreed@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5745794", :last_name => "Sonuyi", :first_name => "Olutosin", :sunet_id => "toast144", :email => "toast144@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5750472", :last_name => "Spratley", :first_name => "Jonathan", :sunet_id => "spratley", :email => "spratley@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5745304", :last_name => "Walker", :first_name => "Dyvon", :sunet_id => "walkdyvo", :email => "walkdyvo@stanford.edu", :location_name => "Ujamaa", :status => "Student"},
      {:suid => "5745414", :last_name => "Brant", :first_name => "Arthur", :sunet_id => "abrant", :email => "abrant@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5786697", :last_name => "Collins", :first_name => "Emma Mather", :sunet_id => "emma16", :email => "emma16@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5784161", :last_name => "Fearon", :first_name => "Robert", :sunet_id => "rafearon", :email => "rafearon@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5710324", :last_name => "Gabor", :first_name => "Alexandra", :sunet_id => "agabor", :email => "agabor@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5821071", :last_name => "Irvine", :first_name => "Eddie Buford", :sunet_id => "eirvine", :email => "eirvine@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5787915", :last_name => "Lakshman", :first_name => "Vihan Sankaran", :sunet_id => "vihan", :email => "vihan@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5719756", :last_name => "Lopez", :first_name => "Eric", :sunet_id => "elopez7", :email => "elopez7@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5817187", :last_name => "Park", :first_name => "Do-Hyoung", :sunet_id => "dpark027", :email => "dpark027@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5716242", :last_name => "Quintero", :first_name => "Julia", :sunet_id => "juliaq", :email => "juliaq@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5795865", :last_name => "Tiu", :first_name => "Wesley", :sunet_id => "wdtiu", :email => "wdtiu@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5786370", :last_name => "Troderman", :first_name => "Joe Louis", :sunet_id => "jtrod93", :email => "jtrod93@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5781830", :last_name => "Williams", :first_name => "Kristyn Blaire", :sunet_id => "kristynw", :email => "kristynw@stanford.edu", :location_name => "Castano", :status => "Student"},
      {:suid => "5735410", :last_name => "Aguirre", :first_name => "Jorge", :sunet_id => "jag20101", :email => "jag20101@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5734956", :last_name => "Baena", :first_name => "Joseph", :sunet_id => "jbaena", :email => "jbaena@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5742780", :last_name => "Bonab", :first_name => "Shahab", :sunet_id => "sfadavi", :email => "sfadavi@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5856414", :last_name => "Coelho", :first_name => "Kevin", :sunet_id => "katc", :email => "katc@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5715918", :last_name => "Hamaguchi", :first_name => "Ryoko", :sunet_id => "ryokoh", :email => "ryokoh@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5719514", :last_name => "Huynh", :first_name => "James", :sunet_id => "jhuynh93", :email => "jhuynh93@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5715229", :last_name => "Lee", :first_name => "Christina", :sunet_id => "esclee", :email => "esclee@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5919408", :last_name => "Legoski", :first_name => "Saamon", :sunet_id => "slegoski", :email => "slegoski@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5735357", :last_name => "Liker", :first_name => "Karina", :sunet_id => "kliker", :email => "kliker@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5760670", :last_name => "Low", :first_name => "Jackie", :sunet_id => "jlow215", :email => "jlow215@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5839417", :last_name => "Nencheva", :first_name => "Mira", :sunet_id => "miran", :email => "miran@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5790307", :last_name => "Rials", :first_name => "Matthew", :sunet_id => "mjrials", :email => "mjrials@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5738452", :last_name => "Vijayakumar", :first_name => "Nithya", :sunet_id => "nithyapv", :email => "nithyapv@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5787482", :last_name => "Weierich", :first_name => "Kendall", :sunet_id => "kendallw", :email => "kendallw@stanford.edu", :location_name => "Kimball", :status => "Student"},
      {:suid => "5717370", :last_name => "Deutsch", :first_name => "Brian", :sunet_id => "bdeutsch", :email => "bdeutsch@stanford.edu", :location_name => "Lantana", :status => "Student"},
      {:suid => "5720088", :last_name => "Ezeokoli", :first_name => "Benjamin", :sunet_id => "ezeokoli", :email => "ezeokoli@stanford.edu", :location_name => "Lantana", :status => "Student"},
      {:suid => "5791023", :last_name => "Lee", :first_name => "George", :sunet_id => "glee3", :email => "glee3@stanford.edu", :location_name => "Lantana", :status => "Student"},
      {:suid => "5790270", :last_name => "Liodakis", :first_name => "Nikos", :sunet_id => "ngl", :email => "ngl@stanford.edu", :location_name => "Lantana", :status => "Student"},
      {:suid => "5827315", :last_name => "Smith", :first_name => "Lilliana", :sunet_id => "lilliana", :email => "lilliana@stanford.edu", :location_name => "Lantana", :status => "Student"},
      {:suid => "5782115", :last_name => "Anderson", :first_name => "Timothy", :sunet_id => "timmya", :email => "timmya@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5719029", :last_name => "Harris", :first_name => "Ronnie", :sunet_id => "rharris2", :email => "rharris2@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5784532", :last_name => "Horwitz", :first_name => "Molly", :sunet_id => "mhorwi93", :email => "mhorwi93@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5746129", :last_name => "Joshi", :first_name => "Omkar", :sunet_id => "ojoshi", :email => "ojoshi@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5716970", :last_name => "Lockwood", :first_name => "Beatrix", :sunet_id => "beatrix", :email => "beatrix@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5741158", :last_name => "Morgan", :first_name => "Wade", :sunet_id => "wgmorgan", :email => "wgmorgan@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5714840", :last_name => "Parker-Fong", :first_name => "Imani", :sunet_id => "imanipf", :email => "imanipf@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5830316", :last_name => "Remulla", :first_name => "Carla", :sunet_id => "remulla", :email => "remulla@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5178851", :last_name => "Tran", :first_name => "Anne", :sunet_id => "anne.tran", :email => "anne.tran@stanford.edu", :location_name => "Mirrielees", :status => "Student"},
      {:suid => "5717802", :last_name => "Sinclair", :first_name => "Shelby", :sunet_id => "shelbys8", :email => "shelbys8@stanford.edu", :location_name => "SubFree", :status => "Student"},
      {:suid => "5717465", :last_name => "Cooksey", :first_name => "Krista", :sunet_id => "kcooksey", :email => "kecooksey@gmail.com", :location_name => "Oak Creek", :status => "Student"},
      {:suid => "5790023", :last_name => "Kickingwoman", :first_name => "Sharen", :sunet_id => "sharenk", :email => "sharenk@stanford.edu", :location_name => "Oak Creek", :status => "Student"},
      {:suid => "5713636", :last_name => "Moores", :first_name => "Nicholas", :sunet_id => "npmoores", :email => "npmoores@stanford.edu", :location_name => "Oak Creek", :status => "Student"},
      {:suid => "5611197", :last_name => "Wheeler", :first_name => "Benjamin", :sunet_id => "bwnative", :email => "bwnative@stanford.edu", :location_name => "Oak Creek", :status => "Student"},
      {:suid => "5716595", :last_name => "Carlos", :first_name => "Nancy", :sunet_id => "nan7car", :email => "nan7car@stanford.edu", :location_name => "Rains", :status => "Student"},
      {:suid => "5717770", :last_name => "Chrumka", :first_name => "Alix", :sunet_id => "achrumka", :email => "achrumka@stanford.edu", :location_name => "Rains", :status => "Student"},
      {:suid => "5716461", :last_name => "Boisseree", :first_name => "Katie", :sunet_id => "kbois", :email => "kbois@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5744806", :last_name => "Bradley", :first_name => "Brian", :sunet_id => "bmwenze0", :email => "bmwenze0@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5727697", :last_name => "Cavazos", :first_name => "Justin", :sunet_id => "jcavazos", :email => "jcavazos@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "9674626", :last_name => "Dalal", :first_name => "Nicole", :sunet_id => "nhdalal", :email => "nhdalal@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5818199", :last_name => "Fugel", :first_name => "Dylan", :sunet_id => "dfugel", :email => "dfugel@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5785097", :last_name => "Ginzberg", :first_name => "Adam", :sunet_id => "ginzberg", :email => "ginzberg@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5788503", :last_name => "Grench", :first_name => "Holly", :sunet_id => "hgrench", :email => "hgrench@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5786837", :last_name => "Kain", :first_name => "Danielle", :sunet_id => "dkain", :email => "dkain@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5787590", :last_name => "Kim", :first_name => "Lea", :sunet_id => "leahkim", :email => "leahkim@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5787346", :last_name => "Margrave", :first_name => "Andrew", :sunet_id => "margrave", :email => "margrave@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5715993", :last_name => "Odimayomi", :first_name => "Toke", :sunet_id => "omodi99", :email => "omodi99@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5714805", :last_name => "Quintero", :first_name => "Steven", :sunet_id => "stevenq4", :email => "stevenq4@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5712731", :last_name => "Sohn", :first_name => "Natalie", :sunet_id => "nsohn", :email => "nsohn@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5831128", :last_name => "Tran", :first_name => "Alex", :sunet_id => "atran3", :email => "atran3@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5753800", :last_name => "Udo-okoye", :first_name => "Kasiemobi", :sunet_id => "kudookoy", :email => "kudookoy@stanford.edu", :location_name => "Roble", :status => "Student"},
      {:suid => "5788000", :last_name => "Chustz", :first_name => "Austin", :sunet_id => "atchustz", :email => "atchustz@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5804920", :last_name => "Jardine", :first_name => "Derik", :sunet_id => "djardine", :email => "djardine@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5784244", :last_name => "Kay", :first_name => "Hannah", :sunet_id => "hgkay", :email => "hgkay@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5755037", :last_name => "Luu", :first_name => "Clara", :sunet_id => "claraluu", :email => "claraluu@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5783991", :last_name => "Ramnarayan", :first_name => "Nikhil", :sunet_id => "nik405", :email => "nik405@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5785490", :last_name => "Rios", :first_name => "Aaron", :sunet_id => "aj4194", :email => "aj4194@stanford.edu", :location_name => "Burbank", :status => "Student"},
      {:suid => "5718597", :last_name => "Brito", :first_name => "Alemar", :sunet_id => "abrito", :email => "abrito@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5755805", :last_name => "Hernandez", :first_name => "Luis", :sunet_id => "luisrh93", :email => "luisrh93@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5788539", :last_name => "Hyatt", :first_name => "Genie", :sunet_id => "ghyatt", :email => "ghyatt@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5774923", :last_name => "Madsen", :first_name => "Peter", :sunet_id => "pmadsen", :email => "pmadsen@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5810920", :last_name => "McDowell", :first_name => "Erica", :sunet_id => "ericamcd", :email => "ericamcd@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5717831", :last_name => "Mendoza", :first_name => "Joshua", :sunet_id => "joshua93", :email => "joshua93@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5826145", :last_name => "Mitchell", :first_name => "Catherine", :sunet_id => "catmitch", :email => "catmitch@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5738263", :last_name => "Ramirez", :first_name => "Yvette", :sunet_id => "yramirez", :email => "yramirez@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5717478", :last_name => "Zarafshar", :first_name => "Shayda", :sunet_id => "shaydaz", :email => "shaydaz@stanford.edu", :location_name => "Casa Zapata", :status => "Student"},
      {:suid => "5754774", :last_name => "Andrews", :first_name => "McKenzie", :sunet_id => "andrews7", :email => "andrews7@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5784129", :last_name => "Fiorentino", :first_name => "Lindsay", :sunet_id => "lfiorent", :email => "lfiorent@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5717042", :last_name => "Hassan", :first_name => "Dina", :sunet_id => "dihassan", :email => "dihassan@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5784354", :last_name => "McWilliams", :first_name => "Louis", :sunet_id => "louism1", :email => "louism1@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5717616", :last_name => "Salazar", :first_name => "Nick", :sunet_id => "nick310", :email => "nick310@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5785113", :last_name => "Tomaszczuk", :first_name => "Margaret", :sunet_id => "mtomaszc", :email => "mtomaszc@stanford.edu", :location_name => "Donner", :status => "Student"},
      {:suid => "5804972", :last_name => "Alegria", :first_name => "Betsy", :sunet_id => "balegria", :email => "balegria@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5734370", :last_name => "Arevalo", :first_name => "Camilo", :sunet_id => "camiloa", :email => "camiloa@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5789522", :last_name => "Johnston", :first_name => "Noah", :sunet_id => "noahj14", :email => "noahj14@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5713455", :last_name => "Obayemi", :first_name => "Joy", :sunet_id => "jobayemi", :email => "jobayemi@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5743605", :last_name => "Olivos", :first_name => "Daniela", :sunet_id => "dolivos", :email => "dolivos@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5713317", :last_name => "Setrakian", :first_name => "Robert", :sunet_id => "rwsetrak", :email => "rwsetrak@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5742590", :last_name => "Spivak", :first_name => "Sasha", :sunet_id => "sasha21", :email => "sasha21@stanford.edu", :location_name => "Larkin", :status => "Student"},
      {:suid => "5783979", :last_name => "Asher", :first_name => "Tobin", :sunet_id => "tasher", :email => "tasher@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5824059", :last_name => "Benavides", :first_name => "Daniel", :sunet_id => "danben", :email => "danben@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5790704", :last_name => "Brown", :first_name => "Brianna", :sunet_id => "briannab", :email => "briannab@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5800286", :last_name => "Leung", :first_name => "Sherman", :sunet_id => "skleung", :email => "skleung@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5820364", :last_name => "McCone", :first_name => "Kennedy", :sunet_id => "kmccone", :email => "kmccone@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5784547", :last_name => "Scott", :first_name => "Alex", :sunet_id => "alscott", :email => "alscott@stanford.edu", :location_name => "Serra", :status => "Student"},
      {:suid => "5713828", :last_name => "Curtis", :first_name => "Mason", :sunet_id => "msc3", :email => "msc3@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5843745", :last_name => "Doria", :first_name => "Santiago", :sunet_id => "sdoria3", :email => "sdoria3@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5789108", :last_name => "Huang Liu", :first_name => "Lorena", :sunet_id => "lorenah1", :email => "lorenah1@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5786011", :last_name => "Jennings", :first_name => "Levi", :sunet_id => "levij", :email => "levij@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5795734", :last_name => "Pollack", :first_name => "Adrienne", :sunet_id => "apollack", :email => "apollack@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "9678686", :last_name => "Raghvendra", :first_name => "Shubha", :sunet_id => "sraghven", :email => "sraghven@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5791384", :last_name => "Tempest", :first_name => "Alanna", :sunet_id => "atem", :email => "atem@stanford.edu", :location_name => "Twain", :status => "Student"},
      {:suid => "5728776", :last_name => "Abraham", :first_name => "Kyle", :sunet_id => "kjabra", :email => "kjabra@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5817428", :last_name => "Bane", :first_name => "Shalmali", :sunet_id => "sbane", :email => "sbane@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5782597", :last_name => "Bharadwaj", :first_name => "Maheetha", :sunet_id => "maheetha", :email => "maheetha@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5717357", :last_name => "Bui", :first_name => "Kevin", :sunet_id => "kevinbui", :email => "kevinbui@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5731757", :last_name => "Herries", :first_name => "Chris", :sunet_id => "herriesc", :email => "herriesc@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5823031", :last_name => "Luk", :first_name => "Alina", :sunet_id => "alinaluk", :email => "alinaluk@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5782054", :last_name => "Moffett", :first_name => "Jeremy", :sunet_id => "jmoffett", :email => "jmoffett@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5829398", :last_name => "Troccoli", :first_name => "Nick", :sunet_id => "troccoli", :email => "troccoli@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5786510", :last_name => "Zepeda", :first_name => "Stephanie", :sunet_id => "szepeda2", :email => "szepeda2@stanford.edu", :location_name => "Toyon", :status => "Student"},
      {:suid => "5824839", :last_name => "Camacho", :first_name => "Charlotte", :sunet_id => "cc16", :email => "cc16@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5714396", :last_name => "Evans", :first_name => "Clayton", :sunet_id => "claytone", :email => "claytone@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5788060", :last_name => "Sackes", :first_name => "Chris", :sunet_id => "cdsackes", :email => "cdsackes@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5811165", :last_name => "Simister", :first_name => "Eve", :sunet_id => "simister", :email => "simister@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5784234", :last_name => "Stotz", :first_name => "Charles", :sunet_id => "cstotz", :email => "cstotz@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5779683", :last_name => "Theuer", :first_name => "Maya", :sunet_id => "mtheuer", :email => "mtheuer@stanford.edu", :location_name => "Arroyo", :status => "Student"},
      {:suid => "5812742", :last_name => "Chun", :first_name => "Stacy", :sunet_id => "schun1", :email => "schun1@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5787101", :last_name => "Hernandez", :first_name => "Jessica", :sunet_id => "jshernan", :email => "jshernan@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5713459", :last_name => "Ho", :first_name => "Audrey", :sunet_id => "audreyho", :email => "audreyho@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5718798", :last_name => "Kyi", :first_name => "Jasmine", :sunet_id => "jasminek", :email => "jasminek@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5834045", :last_name => "Lee", :first_name => "Shawn", :sunet_id => "slee11", :email => "slee11@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5785203", :last_name => "Lichtman", :first_name => "Miles", :sunet_id => "milesl", :email => "milesl@stanford.edu", :location_name => "Cedro", :status => "Student"},
      {:suid => "5787085", :last_name => "Acharya", :first_name => "Ambika", :sunet_id => "aacharya", :email => "aacharya@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5786689", :last_name => "Malave", :first_name => "Celina", :sunet_id => "csmalave", :email => "csmalave@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5830542", :last_name => "Patricio-Archer", :first_name => "Jazlyn", :sunet_id => "jazlyn", :email => "jazlyn@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5718848", :last_name => "Richard", :first_name => "Logan", :sunet_id => "ltr1065", :email => "ltr1065@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5811612", :last_name => "Srbinovski", :first_name => "Bojan", :sunet_id => "bojansr", :email => "bojansr@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5820979", :last_name => "Templeton", :first_name => "Zach", :sunet_id => "zstemple", :email => "zstemple@stanford.edu", :location_name => "Junipero", :status => "Student"},
      {:suid => "5744233", :last_name => "Cao", :first_name => "Rachel", :sunet_id => "rachenc", :email => "rachenc@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "9674647", :last_name => "Giron", :first_name => "Nicole", :sunet_id => "ngiron", :email => "ngiron@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5783989", :last_name => "Lee", :first_name => "Andrew", :sunet_id => "alee16", :email => "alee16@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5720276", :last_name => "Orozco", :first_name => "Ivana", :sunet_id => "iiorozco", :email => "iiorozco@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5786313", :last_name => "Phan", :first_name => "Annie", :sunet_id => "anphan", :email => "anphan@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5714354", :last_name => "Schow", :first_name => "Brandon", :sunet_id => "bmschow", :email => "bmschow@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5745928", :last_name => "Tran", :first_name => "Tony", :sunet_id => "tntran17", :email => "tntran17@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5718302", :last_name => "Zaw", :first_name => "Catherine", :sunet_id => "czaw13", :email => "czaw13@stanford.edu", :location_name => "Okada", :status => "Student"},
      {:suid => "5782587", :last_name => "Celestin", :first_name => "Garrett", :sunet_id => "garrettc", :email => "garrettc@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5740805", :last_name => "Dalder", :first_name => "Jacob", :sunet_id => "jjdalder", :email => "jjdalder@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5825438", :last_name => "Ellis", :first_name => "Lauren", :sunet_id => "laurenre", :email => "laurenre@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5774753", :last_name => "Esparza", :first_name => "Caitlin", :sunet_id => "caitline", :email => "caitline@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5829568", :last_name => "Munroe", :first_name => "Jelani", :sunet_id => "jelanim", :email => "jelanim@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5784935", :last_name => "Schurz", :first_name => "Tim", :sunet_id => "tschurz", :email => "tschurz@stanford.edu", :location_name => "Otero", :status => "Student"},
      {:suid => "5820827", :last_name => "Irwin", :first_name => "Jordyn", :sunet_id => "jirwin2", :email => "jirwin2@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5813683", :last_name => "Kannappan", :first_name => "Jotthe", :sunet_id => "jotthek", :email => "jotthek@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5789823", :last_name => "Knarr", :first_name => "Elizabeth", :sunet_id => "eknarr", :email => "eknarr@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5821444", :last_name => "Mather", :first_name => "Andrew", :sunet_id => "amather", :email => "amather@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5754250", :last_name => "Poole", :first_name => "Robert", :sunet_id => "rlpoole3", :email => "rlpoole3@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5745799", :last_name => "Yang", :first_name => "April", :sunet_id => "april.yang", :email => "april.yang@stanford.edu", :location_name => "Rinconada", :status => "Student"},
      {:suid => "5784930", :last_name => "Chaikulngamdee", :first_name => "Friend", :sunet_id => "friendc", :email => "friendc@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5806055", :last_name => "Madill", :first_name => "Martine", :sunet_id => "mmadill", :email => "mmadill@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5813745", :last_name => "Newcomb", :first_name => "John", :sunet_id => "jnewcs", :email => "jnewcs@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5789739", :last_name => "Ritterhern", :first_name => "Hayley", :sunet_id => "hayleyr", :email => "hayleyr@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5781702", :last_name => "Strong", :first_name => "Cale", :sunet_id => "cstrong", :email => "cstrong@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5781003", :last_name => "Webb", :first_name => "James", :sunet_id => "jmwebb", :email => "jmwebb@stanford.edu", :location_name => "Soto", :status => "Student"},
      {:suid => "5723181", :last_name => "McMordie", :first_name => "John", :sunet_id => "jegmcmor", :email => "jegmcmor@stanford.edu", :location_name => "Trancos", :status => "Student"},
      {:suid => "5788239", :last_name => "Samar", :first_name => "Anshul", :sunet_id => "asamar", :email => "asamar@stanford.edu", :location_name => "Trancos", :status => "Student"},
      {:suid => "5785778", :last_name => "Smythe", :first_name => "Sabelle", :sunet_id => "issmythe", :email => "issmythe@stanford.edu", :location_name => "Trancos", :status => "Student"},
      {:suid => "5785528", :last_name => "Untermeyer", :first_name => "Elly", :sunet_id => "ellyu", :email => "ellyu@stanford.edu", :location_name => "Trancos", :status => "Student"},
      {:suid => "5828963", :last_name => "Ziebold", :first_name => "Isabelle", :sunet_id => "iziebold", :email => "iziebold@stanford.edu", :location_name => "Trancos", :status => "Student"},
    ]

    user_datas.each do |user_data|
      user = User.create(
        :year_id => 1,
        :suid => user_data[:suid],
        :first_name => user_data[:first_name],
        :last_name => user_data[:last_name],
        :status => user_data[:status],
        :email => user_data[:email],
        :sunet_id => user_data[:sunet_id],
      )
      if !user || !user.id
        user = User.where(:year_id => 1, :sunet_id => user_data[:sunet_id]).first
      end
      location = Location.where(:procedure_id => 7, :name => user_data[:location_name]).first
      UserProcedure.create(:procedure_id => 7, :user_id => user.id) if user
      LocationMgr.create(:location_id => location.id, :user_id => user.id) if user && location
    end

    render :text => "Done"
  end

  def insert_location_mgrs_20141215
    user_datas = [
      {:last_name => "Gonzalez", :first_name => "Natalie", :sunet_id => "nmgonzal", :email => "nmgonzal@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Grace", :first_name => "Mikaela", :sunet_id => "mgrace", :email => "mgrace@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Gussman", :first_name => "Sam", :sunet_id => "sgussman", :email => "sgussman@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Leff", :first_name => "Cody", :sunet_id => "codyml", :email => "codyml@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Petok", :first_name => "Jack", :sunet_id => "jpetok", :email => "jpetok@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Sienczewski", :first_name => "Victoria", :sunet_id => "vsiencze", :email => "vsiencze@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Simon", :first_name => "Matt", :sunet_id => "mwsimon", :email => "mwsimon@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Szafer", :first_name => "Dafna", :sunet_id => "dszafer", :email => "dszafer@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Weiss", :first_name => "Natasha", :sunet_id => "ntweiss", :email => "ntweiss@stanford.edu", :location_name => "576 Alvarado", :status => "Student"},
      {:last_name => "Charles", :first_name => "Michele", :sunet_id => "charles3", :email => "charles3@stanford.edu", :location_name => "680 Lomita", :status => "Student"},
      {:last_name => "Faulk", :first_name => "Megan", :sunet_id => "mfaulk", :email => "mfaulk@stanford.edu", :location_name => "680 Lomita", :status => "Student"},
      {:last_name => "Isford", :first_name => "Lauryn", :sunet_id => "ljisford", :email => "ljisford@stanford.edu", :location_name => "680 Lomita", :status => "Student"},
      {:last_name => "Kader", :first_name => "Hussain", :sunet_id => "hkader", :email => "hkader@stanford.edu", :location_name => "680 Lomita", :status => "Student"},
      {:last_name => "Roycroft", :first_name => "Scott", :sunet_id => "scottr5", :email => "scottr5@stanford.edu", :location_name => "680 Lomita", :status => "Student"},
      {:last_name => "Ama", :first_name => "Julia", :sunet_id => "ju9ama", :email => "ju9ama@stanford.edu", :location_name => "717 Dolores", :status => "Student"},
      {:last_name => "Boslough", :first_name => "Anna", :sunet_id => "boslough", :email => "boslough@stanford.edu", :location_name => "717 Dolores", :status => "Student"},
      {:last_name => "Nakashima", :first_name => "Kalani", :sunet_id => "kalaniy", :email => "kalaniy@stanford.edu", :location_name => "717 Dolores", :status => "Student"},
      {:last_name => "Nelsen", :first_name => "Daniel", :sunet_id => "dnelsen", :email => "dnelsen@stanford.edu", :location_name => "717 Dolores", :status => "Student"},
      {:last_name => "Toothman", :first_name => "Katie", :sunet_id => "ktooth", :email => "ktooth@stanford.edu", :location_name => "717 Dolores", :status => "Student"},
      {:last_name => "Camp", :first_name => "Daniel", :sunet_id => "dmcamp", :email => "dmcamp@stanford.edu", :location_name => "BOB", :status => "Student"},
      {:last_name => "Cohen", :first_name => "Benjamin", :sunet_id => "bmcohen", :email => "bmcohen@stanford.edu", :location_name => "BOB", :status => "Student"},
      {:last_name => "Dey", :first_name => "Monica", :sunet_id => "mdey1", :email => "mdey1@stanford.edu", :location_name => "BOB", :status => "Student"},
      {:last_name => "Morrison", :first_name => "Bridget", :sunet_id => "bmo425", :email => "bmo425@stanford.edu", :location_name => "BOB", :status => "Student"},
      {:last_name => "Oro", :first_name => "Aaron", :sunet_id => "aaronoro", :email => "aaronoro@stanford.edu", :location_name => "BOB", :status => "Student"},
      {:last_name => "French-Owen", :first_name => "Darien", :sunet_id => "darienfo", :email => "darienfo@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Grinberg", :first_name => "Josh", :sunet_id => "jgrinber", :email => "jgrinber@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Jiang", :first_name => "Jimmy", :sunet_id => "jfjiang", :email => "jfjiang@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Kramon", :first_name => "Katie", :sunet_id => "ckramon", :email => "ckramon@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Prochnow", :first_name => "Bo", :sunet_id => "bprochno", :email => "bprochno@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Quinones", :first_name => "Amber", :sunet_id => "amberq", :email => "amberq@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Sides", :first_name => "Maddy", :sunet_id => "msides", :email => "msides@stanford.edu", :location_name => "Columbae", :status => "Student"},
      {:last_name => "Ashby", :first_name => "Erin", :sunet_id => "eashby", :email => "eashby@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Hancock", :first_name => "Betty", :sunet_id => "hancock3", :email => "hancock3@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Schmitz", :first_name => "Julia", :sunet_id => "schmitzj", :email => "schmitzj@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Stoeckle", :first_name => "Nellie", :sunet_id => "nellies", :email => "nellies@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Watson", :first_name => "Paige", :sunet_id => "pwatson", :email => "pwatson@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Yu", :first_name => "April", :sunet_id => "aprilyu", :email => "aprilyu@stanford.edu", :location_name => "Delta Delta Delta", :status => "Student"},
      {:last_name => "Duan", :first_name => "Jessie", :sunet_id => "duan1", :email => "jduan1@stanford.edu", :location_name => "Durand", :status => "Student"},
      {:last_name => "Lagalante", :first_name => "Louis", :sunet_id => "lagalant", :email => "lagalant@stanford.edu", :location_name => "Durand", :status => "Student"},
      {:last_name => "Smith", :first_name => "Kierstyn", :sunet_id => "ksmith7", :email => "ksmith7@stanford.edu", :location_name => "Durand", :status => "Student"},
      {:last_name => "Sun", :first_name => "Lingtong", :sunet_id => "lsun569", :email => "lsun569@stanford.edu", :location_name => "Durand", :status => "Student"},
      {:last_name => "Yelizarova", :first_name => "Anna", :sunet_id => "hannay", :email => "hannay@stanford.edu", :location_name => "Durand", :status => "Student"},
      {:last_name => "Buchsbaum", :first_name => "Alison", :sunet_id => "alison16", :email => "alison16@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Dreyer", :first_name => "Amelia", :sunet_id => "adreyer", :email => "adreyer@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Gamo", :first_name => "Eri", :sunet_id => "egamo", :email => "egamo@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Hamilton", :first_name => "Will", :sunet_id => "wjlham91", :email => "wjlham91@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Howard", :first_name => "Imani", :sunet_id => "ihoward", :email => "ihoward@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Schmidt", :first_name => "Lina", :sunet_id => "lina93", :email => "lina93@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Simon", :first_name => "Harry", :sunet_id => "hasimon", :email => "hasimon@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Thiemann", :first_name => "Henry", :sunet_id => "henryat", :email => "henryat@stanford.edu", :location_name => "EBF", :status => "Student"},
      {:last_name => "Biedry", :first_name => "Rob", :sunet_id => "rbiedry", :email => "rbiedry@stanford.edu", :location_name => "Grove", :status => "Student"},
      {:last_name => "Franklin", :first_name => "Rob", :sunet_id => "robfrank", :email => "robfrank@stanford.edu", :location_name => "Grove", :status => "Student"},
      {:last_name => "Jacobs", :first_name => "Simone", :sunet_id => "simonej", :email => "simonej@stanford.edu", :location_name => "Grove", :status => "Student"},
      {:last_name => "Rabinovich", :first_name => "Michael", :sunet_id => "mrabinov", :email => "mrabinov@stanford.edu", :location_name => "Grove", :status => "Student"},
      {:last_name => "Sekhri", :first_name => "Aaron", :sunet_id => "asekhri", :email => "asekhri@stanford.edu", :location_name => "Grove", :status => "Student"},
      {:last_name => "Leal", :first_name => "Christian", :sunet_id => "cleal93", :email => "cleal93@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Michelson", :first_name => "Kyle", :sunet_id => "kylem3", :email => "kylem3@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Nader", :first_name => "Sarah", :sunet_id => "snader2", :email => "snader2@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Sayiner", :first_name => "Sibel", :sunet_id => "ssayiner", :email => "ssayiner@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Spielberg Verdejo", :first_name => "Victor", :sunet_id => "victor15", :email => "victor15@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Topasna", :first_name => "Joseph", :sunet_id => "jtopasna", :email => "jtopasna@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Wambersie", :first_name => "Leopold", :sunet_id => "leopoldw", :email => "leopoldw@stanford.edu", :location_name => "Hammarskjold", :status => "Student"},
      {:last_name => "Axler", :first_name => "Ariella", :sunet_id => "aaxler", :email => "aaxler@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Fitzpatrick", :first_name => "Haley", :sunet_id => "haleyf", :email => "haleyf@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Jacoby", :first_name => "Mackenzie", :sunet_id => "mjacoby", :email => "mjacoby@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Kolb", :first_name => "Kathryn", :sunet_id => "kkolb", :email => "kkolb@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Lieberman", :first_name => "Erica", :sunet_id => "ericakl", :email => "ericakl@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Scott", :first_name => "Sean", :sunet_id => "stscott", :email => "stscott@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Wang", :first_name => "Peter", :sunet_id => "xywang", :email => "freezing@stanford.edu", :location_name => "Haus Mitteleuropa", :status => "Student"},
      {:last_name => "Alifimoff", :first_name => "Alex", :sunet_id => "aja2015", :email => "aja2015@stanford.edu", :location_name => "Jerry", :status => "Student"},
      {:last_name => "CserAcpy", :first_name => "Nicolas", :sunet_id => "cserepy", :email => "cserepy@stanford.edu", :location_name => "Jerry", :status => "Student"},
      {:last_name => "Gage", :first_name => "Megan", :sunet_id => "mlgage", :email => "mlgage@stanford.edu", :location_name => "Jerry", :status => "Student"},
      {:last_name => "Kurohara", :first_name => "Megan", :sunet_id => "kurohara", :email => "kurohara@stanford.edu", :location_name => "Jerry", :status => "Student"},
      {:last_name => "Rosay", :first_name => "Alex", :sunet_id => "arosay", :email => "arosay@stanford.edu", :location_name => "Jerry", :status => "Student"},
      {:last_name => "Atkinson", :first_name => "Tracey", :sunet_id => "traceya", :email => "traceya@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Ball", :first_name => "Frances", :sunet_id => "fball", :email => "fball@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Leonardo", :first_name => "Jenna", :sunet_id => "jennaleo", :email => "jennaleo@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Leonardo", :first_name => "Jenna", :sunet_id => "jennaleo", :email => "jennaleo@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Ramos", :first_name => "Lazara", :sunet_id => "lazarar", :email => "lazarar@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Rosenthal", :first_name => "Noam", :sunet_id => "nrose", :email => "nrose@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Tindall", :first_name => "Nathan", :sunet_id => "ntindall", :email => "ntindall@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Walendom", :first_name => "Laetitia", :sunet_id => "walendom", :email => "walendom@stanford.edu", :location_name => "Kairos", :status => "Student"},
      {:last_name => "Carey", :first_name => "Austin", :sunet_id => "acarey", :email => "acarey@stanford.edu", :location_name => "Kappa Alpha", :status => "Student"},
      {:last_name => "English", :first_name => "Keegan", :sunet_id => "kengli", :email => "kengli@stanford.edu", :location_name => "Kappa Alpha", :status => "Student"},
      {:last_name => "Grafentin", :first_name => "Grant", :sunet_id => "ggraf", :email => "ggraf@stanford.edu", :location_name => "Kappa Alpha", :status => "Student"},
      {:last_name => "Moroney", :first_name => "Kyle", :sunet_id => "kmoroney", :email => "kmoroney@stanford.edu", :location_name => "Kappa Alpha", :status => "Student"},
      {:last_name => "Crist", :first_name => "Mackenzie", :sunet_id => "mcrist", :email => "mcrist@stanford.edu", :location_name => "Kappa Alpha Theta", :status => "Student"},
      {:last_name => "Gold", :first_name => "Becca", :sunet_id => "rgold25", :email => "rgold25@stanford.edu", :location_name => "Kappa Alpha Theta", :status => "Student"},
      {:last_name => "Johnson", :first_name => "Olivia", :sunet_id => "oliviaj", :email => "oliviaj@stanford.edu", :location_name => "Kappa Alpha Theta", :status => "Student"},
      {:last_name => "Kirk", :first_name => "Haley", :sunet_id => "hkirk1", :email => "hkirk1@stanford.edu", :location_name => "Kappa Alpha Theta", :status => "Student"},
      {:last_name => "Sivaram", :first_name => "Uttara", :sunet_id => "usiv", :email => "usiv@stanford.edu", :location_name => "Kappa Alpha Theta", :status => "Student"},
      {:last_name => "Bakst", :first_name => "JB", :sunet_id => "jbakst", :email => "jbakst@stanford.edu", :location_name => "Kappa Sigma", :status => "Student"},
      {:last_name => "Ellison", :first_name => "Zach", :sunet_id => "zellison", :email => "zellison@stanford.edu", :location_name => "Kappa Sigma", :status => "Student"},
      {:last_name => "Giglio", :first_name => "Josh", :sunet_id => "jdgiglio", :email => "jdgiglio@stanford.edu", :location_name => "Kappa Sigma", :status => "Student"},
      {:last_name => "Grover", :first_name => "Alex", :sunet_id => "ajgrover", :email => "ajgrover@stanford.edu", :location_name => "Kappa Sigma", :status => "Student"},
      {:last_name => "Mercer", :first_name => "Samuel", :sunet_id => "sjmercer", :email => "sjmercer@stanford.edu", :location_name => "Kappa Sigma", :status => "Student"},
      {:last_name => "Culler", :first_name => "McKenzie", :sunet_id => "mculler", :email => "mculler@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Cussen", :first_name => "Laura", :sunet_id => "lcussen", :email => "lcussen@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Geo", :first_name => "Ashley", :sunet_id => "ageo", :email => "ageo@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Glasser", :first_name => "Annabah", :sunet_id => "aglasser", :email => "aglasser@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Henri", :first_name => "Pearson", :sunet_id => "phenri", :email => "phenri@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Knapp", :first_name => "Daniel", :sunet_id => "dknapp1", :email => "dknapp1@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Malloy", :first_name => "Dylan", :sunet_id => "dylanm", :email => "dylanm@stanford.edu", :location_name => "La Casa Italiana", :status => "Student"},
      {:last_name => "Cornman", :first_name => "Naomi", :sunet_id => "ncornman", :email => "ncornman@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Le Roux", :first_name => "Alex", :sunet_id => "afleroux", :email => "afleroux@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Martinez", :first_name => "Maria", :sunet_id => "mariam6", :email => "mariam6@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Seira Silva-Herzog", :first_name => "Santiago", :sunet_id => "sseira", :email => "sseira@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Shapiro", :first_name => "Jordan", :sunet_id => "jordansh", :email => "jordansh@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Thakur", :first_name => "Natalya", :sunet_id => "nthakur9", :email => "nthakur9@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Vela", :first_name => "Michael", :sunet_id => "mhvela1", :email => "mhvela1@stanford.edu", :location_name => "La Maison Francaise", :status => "Student"},
      {:last_name => "Hohn", :first_name => "Trevor", :sunet_id => "thohn", :email => "thohn@stanford.edu", :location_name => "Mars", :status => "Student"},
      {:last_name => "Marincola", :first_name => "Rachel", :sunet_id => "rcola", :email => "rcola@stanford.edu", :location_name => "Mars", :status => "Student"},
      {:last_name => "Melton", :first_name => "Stu", :sunet_id => "smelton", :email => "smelton@stanford.edu", :location_name => "Mars", :status => "Student"},
      {:last_name => "Torres", :first_name => "Walter", :sunet_id => "waltert", :email => "waltert@stanford.edu", :location_name => "Mars", :status => "Student"},
      {:last_name => "Xu", :first_name => "Nick", :sunet_id => "nickxu", :email => "nickxu@stanford.edu", :location_name => "Mars", :status => "Student"},
      {:last_name => "Cammers-Goodwin", :first_name => "Sage", :sunet_id => "sageis", :email => "sageis@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Chatoor", :first_name => "Nehan", :sunet_id => "nchatoor", :email => "nchatoor@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Kaopuiki", :first_name => "Jana", :sunet_id => "janak", :email => "janak@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Lee", :first_name => "Awapuhi", :sunet_id => "awapuhil", :email => "awapuhil@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Wood", :first_name => "Alexis", :sunet_id => "amw00d", :email => "amw00d@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Yaghi", :first_name => "Alia", :sunet_id => "ayaghi", :email => "ayaghi@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Zhao", :first_name => "Michelle", :sunet_id => "mzhao94", :email => "mzhao94@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Student"},
      {:last_name => "Bowechop", :first_name => "Evan", :sunet_id => "bowechop", :email => "bowechop@stanford.edu", :location_name => "Narnia", :status => "Student"},
      {:last_name => "Grundman", :first_name => "Emily", :sunet_id => "emgrund", :email => "emgrund@stanford.edu", :location_name => "Narnia", :status => "Student"},
      {:last_name => "Shepard", :first_name => "Steven", :sunet_id => "shepard7", :email => "shepard7@stanford.edu", :location_name => "Narnia", :status => "Student"},
      {:last_name => "Walker", :first_name => "Quinn", :sunet_id => "qvwalker", :email => "qvwalker@stanford.edu", :location_name => "Narnia", :status => "Student"},
      {:last_name => "Weiss", :first_name => "Nathalie", :sunet_id => "nsweiss", :email => "nsweiss@stanford.edu", :location_name => "Narnia", :status => "Student"},
      {:last_name => "Ferrante", :first_name => "Joseph", :sunet_id => "jferr11", :email => "jferr11@stanford.edu", :location_name => "Phi Kappa Psi", :status => "Student"},
      {:last_name => "Ing", :first_name => "Colby", :sunet_id => "colbying", :email => "colbying@stanford.edu", :location_name => "Phi Kappa Psi", :status => "Student"},
      {:last_name => "Liu", :first_name => "Tony", :sunet_id => "tdliu", :email => "tdliu@stanford.edu", :location_name => "Phi Kappa Psi", :status => "Student"},
      {:last_name => "Rogers", :first_name => "Lawrence", :sunet_id => "lxrogers", :email => "lxrogers@stanford.edu", :location_name => "Phi Kappa Psi", :status => "Student"},
      {:last_name => "Sanches", :first_name => "Jordan", :sunet_id => "jsanches", :email => "jsanches@stanford.edu", :location_name => "Phi Kappa Psi", :status => "Student"},
      {:last_name => "Cook", :first_name => "Jack", :sunet_id => "jgacook", :email => "jgacook@stanford.edu", :location_name => "Phi Sig", :status => "Student"},
      {:last_name => "Davis", :first_name => "Dicarlos", :sunet_id => "ddavis4", :email => "ddavis4@stanford.edu", :location_name => "Phi Sig", :status => "Student"},
      {:last_name => "Fischer", :first_name => "Meredith", :sunet_id => "mfische2", :email => "mfische2@stanford.edu", :location_name => "Phi Sig", :status => "Student"},
      {:last_name => "Li", :first_name => "Sabrina", :sunet_id => "sli668", :email => "sli668@stanford.edu", :location_name => "Phi Sig", :status => "Student"},
      {:last_name => "Richter", :first_name => "Brady", :sunet_id => "bradyr1", :email => "bradyr1@stanford.edu", :location_name => "Phi Sig", :status => "Student"},
      {:last_name => "Bechler", :first_name => "Katelyn", :sunet_id => "kbechler", :email => "kbechler@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Kofman", :first_name => "Nicole", :sunet_id => "nkofman", :email => "nkofman@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Makonnen", :first_name => "Tamara", :sunet_id => "tmakon", :email => "tmakon@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Margolis", :first_name => "Claire", :sunet_id => "claiream", :email => "claiream@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Rosenblatt", :first_name => "Tatiana", :sunet_id => "tatianar", :email => "tatianar@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Urban", :first_name => "Natalie", :sunet_id => "nurban", :email => "nurban@stanford.edu", :location_name => "Pi Beta Phi", :status => "Student"},
      {:last_name => "Bacon", :first_name => "Kimberly", :sunet_id => "kabacon", :email => "kabacon@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Basnett", :first_name => "Kaitlyn", :sunet_id => "katybeee", :email => "katybeee@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Berkenkamp", :first_name => "Jenna", :sunet_id => "jberken", :email => "jberken@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Brockbank", :first_name => "Amanda", :sunet_id => "amandab7", :email => "amandab7@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Lupone", :first_name => "Eliza", :sunet_id => "elupone", :email => "elupone@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Pascual", :first_name => "Natalia", :sunet_id => "npascual", :email => "npascual@stanford.edu", :location_name => "Roth", :status => "Student"},
      {:last_name => "Jackson", :first_name => "Drew", :sunet_id => "djacks", :email => "djacks@stanford.edu", :location_name => "Sigma Alpha Epsilon", :status => "Student"},
      {:last_name => "Kerr", :first_name => "Charlie", :sunet_id => "ckerr", :email => "ckerr@stanford.edu", :location_name => "Sigma Alpha Epsilon", :status => "Student"},
      {:last_name => "Khosla", :first_name => "Neal", :sunet_id => "nealk", :email => "nealk@stanford.edu", :location_name => "Sigma Alpha Epsilon", :status => "Student"},
      {:last_name => "Represas", :first_name => "Diego", :sunet_id => "diegorep", :email => "diegorep@stanford.edu", :location_name => "Sigma Alpha Epsilon", :status => "Student"},
      {:last_name => "Stineman", :first_name => "Robert", :sunet_id => "stinemar", :email => "stinemar@stanford.edu", :location_name => "Sigma Alpha Epsilon", :status => "Student"},
      {:last_name => "Abundes", :first_name => "Nino", :sunet_id => "aabundes", :email => "aabundes@stanford.edu", :location_name => "Sigma Chi", :status => "Student"},
      {:last_name => "Becerra", :first_name => "Daniel", :sunet_id => "dbecerra", :email => "dbecerra@stanford.edu", :location_name => "Sigma Chi", :status => "Student"},
      {:last_name => "Lenahan", :first_name => "Keven", :sunet_id => "klenahan", :email => "klenahan@stanford.edu", :location_name => "Sigma Chi", :status => "Student"},
      {:last_name => "Rosellini", :first_name => "Ben", :sunet_id => "bdrose", :email => "bdrose@stanford.edu", :location_name => "Sigma Nu", :status => "Student"},
      {:last_name => "Sanzovo", :first_name => "Pedro Henrique", :sunet_id => "sanzovo", :email => "sanzovo@stanford.edu", :location_name => "Sigma Nu", :status => "Student"},
      {:last_name => "St. Amant", :first_name => "Will", :sunet_id => "saint", :email => "saint@stanford.edu", :location_name => "Sigma Nu", :status => "Student"},
      {:last_name => "Uba", :first_name => "Uche", :sunet_id => "ucheuba", :email => "ucheuba@stanford.edu", :location_name => "Sigma Nu", :status => "Student"},
      {:last_name => "Yang", :first_name => "Chris", :sunet_id => "cyang2", :email => "cyang2@stanford.edu", :location_name => "Sigma Nu", :status => "Student"},
      {:last_name => "Ciurea Ilcus", :first_name => "Silviana", :sunet_id => "smci", :email => "smci@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Empinotti", :first_name => "Gustavo", :sunet_id => "gustavoe", :email => "gustavoe@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Ho", :first_name => "Lana", :sunet_id => "lanaho", :email => "lanaho@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Johnson", :first_name => "Max", :sunet_id => "maxj15", :email => "maxj15@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Randall", :first_name => "Lucy", :sunet_id => "lucyr1", :email => "lucyr1@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Weiler", :first_name => "Gideon", :sunet_id => "gweiler", :email => "gweiler@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Wilcox", :first_name => "Ethan", :sunet_id => "wilcoxeg", :email => "wilcoxeg@stanford.edu", :location_name => "Slavianskii Dom", :status => "Student"},
      {:last_name => "Cervantes", :first_name => "Rocco", :sunet_id => "roccoc", :email => "roccoc@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "Chen", :first_name => "Matthew", :sunet_id => "mchenja", :email => "mchenja@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "Greenberg", :first_name => "Gabi", :sunet_id => "gdg", :email => "gdg@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "Heng", :first_name => "Wei Ling", :sunet_id => "wlheng", :email => "wlheng@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "Kadavy", :first_name => "Alison", :sunet_id => "amkadavy", :email => "amkadavy@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "McKenzie", :first_name => "Costner", :sunet_id => "costnerm", :email => "costnerm@stanford.edu", :location_name => "Storey", :status => "Student"},
      {:last_name => "Barazani", :first_name => "Sharon", :sunet_id => "macaroni", :email => "macaroni@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Hanissian", :first_name => "Alise", :sunet_id => "aliseh", :email => "aliseh@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Laux", :first_name => "Cody", :sunet_id => "claux", :email => "claux@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Munoz", :first_name => "Julian", :sunet_id => "jmunoz1", :email => "jmunoz1@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Qin", :first_name => "Kenneth", :sunet_id => "kqin", :email => "kqin@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Sangani", :first_name => "Kunal", :sunet_id => "ksangani", :email => "ksangani@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Twarzynski", :first_name => "Marek", :sunet_id => "marekt", :email => "marekt@stanford.edu", :location_name => "Synergy", :status => "Student"},
      {:last_name => "Gulati", :first_name => "Sukhi", :sunet_id => "sgulati3", :email => "sgulati3@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Lopez", :first_name => "MaryJo", :sunet_id => "mjolopez", :email => "mjolopez@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Morris", :first_name => "Sean", :sunet_id => "smorris3", :email => "smorris3@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Oneal", :first_name => "Owen", :sunet_id => "ooneal", :email => "ooneal@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Pancoast", :first_name => "Darcey", :sunet_id => "darceyp", :email => "darceyp@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Rodriguez Buchillon", :first_name => "Ruben", :sunet_id => "rubenr2", :email => "rubenr2@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Shumate", :first_name => "Alaina", :sunet_id => "ashumate", :email => "ashumate@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Stein", :first_name => "Andrea", :sunet_id => "astein2", :email => "astein2@stanford.edu", :location_name => "Terra", :status => "Student"},
      {:last_name => "Friedler", :first_name => "Jake", :sunet_id => "friedler", :email => "friedler@stanford.edu", :location_name => "Theta Delta Chi", :status => "Student"},
      {:last_name => "Holden", :first_name => "Aaron", :sunet_id => "aholden", :email => "aholden@stanford.edu", :location_name => "Theta Delta Chi", :status => "Student"},
      {:last_name => "MuAoz", :first_name => "Marcus", :sunet_id => "mtmunoz", :email => "mtmunoz@stanford.edu", :location_name => "Theta Delta Chi", :status => "Student"},
      {:last_name => "Winston", :first_name => "Johnny", :sunet_id => "jwinston", :email => "jwinston@stanford.edu", :location_name => "Theta Delta Chi", :status => "Student"},
      {:last_name => "Young", :first_name => "Jake", :sunet_id => "jryoung", :email => "jryoung@stanford.edu", :location_name => "Theta Delta Chi", :status => "Student"},
      {:last_name => "Lerch", :first_name => "Aileen", :sunet_id => "alerch", :email => "alerch@stanford.edu", :location_name => "Xanadu", :status => "Student"},
      {:last_name => "Ma", :first_name => "George", :sunet_id => "ghma", :email => "ghma@stanford.edu", :location_name => "Xanadu", :status => "Student"},
      {:last_name => "Martin", :first_name => "Charlotte", :sunet_id => "cemartin", :email => "cemartin@stanford.edu", :location_name => "Xanadu", :status => "Student"},
      {:last_name => "Santiago", :first_name => "Estevan", :sunet_id => "esantiag", :email => "esantiag@stanford.edu", :location_name => "Xanadu", :status => "Student"},
      {:last_name => "Schumacher", :first_name => "Ryan", :sunet_id => "schumy", :email => "schumy@stanford.edu", :location_name => "Xanadu", :status => "Student"},
      {:last_name => "Katabarwa", :first_name => "Abaho", :sunet_id => "abaho", :email => "abaho@stanford.edu", :location_name => "ZAP", :status => "Student"},
      {:last_name => "Luu", :first_name => "Natalie", :sunet_id => "nluu", :email => "nluu@stanford.edu", :location_name => "ZAP", :status => "Student"},
      {:last_name => "Perez", :first_name => "Hector", :sunet_id => "hec2011", :email => "hec2011@stanford.edu", :location_name => "ZAP", :status => "Student"},
      {:last_name => "Tecklu", :first_name => "Nahva", :sunet_id => "ntecklu", :email => "ntecklu@stanford.edu", :location_name => "ZAP", :status => "Student"},
      {:last_name => "Theis", :first_name => "Eric", :sunet_id => "ertheis", :email => "ertheis@stanford.edu", :location_name => "ZAP", :status => "Student"},
      {:last_name => "Schnaubelt", :first_name => "Thomas", :sunet_id => "thomasjs", :email => "thomas.schnaubelt@stanford.edu", :location_name => "Branner", :status => "Staff"},
      {:last_name => "Schnaubelt", :first_name => "Mary Esther", :sunet_id => "meschnau", :email => "meschnau@stanford.edu", :location_name => "Branner", :status => "Staff"},
      {:last_name => "Eberle", :first_name => "Stephanie", :sunet_id => "seberle", :email => "seberle@stanford.edu", :location_name => "Burbank", :status => "Staff"},
      {:last_name => "Randolph", :first_name => "Jason", :sunet_id => "jrand", :email => "jrand@stanford.edu", :location_name => "Casa Zapata", :status => "Staff"},
      {:last_name => "Randolph", :first_name => "Joanne", :sunet_id => "jorand", :email => "joaneeg68@yahoo.com", :location_name => "Casa Zapata", :status => "Staff"},
      {:last_name => "Jones", :first_name => "James Holland", :sunet_id => "jhj1", :email => "jhj1@stanford.edu", :location_name => "Castano", :status => "Staff"},
      {:last_name => "Hilde", :first_name => "Libra", :sunet_id => "lhilde", :email => "lhilde@stanford.edu", :location_name => "Castano", :status => "Staff"},
      {:last_name => "Grimmer", :first_name => "Justin", :sunet_id => "jgrimmer", :email => "jgrimmer@stanford.edu", :location_name => "Cedro", :status => "Staff"},
      {:last_name => "Grimmer", :first_name => "Terese", :sunet_id => "tgrimmer", :email => "tgrimmer@stanford.edu", :location_name => "Cedro", :status => "Staff"},
      {:last_name => "Stedman", :first_name => "Stephen", :sunet_id => "sstedman", :email => "sstedman@stanford.edu", :location_name => "Crothers", :status => "Staff"},
      {:last_name => "Thomas", :first_name => "Corinne", :sunet_id => "corrine1", :email => "corinnethomas@stanford.edu", :location_name => "Crothers", :status => "Staff"},
      {:last_name => "Paulson", :first_name => "Linda", :sunet_id => "lapulson", :email => "lpaulson@stanford.edu", :location_name => "Donner", :status => "Staff"},
      {:last_name => "Antonio", :first_name => "Anthony lising", :sunet_id => "aantonio", :email => "aantonio@stanford.edu", :location_name => "EAST", :status => "Staff"},
      {:last_name => "Wotipka", :first_name => "Christine Min", :sunet_id => "cwotipka", :email => "cwotipka@stanford.edu", :location_name => "EAST", :status => "Staff"},
      {:last_name => "Watkins", :first_name => "Greg", :sunet_id => "gwatkins", :email => "gwatkins@stanford.edu", :location_name => "East FloMo", :status => "Staff"},
      {:last_name => "Watkins", :first_name => "Susan", :sunet_id => "skw", :email => "skw@stanford.edu", :location_name => "East FloMo", :status => "Staff"},
      {:last_name => "Barron", :first_name => "Cisco", :sunet_id => "ciscobarron", :email => "ciscobarron@stanford.edu", :location_name => "FroSoCo", :status => "Staff"},
      {:last_name => "Woltman", :first_name => "LaCona", :sunet_id => "lwoltmon", :email => "lwoltmon@stanford.edu", :location_name => "FroSoCo", :status => "Staff"},
      {:last_name => "Brown", :first_name => "Bryan", :sunet_id => "brbrown", :email => "brbrown@stanford.edu", :location_name => "FroSoCo", :status => "Staff"},
      {:last_name => "Brown", :first_name => "Cheryl", :sunet_id => "cbrown4", :email => "cheryl.brown@stanford.edu", :location_name => "FroSoCo", :status => "Staff"},
      {:last_name => "Kelman", :first_name => "Ari", :sunet_id => "aykelman", :email => "aykelman@stanford.edu", :location_name => "Junipero", :status => "Staff"},
      {:last_name => "Jordan", :first_name => "Eva", :sunet_id => "eclairej", :email => "eclairejordan@yahoo.com", :location_name => "Junipero", :status => "Staff"},
      {:last_name => "Todhunter", :first_name => "Andrew", :sunet_id => "todhuntr", :email => "andrew.todhunter@stanford.edu", :location_name => "Kimball", :status => "Staff"},
      {:last_name => "Todhunter", :first_name => "Erin", :sunet_id => "etodhunt", :email => "erin.todhunter@gmail.com", :location_name => "Kimball", :status => "Staff"},
      {:last_name => "Lummus", :first_name => "David", :sunet_id => "dlummus", :email => "dlummus@stanford.edu", :location_name => "La Casa Italiana", :status => "Staff"},
      {:last_name => "Flink", :first_name => "Chris", :sunet_id => "cflink", :email => "cflink@stanford.edu", :location_name => "Lantana", :status => "Staff"},
      {:last_name => "Flink", :first_name => "Lauren", :sunet_id => "lflink", :email => "lauren@twilightrodeo.com", :location_name => "Lantana", :status => "Staff"},
      {:last_name => "Hanlon", :first_name => "Patti", :sunet_id => "Hanlon", :email => "hanlon@stanford.edu", :location_name => "Larkin", :status => "Staff"},
      {:last_name => "Baker", :first_name => "Geoff", :sunet_id => "glbaker", :email => "glbaker@stanford.edu", :location_name => "Larkin", :status => "Staff"},
      {:last_name => "Hughes", :first_name => "Solomon", :sunet_id => "syhughes", :email => "syhughes@stanford.edu", :location_name => "Mirrielees", :status => "Staff"},
      {:last_name => "Snipp", :first_name => "Matthew", :sunet_id => "snipp", :email => "snipp@stanford.edu", :location_name => "Murray", :status => "Staff"},
      {:last_name => "Blake", :first_name => "Ray", :sunet_id => "rayblake", :email => "rayblake@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Staff"},
      {:last_name => "Hixson-Blake", :first_name => "Shoney", :sunet_id => "missann", :email => "missann@stanford.edu", :location_name => "Muwekma-Tah-Ruk", :status => "Staff"},
      {:last_name => "Prieto", :first_name => "Elvira", :sunet_id => "vira", :email => "vira@stanford.edu", :location_name => "Naranja", :status => "Staff"},
      {:last_name => "Edelstein", :first_name => "Dan", :sunet_id => "danedels", :email => "danedels@stanford.edu", :location_name => "New Manz", :status => "Staff"},
      {:last_name => "Bower", :first_name => "Zoe", :sunet_id => "zbower", :email => "zbower@stanford.edu", :location_name => "New Manz", :status => "Staff"},
      {:last_name => "Wu Nguyen", :first_name => "Edith", :sunet_id => "edithwu", :email => "edithwu@stanford.edu", :location_name => "Oak Creek", :status => "Staff"},
      {:last_name => "Nguyen", :first_name => "John", :sunet_id => "nguyenj", :email => "jnguyen@informatica.com", :location_name => "Oak Creek", :status => "Staff"},
      {:last_name => "Takemoto", :first_name => "Anne", :sunet_id => "annet", :email => "annet@stanford.edu", :location_name => "Okada", :status => "Staff"},
      {:last_name => "Herman", :first_name => "Luciana", :sunet_id => "lherman", :email => "lherman@stanford.edu", :location_name => "Otero", :status => "Staff"},
      {:last_name => "Malone", :first_name => "Phillip", :sunet_id => "pmalone", :email => "pmalone@law.stanford.edu", :location_name => "Otero", :status => "Staff"},
      {:last_name => "Quill", :first_name => "Jazmin", :sunet_id => "quill", :email => "quill@stanford.edu", :location_name => "Potter", :status => "Staff"},
      {:last_name => "Quill", :first_name => "Lawrence", :sunet_id => "lquill", :email => "lawrence.quill@sjsu.edu", :location_name => "Potter", :status => "Staff"},
      {:last_name => "Hughes", :first_name => "Solomon", :sunet_id => "syhughes", :email => "syhughes@stanford.edu", :location_name => "Rains", :status => "Staff"},
      {:last_name => "Klein", :first_name => "Dan", :sunet_id => "kleinmp", :email => "kleinimp@stanford.edu", :location_name => "Rinconada", :status => "Staff"},
      {:last_name => "Darby", :first_name => "Michelle", :sunet_id => "mdarby", :email => "mdarby@stanford.edu", :location_name => "Rinconada", :status => "Staff"},
      {:last_name => "Parsonnet", :first_name => "Julie", :sunet_id => "parsonnt", :email => "parsonnt@stanford.edu", :location_name => "Robinson", :status => "Staff"},
      {:last_name => "Winslow", :first_name => "Dean", :sunet_id => "dwinslow", :email => "dwinslow@stanford.edu", :location_name => "Robinson", :status => "Staff"},
      {:last_name => "Ball", :first_name => "Jeffrey", :sunet_id => "jeffball", :email => "jeffball@stanford.edu", :location_name => "Roble", :status => "Staff"},
      {:last_name => "Bull", :first_name => "Becky", :sunet_id => "bbull", :email => "bbull@stanford.edu", :location_name => "Roble", :status => "Staff"},
      {:last_name => "Reininger", :first_name => "Michelle", :sunet_id => "reininge", :email => "reininge@stanford.edu", :location_name => "Serra", :status => "Staff"},
      {:last_name => "Berkelhamer", :first_name => "Adam", :sunet_id => "berkelha", :email => "berkelha@stanford.edu", :location_name => "Serra", :status => "Staff"},
      {:last_name => "Hughes", :first_name => "Solomon", :sunet_id => "syhughes", :email => "syhughes@stanford.edu", :location_name => "SubFree", :status => "Staff"},
      {:last_name => "Boswell", :first_name => "Nate", :sunet_id => "grak", :email => "grak@stanford.edu", :location_name => "Suites", :status => "Staff"},
      {:last_name => "Shiflett", :first_name => "Cole", :sunet_id => "shiflett", :email => "shiflett@stanford.edu", :location_name => "Suites", :status => "Staff"},
      {:last_name => "Parker", :first_name => "Grant", :sunet_id => "grbaker", :email => "grparker@stanford.edu", :location_name => "Toyon", :status => "Staff"},
      {:last_name => "Catsalis", :first_name => "Marie-Louise", :sunet_id => "mlcats", :email => "mlcats@stanford.edu", :location_name => "Toyon", :status => "Staff"},
      {:last_name => "Davidson", :first_name => "David", :sunet_id => "dfd", :email => "dfd@stanford.edu", :location_name => "Trancos", :status => "Staff"},
      {:last_name => "Davidson", :first_name => "Kornelia", :sunet_id => "kornelia", :email => "kornelia@stanford.edu", :location_name => "Trancos", :status => "Staff"},
      {:last_name => "Trehame", :first_name => "Elaine", :sunet_id => "treharne", :email => "treharne@stanford.edu", :location_name => "Twain", :status => "Staff"},
      {:last_name => "Fryett", :first_name => "Andy", :sunet_id => "FryettAndy", :email => "afryett@gigsky.com", :location_name => "Twain", :status => "Staff"},
      {:last_name => "Barker-Alexander", :first_name => "Jan", :sunet_id => "jbarker", :email => "jbarker@stanford.edu", :location_name => "Ujamaa", :status => "Staff"},
      {:last_name => "Alexander", :first_name => "Fred", :sunet_id => "alexande", :email => "alexander@stanford.edu", :location_name => "Ujamaa", :status => "Staff"},
      {:last_name => "Barton", :first_name => "John", :sunet_id => "jhbarton", :email => "jhbarton@stanford.edu", :location_name => "West FloMo", :status => "Staff"},
      {:last_name => "Tan", :first_name => "Lydia", :sunet_id => "lydiatan", :email => "lydia.tan@related.com", :location_name => "West FloMo", :status => "Staff"},
      {:last_name => "Kollmann", :first_name => "Nancy", :sunet_id => "kollmann", :email => "kollmann@stanford.edu", :location_name => "West Lag", :status => "Staff"},
      {:last_name => "Kollmann", :first_name => "Jack", :sunet_id => "kolljack", :email => "kolljack@stanford.edu", :location_name => "West Lag", :status => "Staff"},
      {:last_name => "Lit", :first_name => "Ira", :sunet_id => "iralit", :email => "iralit@stanford.edu", :location_name => "Yost", :status => "Staff"},
      {:last_name => "Choo", :first_name => "Jin", :sunet_id => "jinchoo", :email => "jinchoo@stanford.edu", :location_name => "Yost", :status => "Staff"},
    ]

    user_datas.each do |user_data|
      user = User.create(
        :year_id => 1,
        :first_name => user_data[:first_name],
        :last_name => user_data[:last_name],
        :status => user_data[:status],
        :email => user_data[:email],
        :sunet_id => user_data[:sunet_id],
      )
      location = Location.where(:procedure_id => 7, :name => user_data[:location_name]).first
      UserProcedure.create(:procedure_id => 7, :user_id => user.id) if user
      LocationMgr.create(:location_id => location.id, :user_id => user.id) if user && location
    end

    render :text => "Done"
  end

  def create_500_applicants
    people_soft_sunetids = ["jhsander", "gegdean", "vbrosen", "aadelson", "almcconn", "itam627", "dboxill", "aspinner", "aaarnold", "griechel", "lauras5", "ckhosh", "jlim3", "mbqhoang", "sgonzaga", "agarg5",
      "ertheis", "habaner0", "porme", "dchou1", "rwoodby", "njboyne", "sierraf", "vvirasin", "mpeterso", "lsneed1", "cbegay", "jdbenner", "jadef1", "jwon2014", "kaliado9", "iangd", "naguibs", "felipems",
      "mperez15", "czabel", "dokwon", "tomanmil", "limsk1", "chood", "jamesbui", "gcollins", "bharadr", "alepstei", "cmccaw", "stnguyen", "rupss", "grantdel", "asunny", "jetd121", "bjromero", "jake5",
      "maya1k", "cleduff", "tberbert", "alex15", "kls307", "ebullock", "chanten", "nparikh", "annaduan", "hganti", "joeld1", "annna", "dallalah", "eianklam", "joshlim3", "lvoller", "kluyken", "penuelas",
      "csalguer", "alorenzo", "lmccune", "cquan88", "ethong", "alxbaut7", "sanchez7", "lbourg7", "seanh2", "cjbillov", "jfjiang", "amw00d", "iiorozco", "rrkhan", "ivaylogb", "armando1", "chelseas", "aringlis",
      "ntl2015", "mjcarter", "balansay", "cjzchen7", "chalupnj", "dcolivo", "izzahfa", "nmiles", "mdiawara", "mdeloso", "acasalme", "jordanm1", "spratley", "kristab", "ccox13", "jma3", "kobiela", "gavilan",
      "kyliegoh", "rbiedry", "cghernan", "sstuteja", "rachenc", "kmoses", "crogers3", "ashleyh3", "amgonzal", "lediur", "kelly007", "rlogue", "ading93", "bmschow", "abarbe", "ajain93", "caitline", "erdohner",
      "gautamk", "katyasta", "ineylan", "jacklynt", "nhient", "dmcamp", "cmceache", "dhs", "erici", "ekfrey", "awang99", "josiec", "alyazzie", "ankitk", "sjmora11", "baffour", "bdusault", "shaurya", "hmessiha",
      "nwlim", "oscarb1", "nrich", "karanh", "abrinas", "yasamins", "chuynh", "ddindi", "ritikap", "luisrh93", "jpratt5", "mruizluz", "aholden", "kjabra", "cmlave", "caileenr", "ejoslyn", "naren10", "chiarab1",
      "tubbs", "jfrager", "lrumker", "lkadisha", "nicole21", "dmclaugh", "rjobs", "mkolsen", "annetran", "rcarrera", "linfield", "ssarpong", "garsengw", "mcuson", "dulcied", "kwyngard", "jharper2", "kquon",
      "adoll", "kmehr", "mesitz", "felipe92", "hkirk1", "birawan", "dzeng0", "ewalker5", "abd240", "nick310", "lindsay7", "mf486264", "shaydaz", "srkemper", "anisha15", "saravr", "kevin93", "stinemar",
      "eashby", "tdg4", "jyli", "hdtrione", "chaser", "keegango", "lvoconor", "alweiler", "aelder", "ahayes11", "nikhilp", "jennaleo", "nan7car", "nnunez", "sammy13", "jdubin", "lum", "alisonn", "vkalumbi",
      "mvt2412", "kkolb", "mlecompt", "wzyang", "ytarter", "amdenney", "rtai1", "shamikm", "rajabd93", "azerbe", "rcmurray", "snitta", "elevans", "shivant", "cmok", "lina93", "azannos", "sseira", "rwaltman",
      "kuanp", "nahamed", "bondserv", "vcalvara", "jthomp", "bauersa", "uomegara", "ggraf", "codyml", "jhuynh93", "joshuae", "dlbarba4", "rcola", "freezing", "mrotello", "jedtan", "oborge", "lsteyer",
      "bhigh15", "bgarcia7", "jr1", "follmann", "ccharris", "elliotw", "ponec", "ohuang", "mvitelli", "arch15", "rgold25", "bsung93", "rtran15", "abaho", "lwoody08", "rlargman", "bonbon41", "rebent",
      "ropeke", "yuana", "joezabel", "gerritym", "akma327", "elapin", "deorozco", "kbeckett", "mwenzlau", "echanen", "leahkim", "ahuerta1", "phamh", "gogododo", "hutch16", "mweekes", "margrave", "kmosle",
      "ghmeans", "kmoore10", "aacharya", "samfalk1", "somasheg", "hammoorb", "annawiet", "vhcliu", "mgolla", "kelsey2", "arjun2", "antonio0", "aandaya", "emma16", "caseycab", "paranhos", "anphan", "jegoldbe",
      "ataude", "edpark", "benpham", "anniek94", "alexer", "ejohns", "carata", "edanyliw", "ggomez2", "nlattanz", "kcwijaya", "gshuler", "cmmong", "issmythe", "kaiser13", "dsull", "ctroy1", "sylvies",
      "aj4194", "deniae", "wur911", "jaclynam", "abreed", "rdavies8", "aravento", "shhawkin", "zdammel", "nmbogdan", "millerjp", "rayna", "timothyl", "benina", "advika", "pshields", "enevill6", "bwittmer",
      "gtoal", "lkac", "devonz", "elvira13", "slock", "kmo51409", "tessbpm", "slaterm", "ewilson3", "mhorwi93", "rosco12", "bdiego", "jchishol", "aselvan", "ivannap", "noemi11", "mrpeters", "zachary4",
      "afiakhan", "ml1293", "cpapecal", "coreygar", "bbravo", "gideond", "aamieva", "rresma2", "mrector", "dylana", "mjfang", "ckisunzu", "balpers", "avardhan", "cstotz", "sammyst", "smg16", "nsprice",
      "cgowdy", "matthew4", "clairet", "brixu4", "lkinney", "cmay3249", "yardena", "mcarley3", "bakis", "tbreeden", "holmdahl", "klewis4", "jason2", "afrkovic", "fionamt", "alim16", "jennia44", "lucywang",
      "harine17", "kenleung", "amccorma", "mollyals", "cbernedo", "ccromero", "talimi", "igomez62", "tfreed", "jbradbur", "kjaggers", "hrlarry", "garrettc", "dgreif1", "khassey", "seokho", "claudia4",
      "demery", "cfrost16", "jmarch9", "aaustin", "nsyder", "oewong", "diegov2", "awesthem", "efabre", "arod2016", "ngurtler", "andrev", "bennett8", "mwhitmey", "audreym", "arh", "nickbud", "mlathrop",
      "lillianv", "ghyatt", "dodge", "rtsukey", "revanthk", "martinob", "nix19", "ebernal", "jlin5", "elboy", "slynn2", "kpfleege", "willydri", "dmelende", "alexk614", "hshaw", "jinpark9", "janetp2",
      "hansohl", "lori16", "dbeam", "rgrau", "pedp", "ali2", "minnal", "rmusa", "mherrero", "jwallach", "jaclin", "ryankkim", "odespo", "lilliao5", "toser", "siyou", "smcgorty", "robinz16", "jwu7",
      "valdest", "lolaltij", "myupa", "cmulemi", "ted107mk", "kathy2", "dmckim", "juanm95", "omargs10", "cqian", "clewis95", "guzmanj", "cartero", "tpham7", "anaordo1", "rlee7", "maurices", "kslee17",
      "klittle2", "mindyang", "ctobin17", "knneil", "kprom", "vramesh2", "jmorg", "emkehoe", "bclarkin", "eokhale", "farhank", "lbrenner"]

    i_year_id = Year.find_by_is_current_year(true).id
    people_soft_sunetids.each do |s_sunet_id|
      next if User.where(:sunet_id => s_sunet_id).present?
      client = get_people_soft(s_sunet_id);

      message = nil;
      begin
        message = client.get();
      rescue => e
        error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, applicant_get_people_soft, sunet_id: #{s_sunet_id}, error: #{e.to_json}"
        logger.error(error_msg)

        logger.error "e.message : #{e.message}";
        logger.error "e.backtrace : #{e.backtrace}";

        StanfordMailer.send_admin("System Error", error_msg).deliver
      end

      if (message)
        logger.info("# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create_user, stanford_SSL_saservice2_message #{message}");
        json_message = JSON.parse(message);
        httpStatusCode = json_message["httpStatusCode"];

        if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)
          # error
          # 1. httpStatusCode = 401: not an authorized.
          # 2. {"errorMessage":"System can not find the target student identified by bsun2"}

          error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create_user, get_people_soft fail"
          logger.error(error_msg)
          StanfordMailer.send_admin("System Error", error_msg).deliver
        else
          begin
            new_user = nil;

            first_name = json_message["firstName"];
            middle_name = json_message["middleName"];
            last_name = json_message["lastName"];
            suid = json_message["suid"];
            email = json_message["email"];
            sunet_id = json_message["sunetId"];
            gender = json_message["gender"];
            housingRemainYears = json_message["housingRemainYears"];
            year_id = i_year_id;
            academics = json_message["academics"];
            addresses = json_message["addresses"];
            phones = json_message["phones"];
            academicStandings = json_message["academicStandings"];

            new_user = User.create(
              :first_name => first_name,
              :middle_name => middle_name,
              :last_name => last_name,
              :suid => suid,
              :email => email,
              :sunet_id => sunet_id,
              :gender => gender,
              :is_admin => false,
              :year_id => i_year_id,
              :is_get_people_soft => false,
              :academic_year_remaining => housingRemainYears
            );

            new_detail = nil;
            if (new_user.present?)
              new_detail = PeoplesoftDetail.create(
                :user_id => new_user.id,
                :academics => academics,
                :addresses => addresses,
                :phones => phones,
                :academic_standings => academicStandings
              )
            end

            if (new_detail.present?)
              new_user.is_get_people_soft = true;
              new_user.save();
            end

            user = new_user;
          rescue Exception => e
            error_msg = "# #{Time.now} IP:#{request.remote_ip}, action: ApplicantsController, create user error: #{e.to_json}, sunet_id:#{s_sunet_id}"
            logger.error(error_msg)
            StanfordMailer.send_admin("System Error", error_msg).deliver
          end
        end # if (json_message["httpStatusCode"].present? || json_message["errorMessage"].present?)

        begin
          Transcript.get_grades(user) if user.is_get_people_soft
        rescue Exception => e
          logger.error "== get_transcripts error #{e.message} =="
        end

        #create applicant


      end # if (message)
    end

    render :text => "complete"
  end

  def update_500_applicants
    people_soft_sunetids = ["jhsander", "gegdean", "vbrosen", "aadelson", "almcconn", "itam627", "dboxill", "aspinner", "aaarnold", "griechel", "lauras5", "ckhosh", "jlim3", "mbqhoang", "sgonzaga", "agarg5",
      "ertheis", "habaner0", "porme", "dchou1", "rwoodby", "njboyne", "sierraf", "vvirasin", "mpeterso", "lsneed1", "cbegay", "jdbenner", "jadef1", "jwon2014", "kaliado9", "iangd", "naguibs", "felipems",
      "mperez15", "czabel", "dokwon", "tomanmil", "limsk1", "chood", "jamesbui", "gcollins", "bharadr", "alepstei", "cmccaw", "stnguyen", "rupss", "grantdel", "asunny", "jetd121", "bjromero", "jake5",
      "maya1k", "cleduff", "tberbert", "alex15", "kls307", "ebullock", "chanten", "nparikh", "annaduan", "hganti", "joeld1", "annna", "dallalah", "eianklam", "joshlim3", "lvoller", "kluyken", "penuelas",
      "csalguer", "alorenzo", "lmccune", "cquan88", "ethong", "alxbaut7", "sanchez7", "lbourg7", "seanh2", "cjbillov", "jfjiang", "amw00d", "iiorozco", "rrkhan", "ivaylogb", "armando1", "chelseas", "aringlis",
      "ntl2015", "mjcarter", "balansay", "cjzchen7", "chalupnj", "dcolivo", "izzahfa", "nmiles", "mdiawara", "mdeloso", "acasalme", "jordanm1", "spratley", "kristab", "ccox13", "jma3", "kobiela", "gavilan",
      "kyliegoh", "rbiedry", "cghernan", "sstuteja", "rachenc", "kmoses", "crogers3", "ashleyh3", "amgonzal", "lediur", "kelly007", "rlogue", "ading93", "bmschow", "abarbe", "ajain93", "caitline", "erdohner",
      "gautamk", "katyasta", "ineylan", "jacklynt", "nhient", "dmcamp", "cmceache", "dhs", "erici", "ekfrey", "awang99", "josiec", "alyazzie", "ankitk", "sjmora11", "baffour", "bdusault", "shaurya", "hmessiha",
      "nwlim", "oscarb1", "nrich", "karanh", "abrinas", "yasamins", "chuynh", "ddindi", "ritikap", "luisrh93", "jpratt5", "mruizluz", "aholden", "kjabra", "cmlave", "caileenr", "ejoslyn", "naren10", "chiarab1",
      "tubbs", "jfrager", "lrumker", "lkadisha", "nicole21", "dmclaugh", "rjobs", "mkolsen", "annetran", "rcarrera", "linfield", "ssarpong", "garsengw", "mcuson", "dulcied", "kwyngard", "jharper2", "kquon",
      "adoll", "kmehr", "mesitz", "felipe92", "hkirk1", "birawan", "dzeng0", "ewalker5", "abd240", "nick310", "lindsay7", "mf486264", "shaydaz", "srkemper", "anisha15", "saravr", "kevin93", "stinemar",
      "eashby", "tdg4", "jyli", "hdtrione", "chaser", "keegango", "lvoconor", "alweiler", "aelder", "ahayes11", "nikhilp", "jennaleo", "nan7car", "nnunez", "sammy13", "jdubin", "lum", "alisonn", "vkalumbi",
      "mvt2412", "kkolb", "mlecompt", "wzyang", "ytarter", "amdenney", "rtai1", "shamikm", "rajabd93", "azerbe", "rcmurray", "snitta", "elevans", "shivant", "cmok", "lina93", "azannos", "sseira", "rwaltman",
      "kuanp", "nahamed", "bondserv", "vcalvara", "jthomp", "bauersa", "uomegara", "ggraf", "codyml", "jhuynh93", "joshuae", "dlbarba4", "rcola", "freezing", "mrotello", "jedtan", "oborge", "lsteyer",
      "bhigh15", "bgarcia7", "jr1", "follmann", "ccharris", "elliotw", "ponec", "ohuang", "mvitelli", "arch15", "rgold25", "bsung93", "rtran15", "abaho", "lwoody08", "rlargman", "bonbon41", "rebent",
      "ropeke", "yuana", "joezabel", "gerritym", "akma327", "elapin", "deorozco", "kbeckett", "mwenzlau", "echanen", "leahkim", "ahuerta1", "phamh", "gogododo", "hutch16", "mweekes", "margrave", "kmosle",
      "ghmeans", "kmoore10", "aacharya", "samfalk1", "somasheg", "hammoorb", "annawiet", "vhcliu", "mgolla", "kelsey2", "arjun2", "antonio0", "aandaya", "emma16", "caseycab", "paranhos", "anphan", "jegoldbe",
      "ataude", "edpark", "benpham", "anniek94", "alexer", "ejohns", "carata", "edanyliw", "ggomez2", "nlattanz", "kcwijaya", "gshuler", "cmmong", "issmythe", "kaiser13", "dsull", "ctroy1", "sylvies",
      "aj4194", "deniae", "wur911", "jaclynam", "abreed", "rdavies8", "aravento", "shhawkin", "zdammel", "nmbogdan", "millerjp", "rayna", "timothyl", "benina", "advika", "pshields", "enevill6", "bwittmer",
      "gtoal", "lkac", "devonz", "elvira13", "slock", "kmo51409", "tessbpm", "slaterm", "ewilson3", "mhorwi93", "rosco12", "bdiego", "jchishol", "aselvan", "ivannap", "noemi11", "mrpeters", "zachary4",
      "afiakhan", "ml1293", "cpapecal", "coreygar", "bbravo", "gideond", "aamieva", "rresma2", "mrector", "dylana", "mjfang", "ckisunzu", "balpers", "avardhan", "cstotz", "sammyst", "smg16", "nsprice",
      "cgowdy", "matthew4", "clairet", "brixu4", "lkinney", "cmay3249", "yardena", "mcarley3", "bakis", "tbreeden", "holmdahl", "klewis4", "jason2", "afrkovic", "fionamt", "alim16", "jennia44", "lucywang",
      "harine17", "kenleung", "amccorma", "mollyals", "cbernedo", "ccromero", "talimi", "igomez62", "tfreed", "jbradbur", "kjaggers", "hrlarry", "garrettc", "dgreif1", "khassey", "seokho", "claudia4",
      "demery", "cfrost16", "jmarch9", "aaustin", "nsyder", "oewong", "diegov2", "awesthem", "efabre", "arod2016", "ngurtler", "andrev", "bennett8", "mwhitmey", "audreym", "arh", "nickbud", "mlathrop",
      "lillianv", "ghyatt", "dodge", "rtsukey", "revanthk", "martinob", "nix19", "ebernal", "jlin5", "elboy", "slynn2", "kpfleege", "willydri", "dmelende", "alexk614", "hshaw", "jinpark9", "janetp2",
      "hansohl", "lori16", "dbeam", "rgrau", "pedp", "ali2", "minnal", "rmusa", "mherrero", "jwallach", "jaclin", "ryankkim", "odespo", "lilliao5", "toser", "siyou", "smcgorty", "robinz16", "jwu7",
      "valdest", "lolaltij", "myupa", "cmulemi", "ted107mk", "kathy2", "dmckim", "juanm95", "omargs10", "cqian", "clewis95", "guzmanj", "cartero", "tpham7", "anaordo1", "rlee7", "maurices", "kslee17",
      "klittle2", "mindyang", "ctobin17", "knneil", "kprom", "vramesh2", "jmorg", "emkehoe", "bclarkin", "eokhale", "farhank", "lbrenner"]

      User.where(:sunet_id => people_soft_sunetids, :is_get_people_soft => true).order(:id).each do |user|
        logger.info "================ #{user.id} user ================"
        procedure = Procedure.find_by_id(5)
        if !procedure
          procedure_ids = Procedure.where(:status => true).pluck(:id)
          procedure = Procedure.find_by_id(procedure_ids[Random.rand(procedure_ids.length)])
        end
        logger.info "================ #{procedure.id} procedure ================"
        position_ids = Position.where(:procedure_id => procedure.id, :one_year_up => false).pluck(:id)
        position = Position.find_by_id(position_ids[Random.rand(position_ids.length)])
        logger.info "================ #{position.id} position ================"
        Applicant.create(:user_id => user.id, :procedure_id => procedure.id)
        Application.create(:user_id => user.id, :offered => "wait", :position_id => position.id)
        system_forms = Form.where({:procedure_id => procedure.id, :display => true, :form_type => "System"}).order("rank")
        forms = system_forms + Form.get_attachable_forms(procedure.id, user.id)
        forms.each do |form|
          filled_form = UserForm.where(:user_id => user.id, :form_id => form.id).first
          if !filled_form
            filled_form = UserForm.new
            filled_form.user_id = user.id
            filled_form.form_id = form.id
            filled_form.procedure_id = procedure.id
            filled_form.form_name = form.form_name
            filled_form.schema = form.schema
          end
          filled_form.schema = Form.data_binding(filled_form.schema, filled_form.user_id, 1)
          filled_form.save!
        end
      end

    render :text => "complete"
  end

  def delete_500_applicants
    people_soft_sunetids = ["jhsander", "gegdean", "vbrosen", "aadelson", "almcconn", "itam627", "dboxill", "aspinner", "aaarnold", "griechel", "lauras5", "ckhosh", "jlim3", "mbqhoang", "sgonzaga", "agarg5",
      "ertheis", "habaner0", "porme", "dchou1", "rwoodby", "njboyne", "sierraf", "vvirasin", "mpeterso", "lsneed1", "cbegay", "jdbenner", "jadef1", "jwon2014", "kaliado9", "iangd", "naguibs", "felipems",
      "mperez15", "czabel", "dokwon", "tomanmil", "limsk1", "chood", "jamesbui", "gcollins", "bharadr", "alepstei", "cmccaw", "stnguyen", "rupss", "grantdel", "asunny", "jetd121", "bjromero", "jake5",
      "maya1k", "cleduff", "tberbert", "alex15", "kls307", "ebullock", "chanten", "nparikh", "annaduan", "hganti", "joeld1", "annna", "dallalah", "eianklam", "joshlim3", "lvoller", "kluyken", "penuelas",
      "csalguer", "alorenzo", "lmccune", "cquan88", "ethong", "alxbaut7", "sanchez7", "lbourg7", "seanh2", "cjbillov", "jfjiang", "amw00d", "iiorozco", "rrkhan", "ivaylogb", "armando1", "chelseas", "aringlis",
      "ntl2015", "mjcarter", "balansay", "cjzchen7", "chalupnj", "dcolivo", "izzahfa", "nmiles", "mdiawara", "mdeloso", "acasalme", "jordanm1", "spratley", "kristab", "ccox13", "jma3", "kobiela", "gavilan",
      "kyliegoh", "rbiedry", "cghernan", "sstuteja", "rachenc", "kmoses", "crogers3", "ashleyh3", "amgonzal", "lediur", "kelly007", "rlogue", "ading93", "bmschow", "abarbe", "ajain93", "caitline", "erdohner",
      "gautamk", "katyasta", "ineylan", "jacklynt", "nhient", "dmcamp", "cmceache", "dhs", "erici", "ekfrey", "awang99", "josiec", "alyazzie", "ankitk", "sjmora11", "baffour", "bdusault", "shaurya", "hmessiha",
      "nwlim", "oscarb1", "nrich", "karanh", "abrinas", "yasamins", "chuynh", "ddindi", "ritikap", "luisrh93", "jpratt5", "mruizluz", "aholden", "kjabra", "cmlave", "caileenr", "ejoslyn", "naren10", "chiarab1",
      "tubbs", "jfrager", "lrumker", "lkadisha", "nicole21", "dmclaugh", "rjobs", "mkolsen", "annetran", "rcarrera", "linfield", "ssarpong", "garsengw", "mcuson", "dulcied", "kwyngard", "jharper2", "kquon",
      "adoll", "kmehr", "mesitz", "felipe92", "hkirk1", "birawan", "dzeng0", "ewalker5", "abd240", "nick310", "lindsay7", "mf486264", "shaydaz", "srkemper", "anisha15", "saravr", "kevin93", "stinemar",
      "eashby", "tdg4", "jyli", "hdtrione", "chaser", "keegango", "lvoconor", "alweiler", "aelder", "ahayes11", "nikhilp", "jennaleo", "nan7car", "nnunez", "sammy13", "jdubin", "lum", "alisonn", "vkalumbi",
      "mvt2412", "kkolb", "mlecompt", "wzyang", "ytarter", "amdenney", "rtai1", "shamikm", "rajabd93", "azerbe", "rcmurray", "snitta", "elevans", "shivant", "cmok", "lina93", "azannos", "sseira", "rwaltman",
      "kuanp", "nahamed", "bondserv", "vcalvara", "jthomp", "bauersa", "uomegara", "ggraf", "codyml", "jhuynh93", "joshuae", "dlbarba4", "rcola", "freezing", "mrotello", "jedtan", "oborge", "lsteyer",
      "bhigh15", "bgarcia7", "jr1", "follmann", "ccharris", "elliotw", "ponec", "ohuang", "mvitelli", "arch15", "rgold25", "bsung93", "rtran15", "abaho", "lwoody08", "rlargman", "bonbon41", "rebent",
      "ropeke", "yuana", "joezabel", "gerritym", "akma327", "elapin", "deorozco", "kbeckett", "mwenzlau", "echanen", "leahkim", "ahuerta1", "phamh", "gogododo", "hutch16", "mweekes", "margrave", "kmosle",
      "ghmeans", "kmoore10", "aacharya", "samfalk1", "somasheg", "hammoorb", "annawiet", "vhcliu", "mgolla", "kelsey2", "arjun2", "antonio0", "aandaya", "emma16", "caseycab", "paranhos", "anphan", "jegoldbe",
      "ataude", "edpark", "benpham", "anniek94", "alexer", "ejohns", "carata", "edanyliw", "ggomez2", "nlattanz", "kcwijaya", "gshuler", "cmmong", "issmythe", "kaiser13", "dsull", "ctroy1", "sylvies",
      "aj4194", "deniae", "wur911", "jaclynam", "abreed", "rdavies8", "aravento", "shhawkin", "zdammel", "nmbogdan", "millerjp", "rayna", "timothyl", "benina", "advika", "pshields", "enevill6", "bwittmer",
      "gtoal", "lkac", "devonz", "elvira13", "slock", "kmo51409", "tessbpm", "slaterm", "ewilson3", "mhorwi93", "rosco12", "bdiego", "jchishol", "aselvan", "ivannap", "noemi11", "mrpeters", "zachary4",
      "afiakhan", "ml1293", "cpapecal", "coreygar", "bbravo", "gideond", "aamieva", "rresma2", "mrector", "dylana", "mjfang", "ckisunzu", "balpers", "avardhan", "cstotz", "sammyst", "smg16", "nsprice",
      "cgowdy", "matthew4", "clairet", "brixu4", "lkinney", "cmay3249", "yardena", "mcarley3", "bakis", "tbreeden", "holmdahl", "klewis4", "jason2", "afrkovic", "fionamt", "alim16", "jennia44", "lucywang",
      "harine17", "kenleung", "amccorma", "mollyals", "cbernedo", "ccromero", "talimi", "igomez62", "tfreed", "jbradbur", "kjaggers", "hrlarry", "garrettc", "dgreif1", "khassey", "seokho", "claudia4",
      "demery", "cfrost16", "jmarch9", "aaustin", "nsyder", "oewong", "diegov2", "awesthem", "efabre", "arod2016", "ngurtler", "andrev", "bennett8", "mwhitmey", "audreym", "arh", "nickbud", "mlathrop",
      "lillianv", "ghyatt", "dodge", "rtsukey", "revanthk", "martinob", "nix19", "ebernal", "jlin5", "elboy", "slynn2", "kpfleege", "willydri", "dmelende", "alexk614", "hshaw", "jinpark9", "janetp2",
      "hansohl", "lori16", "dbeam", "rgrau", "pedp", "ali2", "minnal", "rmusa", "mherrero", "jwallach", "jaclin", "ryankkim", "odespo", "lilliao5", "toser", "siyou", "smcgorty", "robinz16", "jwu7",
      "valdest", "lolaltij", "myupa", "cmulemi", "ted107mk", "kathy2", "dmckim", "juanm95", "omargs10", "cqian", "clewis95", "guzmanj", "cartero", "tpham7", "anaordo1", "rlee7", "maurices", "kslee17",
      "klittle2", "mindyang", "ctobin17", "knneil", "kprom", "vramesh2", "jmorg", "emkehoe", "bclarkin", "eokhale", "farhank", "lbrenner"]

    User.where(:sunet_id => people_soft_sunetids, :is_get_people_soft => true).each do |user|
      Applicant.where(:user_id => user.id).destroy_all
      Application.where(:user_id => user.id).destroy_all
      UserForm.where(:user_id => user.id).destroy_all
    end
=begin
    User.all.each do |user|
      if User.where(:sunet_id => user.sunet_id).length > 1
        logger.info "===================================="
        logger.info "== #{user.sunet_id} user.sunet_id =="
        user.is_get_people_soft = 0
        user.save
      end
    end

    User.where("ID > 10019 and IS_GET_PEOPLE_SOFT = 1").each do |user|
      user.first_name = "500_" + user.first_name
      user.email = "500_" + user.email
      user.save
    end

    PeoplesoftDetail.where("USER_ID > 10019 and ACADEMICS IS NOT NULL")
=end
    render :text => "complete"
  end

end
