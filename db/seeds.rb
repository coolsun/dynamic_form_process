# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#"{'id'=>#{u.id}, 'first_name'=>'#{u.first_name}', 'last_name'=>'#{u.last_name}', 'status'=>'#{u.status}', 'is_admin'=> #{u.is_admin}, 'sunet_id' => '#{u.sunet_id}', 'suid'=>'#{u.suid}', 'email'=>'#{u.email}', 'year_id'=>'#{u.year_id}'},"
standford_users = [
  {'id'=>2, 'first_name'=>'Mei', 'last_name'=>'Hung', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'meihung', 'suid'=>'00000001', 'email'=>'meihung@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>3, 'first_name'=>'Cisco', 'last_name'=>'Barron', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'ciscokid', 'suid'=>'00000002', 'email'=>'ciscobarron@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>4, 'first_name'=>'Joyce', 'last_name'=>'Li', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'joyceli', 'suid'=>'00000005', 'email'=>'joyceli@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>5, 'first_name'=>'Douglas', 'last_name'=>'Calhoun', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'douglasc', 'suid'=>'douglasc', 'email'=>'douglasc@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>6, 'first_name'=>'Spencer', 'last_name'=>'Atkinson', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'satkinso', 'suid'=>'satkinso', 'email'=>'satkinso@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>7, 'first_name'=>'Cole', 'last_name'=>'Shiflett', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'shiflett', 'suid'=>'00000002', 'email'=>'shiflett@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
  {'id'=>8, 'first_name'=>'Thomas', 'last_name'=>'Carlson', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'tec', 'suid'=>'00000002', 'email'=>'tec@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
]

users_data = [
{'id'=>1, 'first_name'=>'Bsun2', 'last_name'=>'Woodson', 'status'=>'Staff', 'is_admin'=> true, 'sunet_id' => 'bsun2', 'suid'=>'00000000', 'email'=>'Bsun2_Li@stanfordtest.edu', 'year_id'=>'1', 'is_get_people_soft'=>true},
{'id'=>9, 'first_name'=>'Jenifer', 'last_name'=>'Wofford', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'Jenifer', 'suid'=>'00000001', 'email'=>'Jenifer_Wofford@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>10, 'first_name'=>'Rajah', 'last_name'=>'Rarama', 'status'=>'Student', 'is_admin'=> false, 'sunet_id' => 'Rajah', 'suid'=>'00000002', 'email'=>'Rajah_Rarama@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>11, 'first_name'=>'dev_mgr_role', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_role', 'suid'=>'00000003', 'email'=>'dev_mgr_role@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>12, 'first_name'=>'dev_mgr_location', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_location', 'suid'=>'00000004', 'email'=>'dev_mgr_location@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>13, 'first_name'=>'dev_mgr_hiring', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_hiring', 'suid'=>'00000005', 'email'=>'dev_mgr_hiring@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>14, 'first_name'=>'dev_some_mgr_role', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_some_mgr_role', 'suid'=>'00000006', 'email'=>'dev_some_mgr_role@stanfordtest.edu', 'year_id'=>'1'},
{'id'=>15, 'first_name'=>'dev_some_mgr_location', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_some_mgr_location', 'suid'=>'00000007', 'email'=>'dev_some_mgr_location@stanfordtest.edu', 'year_id'=>'1'},
];

people_soft_users = [
  {"academicStandings"=>[],"middleName"=>" ","lastName"=>"Camarena","academics"=>[{"cumGPA"=>"3.492","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Computer Science (BS)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Junior"}],"suid"=>"09674277","email"=>"1pscs-dev-emails@stanfordtest.edu","sunetId"=>"joabcam","gender"=>"M","addresses"=>[{"address"=>"950 Main Street Apt. 344, Redwood City, CA, USA, 94063","type"=>"HOME"}],"firstName"=>"Joab","phones"=>[{"phoneNumber"=>"650-743-6827","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>" ","lastName"=>"Man","academics"=>[{"cumGPA"=>"3.889","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Junior"}],"suid"=>"09669646","email"=>"2pscs-dev-emails@stanfordtest.edu","sunetId"=>"colinman","gender"=>"M","addresses"=>[{"address"=>"1140 Sunshine Cir, Danville, CA, USA, 94506","type"=>"HOME"}],"firstName"=>"Colin","phones"=>[{"phoneNumber"=>"925-413-9899","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Xinyu","lastName"=>"Wang","academics"=>[{"cumGPA"=>"3.9","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09668773","email"=>"3pscs-dev-emails@stanfordtest.edu","sunetId"=>"kxwang","gender"=>"F","addresses"=>[{"address"=>"937 Kingsley Drive, Arcadia, CA, USA, 91007","type"=>"HOME"}],"firstName"=>"Kerry","phones"=>[{"phoneNumber"=>"626-623-2511","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Chaim","lastName"=>"Hastings Porro","academics"=>[{"cumGPA"=>"0.0","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2014-2015 Autumn","academicLevel"=>"Freshman"}],"suid"=>"09668739","email"=>"4pscs-dev-emails@stanfordtest.edu","sunetId"=>"maceohp","gender"=>"M","addresses"=>[{"address"=>"810 Western Drive, Santa Cruz, CA, USA, 95060","type"=>"HOME"}],"firstName"=>"Maceo","phones"=>[{"phoneNumber"=>"831-212-3409","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Nicole","lastName"=>"Logia","academics"=>[{"cumGPA"=>"2.952","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Chemical Engineering (BS)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09674272","email"=>"5pscs-dev-emails@stanfordtest.edu","sunetId"=>"alogia","gender"=>"F","addresses"=>[{"address"=>"666 Sylvan Street, unit 1, Daly City, CA, USA, 94014","type"=>"HOME"}],"firstName"=>"Alison","phones"=>[{"phoneNumber"=>"650-556-6517","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>" ","lastName"=>"Ganesan","academics"=>[{"cumGPA"=>"3.688","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Computer Science (BS)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09668770","email"=>"6pscs-dev-emails@stanfordtest.edu","sunetId"=>"priyag","gender"=>"F","addresses"=>[{"address"=>"11705 157th Ave NE, Redmond, WA, USA, 98052","type"=>"HOME"}],"firstName"=>"Priya","phones"=>[{"phoneNumber"=>"425-985-5276","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Anne","lastName"=>"Carr","academics"=>[{"cumGPA"=>"3.897","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09668737","email"=>"7pscs-dev-emails@stanfordtest.edu","sunetId"=>"kcarr2","gender"=>"F","addresses"=>[{"address"=>"14351 Miro Court, Irvine, CA, USA, 92606","type"=>"HOME"}],"firstName"=>"Katherine","phones"=>[{"phoneNumber"=>"949-861-1044","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Hitesh","lastName"=>"Dalal","academics"=>[{"cumGPA"=>"3.822","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Human Biology (BA)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Senior"}],"suid"=>"09674626","email"=>"8pscs-dev-emails@stanfordtest.edu","sunetId"=>"nhdalal","gender"=>"F","addresses"=>[{"address"=>"34156 Finnigan Terrace, Fremont, CA, USA, 94555","type"=>"HOME"}],"firstName"=>"Nicole","phones"=>[{"phoneNumber"=>"510-529-8967","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Agor","lastName"=>"Mullings","academics"=>[{"cumGPA"=>"3.544","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Computer Science (BS)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Junior"},{"cumGPA"=>"3.544","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Engineering (BS)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Junior"}],"suid"=>"09674214","email"=>"9pscs-dev-emails@stanfordtest.edu","sunetId"=>"cmulling","gender"=>"F","addresses"=>[{"address"=>"624 Bridgeport Ln, Foster City, CA, USA, 94404","type"=>"HOME"}],"firstName"=>"Catherine","phones"=>[{"phoneNumber"=>"650-521-1305","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Adams","lastName"=>"Du","academics"=>[{"cumGPA"=>"3.668","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09668748","email"=>"10pscs-dev-emails@stanfordtest.edu","sunetId"=>"willadu","gender"=>"M","addresses"=>[{"address"=>"63 Sable Point, Alameda, CA, USA, 94502","type"=>"HOME"}],"firstName"=>"William","phones"=>[{"phoneNumber"=>"510-705-2147","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Peterson","lastName"=>"Sauer","academics"=>[{"cumGPA"=>"4.182","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Junior"}],"suid"=>"09668769","email"=>"11pscs-dev-emails@stanfordtest.edu","sunetId"=>"cpsauer","gender"=>"M","addresses"=>[{"address"=>"18 Sandstone Street, Portola Valley, CA, USA, 94028-8033","type"=>"HOME"}],"firstName"=>"Christopher","phones"=>[{"phoneNumber"=>"650-743-6788","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>" ","lastName"=>"Shen","academics"=>[{"cumGPA"=>"3.854","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Junior"}],"suid"=>"09668754","email"=>"12pscs-dev-emails@stanfordtest.edu","sunetId"=>"marshen","gender"=>"F","addresses"=>[{"address"=>"41461 Pelham Ct, Fremont, CA, USA, 94539","type"=>"HOME"}],"firstName"=>"Margaret","phones"=>[{"phoneNumber"=>"510-449-1357","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Yoshitaro","lastName"=>"Nishimura","academics"=>[{"cumGPA"=>"3.976","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Electrical Engineering (BS)","academicCareer"=>"UG","admitTerm"=>"2012-2013 Autumn","academicLevel"=>"Senior"}],"suid"=>"09674636","email"=>"13pscs-dev-emails@stanfordtest.edu","sunetId"=>"markn1","gender"=>"M","addresses"=>[{"address"=>"951 Elsinore Dr., Palo Alto, CA, USA, 94303","type"=>"HOME"}],"firstName"=>"Mark","phones"=>[{"phoneNumber"=>"650-867-2599","type"=>"CELL"}]},
  {"academicStandings"=>[],"middleName"=>"Anna","lastName"=>"Le","academics"=>[{"cumGPA"=>"3.567","status"=>"AC","academicPlanType"=>"Major","academicPlan"=>"Undeclared (B)","academicCareer"=>"UG","admitTerm"=>"2013-2014 Autumn","academicLevel"=>"Sophomore"}],"suid"=>"09668759","email"=>"14pscs-dev-emails@stanfordtest.edu","sunetId"=>"hieuthao","gender"=>"F","addresses"=>[{"address"=>"2842 Scottsdale Dr, San Jose, CA, USA, 95148","type"=>"HOME"}],"firstName"=>"Anna","phones"=>[{"phoneNumber"=>"408-645-4320","type"=>"CELL"}]},
];

ca_process_landing = <<-EOF
<h2><a href="http://glo.stanfordtest.edu/">Graduate Life Office</a>: [[CurrentProcess]] [[CurrentYear]]</h2>
<h2>[[CurrentProcess]]&nbsp;Role Description and Application Information</h2>
<div class="contentsection">
<p><strong>Description of the Graduate Life Office (GLO) Residences Program</strong></p>
<p>The Graduate Life Office's residence program is comprised of five University residence areas in which the focus is on creating a sense of community and encouraging students to assume responsibility for the quality of their lives. The Graduate Life Office consists of Ken Hsu, Director &amp; Assistant Vice Provost, Shannon Hobbs, Laurette Beeson, Andrew Hernandez, Marcela Chaverri and Kimberley James. All staff support and supervise the Community Associate program.</p>
<p>The residences are diverse in their physical facilities and in the residents housed in each. Residences include Studios, one-, two-, three-, and four-bedroom apartments with populations that include single graduate students, married couples, domestic partnerships, and families. We seek to provide residents with a supportive, friendly, and welcoming environment where they are encouraged to develop a strong sense of community.</p>
<p><strong>EV Family - 22 CAs</strong>: EV Family CAs are graduate students and/or spouses who live in EV family courtyards and plan and facilitate welcoming activities and social, cultural, educational and recreational events throughout the academic year. There are approximately 260 families housed in EV which include over 400 children. Family CAs focus many of their activities on children and the unique needs of families. CAs are also knowledgeable about resources in and around Stanford and about campus services available to graduate students and their families.</p>
<p><strong>EV Singles and Couples - 65 CAs</strong>: EV Singles and Couples CAs build community among the vast and diverse singles and couples that live in the Village. In addition to organizing events in small neighborhoods, CAs have an opportunity to organize larger events by participating in one of four committees: Community Service, Social, Sports and Outdoors, Educational/Cultural and Health &amp; Wellness.</p>
<p><strong>Lyman Residences - 5 CAs</strong>: Lyman Residences, which is an apartment community on the Westside of campus that houses single students in two-bedroom apartments. Program emphasis is on providing opportunities for students to get to know each other through social, educational, multicultural, and recreational activities.</p>
<p><strong>Rains Houses - 21 CAs</strong>: Rains Houses is an apartment complex that houses single students. The complex is divided into neighborhoods in which two or more students serve as CAs. The program focus is on getting students to interact and form friendships and is designed to meet the needs of a large, single graduate student population including social, educational, multicultural, and recreational events.</p>
<p><strong>Munger Residences - 12 CAs</strong>: As Stanford's newest residence for graduate students, Munger graduate residences consist of 5 buildings that provides housing to a total of 600 residents. In each building, there are a variety of housing options ranging from studio apartments, two-bedroom and four-bedroom for single students to Studios and one-bedroom apartments for couples. Half of the 600 spaces are reserved for law students. Each building in Munger is a CA "neighborhood" where a team of 2 to 3 CAs serve as helpful resources and event organizers to its residents.</p>
<p><strong>Donald Kennedy Graduate Residences (Comstock Circle) - 12 CAs&nbsp;</strong>: Three different types of housing will be provided in four, 4-story buildings, for a total of 436 new beds of graduate housing. The new commons will include student meeting and social gathering space, laundry facilities, computer cluster, music practice room, game room, TV lounge and front desk. Building A will provide 54 2-bedroom apartments (total of 108 beds). Each apartment will house single graduate students and includes a common kitchen and living area, and two private bathrooms for a total of approximately 878 square feet (sf). Building B will provide 108 premium studio apartments (total of 108 beds) sized for couples. Each premium studio apartment includes a full kitchen and living area for a total of approximately 439 sf. Buildings C and D will provide a total of 220 junior studio apartments (total of 220 beds). Each junior studio apartment will house single graduate students and includes approximately 284 sf per apartment, with a 111 sf shared common area and kitchen for every two apartments.</p>
</div>
<div class="contentsection">
<h3>Advice to Applicants</h3>
<p><strong>ELIGIBILITY</strong>&nbsp;(click&nbsp;<a href="http://www.stanfordtest.edu/dept/rde/cgi-bin/drupal/housing/apply/matriculated-students" target="_info">here</a>&nbsp;and look at the bottom of the page for an explanation on priority years): Applicants must be eligible for on-campus housing, with at least one remaining priority year and be staying for the entirety of the school year.</p>
<p>CA applicants (and their one specified roommate) must apply for housing and submit an application for the 2014-2015 academic year by the required deadline. If you are selected to be a CA ,you and your (one roommate) will be exempted from the 2014-2015 housing lottery.</p>
<p>CAs are&nbsp;<strong>REQUIRED</strong>&nbsp;to attend Training. More information on training will be available during the interview process.</p>
<p>CAs will receive a $1,000/quarter stipend (based on eligibility). Visa information is available here.</p>
<p><span style="text-decoration: underline;">CAs are assigned to specific neighborhoods (Rains, EV, Lyman and Munger). Specific apartment preferences will be considered, but are not guaranteed. All assignments are made by the area specific Front Desk Center (FDC).</span></p>
</div>
<div class="contentsection">
<h3>Description of Responsibilities of CAs</h3>
<ul>
<li>CAs plan and provide local residential welcome and orientation programs to new students. They also participate and assist in campus-wide orientation programs (NGSO).</li>
<li>CAs initiate and maintain positive relationships with students living in their residence or neighborhood.</li>
<li>CAs participate and assist in the assessment of the needs and interests of students within their area, and to attend to the general well-being of residents.</li>
<li>CAs are available and visible to residents and participate in the life and activities of the residence/neighborhood.</li>
<li>CAs listen attentively to student concerns and questions and are the first point of contact for residents problems, issues or conflicts.</li>
<li>CAs provide first-line of support and problem-solving or conflict mediation before cases are referred to the Graduate Life Deans</li>
<li>CAs works closely with Graduate Life Deans and other University personnel (CAPS, police, etc.) to provide comprehensive response to resident or community crises or emergencies.</li>
<li>CAs treat conversations with students with respect and discretion, and bring questions or concerns to the Graduate Life Deans.</li>
<li>CAs inform residents of campus resources for health/wellness and for help and support.</li>
<li>CAs are knowledgeable about, and refer students to University resources and departments, particularly the Graduate Life Office, Vaden/CAPS, etc., and serve as liaison between these offices and their residents for information affecting student health and well-being.</li>
<li>CAs provide emergency response information, resources and leadership to residents.</li>
<li>CAs create, plan, and implement social events on and off-campus for their residents to promote socialization, relaxation, fun, and sense of community.</li>
<li>CAs work closely with Graduate Life Deans to reach out to, provide support to, or to check on the welfare of concerning residents in their neighborhood.</li>
<li>CAs work in collaboration with, or provide assistance and support to partner offices and organizations such as VPGE, R &amp; D E, and the GSC to improve academic and life experiences of graduate students living on campus</li>
<li>CA's are expected to complete all training required by the Graduate Life Office.</li>
<li>CA teams (Escondido Village, Rains, Munger, Lyman) have area specific Administrative &amp; Programmatic expectations that must be met.</li>
</ul>
</div>
<div class="contentsection"><a name="process"></a>
<h3>Application Process Overview</h3>
<p><strong>Step 1:&nbsp;<a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-ca/application.jsp?partid=1456">Complete application materials</a>&nbsp;by [[ApplicationEndTime]].</strong></p>
<p>Use the link above to access online application materials, including the application form and residence preferences form.</p>
<p><strong>Step 2:&nbsp;<a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-ca/interviews.jsp?partid=1455">Check for an interview and sign up</a>, starting [[InterviewStartTime]].</strong></p>
<p>Use the link above to check if you have received an email of Interview Invitation and if yes, sign up for a date/time (must sign up during the period of interview round time). Interviews will be held between [[InterviewStartTime]] through [[InterviewEndTime]].</p>
<p><strong>Step 3:&nbsp;<a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-ca/offers.jsp">Check for a position offer</a>, beginning [[Offer-OfferStatus-StartTime]].</strong></p>
<p>Use the link above to check if you have been offered a position and if yes, accept or decline. By accepting the position, you are also agreeing to attend the MANDTORY training and retreat sessions.</p>
<p>The deadline to accept the position and complete acceptance form, is [[OfferEndTime]].</p>
</div>
EOF

ca_application_landing = <<-EOF
<div class="content">&nbsp;</div>
<div class="footer">
<h2>[[CurrentProcess]]: Application Form</h2>
<p>Please read following instructions thoroughly before beginning your application.</p>
<p>A completed application includes:</p>
<ul>
<li>Completed application form</li>
</ul>
<p>Use the left bar to access each part of the application materials.&nbsp;</p>
<p>You may check the clock icon next to the Application to know when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted.</strong></p>
<p><strong>When you are ready to officially submit your application materials, be sure to click the "Submit Application" button </strong>to have them made available to Graduate Life Office for review. Once you have submitted your materials, you may cancel your application by clicking the ''Withdraw Application'' button.</p>
<p><br /> However, you <strong>MUST</strong> accomplish the action of submitting or withdrawing your application no later than [[ApplicationEndTime]].</p>
<p><br /><strong>Application Forms</strong></p>
<p>Application materials are due on [[ApplicationEndTime]].</p>
<div class="contentsection">
<p>Required Form</p>
<p>*[[CurrentProcess]] Application&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style="color: #3366ff;">View</span></p>
<p>&nbsp;</p>
<p><strong>[[TheMessageAboutSubmitApplication]].</strong></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
</div>
EOF

ca_interview_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Interview Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before beginning your interview application.</p>
<p><br /> You may check the clock icon next to the Interview to know when the start and end time of each interview round will be.</p>
<p><strong>Be prepared to sign up or cancel the interview within the required time or your application will not be accepted.</strong></p>
<p>Once you have been invited or even scheduled for an interview, you would see an icon next to that interview round on the left bar.<br /> Click that interview round(s) and check frequently your <strong>My Interviews</strong> to catch the latest updates and details.</p>
<p>You may sign up or cancel the time slot directly from<strong> My Interviews </strong>or <strong>Calendar</strong> within the interview round time.</p>
<p><br /> The place of your interview would be marked on both the box of ''<strong>Sign up Interview Time''</strong> under your <strong>My Interviews </strong>and <strong>Calendar</strong></p>
<p><br /> If you neither see any icon next to all the interview rounds of the left bar nor receive any Interview Invitation email, it means you haven't received any interview offer that were posting interviews this week. <br /> We may add additional interview times without notice. And we encourage you not to rely on email, and check ResJobs often.<strong><br /> </strong><br /><br /></p>
<p><strong><br /> <br /> </strong></p>
EOF

ca_ranking_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Ranking Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before ranking your position.</p>
<p><br /> You may check the clock icon next to the Ranking to know when the start and end time will be.</p>
<p><strong>You need to finish your ranking within [[RankingStartTime]] to</strong></p>
<p><strong>[[RankingEndTime]] or your setting will not be accepted.</strong></p>
<p>You can adjust the ranking result by simple drag and drop actions to make your preferred positions upper than others.</p>
<p><br /><br /></p>
EOF

ca_offer_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Offer Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Offer step.</p>
<p><br /> You may check the clock icon next to the Offer to know when the start and end time will be.</p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[Offer-OfferStatus-StartTime]] to [[Offer-OfferStatus-EndTime]], or your offer will be withdrawn directly.</strong></p>
<p><br /><br /></p>
<p>&nbsp;</p>
EOF

ca_postmatch_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Post Match Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Post Match step.</p>
<p><br /> You may check the clock icon next to the Post Match when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. If there is no required step, you may check the Offer Status directly.<br /> <br /> </strong></p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[PostMatch-OfferStatus-StartTime]] to</strong></p>
<p><strong>[[PostMatch-OfferStatus-EndTime]], or your offer will be withdrawn directly.</strong></p>
<p>&nbsp;</p>
EOF

rcc_process_landing = <<-EOF
<h2><a href="http://rescomp.stanfordtest.edu/">Residential Computing</a>: [[CurrentProcess]]&nbsp;Selection for&nbsp;[[CurrentYear]]</h2>
<p>Section: General Information</p>
<div class="contentsection">
<p>Thank you for your interest in the Resident Computer Consultant (RCC) position in the graduate residences. Below you will find instructions on how to apply to a Graduate RCC position. Please make sure you review the Position Description and Frequently Asked Questions before applying:<br /><span style="color: #3366ff;"><a href="http://stucomp.stanfordtest.edu/positions/rcc" target="_blank"><span style="color: #3366ff;">http://stucomp.stanfordtest.edu/positions/rcc</span></a></span></p>
<h3>Basic Requirements</h3>
<p>Applicants must be a registered Stanford student and able to work in this position for an entire academic year (Fall 2014, Winter 2015, &amp; Spring 2015).<br />Applicants must have a remaining year of guaranteed graduate housing.<br />Please note that if you are an international student and also have a 50% RAship (20 hours per week), due to visa restrictions, you are not eligible to be a Graduate RCC.</p>
<h3>Compensation</h3>
<p>Please see the&nbsp;<span style="color: #3366ff;"><a href="http://rescomp.stanfordtest.edu/about/positions/rcc/salary.html" target="_blank"><span style="color: #3366ff;">RCC Salary and Compensation page</span></a></span>&nbsp;for current compensation information.</p>
</div>
<p><a name="process"></a></p>
<h3>Application Process Overview</h3>
<div class="contentsection"><dl><dt>Step 1: Attend a RCC Information session</dt><dd>Details on the session can be found at&nbsp;<a href="http://stucomp.stanfordtest.edu/positions/rcc" target="_blank">http://stucomp.stanfordtest.edu/positions/rcc</a>. Please note attendance is optional but highly recommended.</dd><dd></dd><dt>Step 2:&nbsp;<span style="color: #3366ff;"><a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-rcc/application.jsp?partid=1431"><span style="color: #3366ff;">Complete application materials</span></a></span>&nbsp;by [[ApplicationEndTime]].</dt><dd>A completed application includes:<ol>
<li>A completed application form, including essays and residence choices.</li>
<li>For new applicants and current undergraduate RCCs, at least one (1) letter of recommendation.</li>
<li>If the recommender is a current RCC, s/he should not be also applying for this position.</li>
<li>For current undergraduate RCCs, the letter must be from a RF/CD, fellow staff member in your residence or resident.</li>
</ol>Please note you can check your&nbsp;<span style="color: #3366ff;"><a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-rcc/status.jsp"><span style="color: #3366ff;">application status</span></a></span>&nbsp;at any time.</dd><dd></dd><dd></dd><dt>Step 3: Sign up for an interview by [[InterviewStartTime]].</dt><dd>
<ul>
<li>New applicants:&nbsp;<span style="color: #3366ff;"><a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-rcc/interviews.jsp?partid=1429"><span style="color: #3366ff;">Select a preferred interview slot</span></a></span>&nbsp;by this deadline.</li>
<li>Returning and former RCCs: Contact Consulting Services Manager to schedule a meeting. For further details, use the interview link above.</li>
</ul>
</dd><dt>Step 4:&nbsp;<span style="color: #3366ff;"><a href="https://sawebapp.stanfordtest.edu/respositions/applicant/grad-rcc/offers.jsp"><span style="color: #3366ff;">Check for position offers</span></a></span>&nbsp;beginning [[Offer-OfferStatus-StartTime]]&nbsp;and submit your response by [[Offer-OfferStatus-EndTime]].</dt><dd>Use the link above to check if you have been offered an RCC position and if yes, accept or deny the offer.</dd></dl></div>
<p><a name="questions"></a></p>
<h3>Questions?</h3>
<div class="contentsection">Review the FAQ first. If your questions are not answered by the FAQ, please send all questions about the RCC position to Student Computing at&nbsp;<span style="color: #3366ff;"><a href="mailto:hiring@stucomp.stanfordtest.edu"><span style="color: #3366ff;">hiring@stucomp.stanfordtest.edu</span></a></span>.</div>
EOF

rcc_application_landing = <<-EOF
<h2>[[CurrentProcess]]: Graduate RCC Application Materials</h2>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before beginning your application.</p>
<p><br /> A completed application includes:</p>
<ul>
<li>&nbsp;Completed application form</li>
<li>&nbsp;Recommendation Form</li>
</ul>
<p>Use the left bar to access each part of the application materials.</p>
<p><br /> You may check the clock icon next to the Application to know when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. </strong></p>
<p><br /> For recommendations, provide each recommender's information, including email address, using the form that provided by this system. This will send an email to the recommender notifying him/her of your request for a recommendation; the recommender will then be able to access the ResJobs system to complete and submit his/her recommendation online.<br /> <strong>For current undergraduate RCCs, the recommender must be a RF/CD or Fellow Staff or Resident. If recommender is a RCC, he/she should not also be applying to RCC position again.</strong></p>
<p><strong>When you are ready to officially submit your application materials, be sure to click the "Submit Application" button </strong>to have them made available to Residential Computing for review. Once you have submitted your materials, you may cancel your application by clicking the ''Withdraw Application'' button.</p>
<p><br /> However, you <strong>MUST</strong> accomplish the action of submitting or withdrawing your application no later than [[ApplicationEndTime]].</p>
<p>Application Forms</p>
<div class="contentsection">
<p><strong>Application materials are due on &nbsp;[[ApplicationEndTime]].</strong>&nbsp;</p>
<p>Required Form</p>
<p>*[[CurrentProcess]] Application&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: #3366ff;"> View</span></p>
<p>&nbsp;</p>
<p>[[TheMessageAboutSubmitApplication]]</p>
</div>
<div class="contentsection">
<h3 style="text-align: center;">Recommendation Form</h3>
<p>After a recommendation request has been made, you can check if the recommendation has been submitted by returning to this page.</p>
<p><strong>Recommendation Form</strong>: Due&nbsp;[[Application-Recommendation-EndTime]]</p>
<p><span lang="EN-US">[[TheMessageAboutRecommendationRequested]]</span></p>
<p><span lang="EN-US">[[TheMessageAboutRecommendationReceived]]</span></p>
<p><span lang="EN-US">[[TheMessageAboutRecommendationTimesUp]]</span></p>
<p><span lang="EN-US"><br /><br /></span></p>
<blockquote>
<p>&nbsp;</p>
<p>&nbsp;</p>
</blockquote>
</div>
EOF

rcc_interview_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Interview Instruction</strong></span></p>
<p><br /> Please read following instructions thoroughly before beginning your interview application.</p>
<ul>
<li>Returning and former RCCs: Contact Consulting Services Manager to schedule a meeting. For further details, please see following information.</li>
<li>New applicants:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/interviews.jsp?partid=1435">Select a preferred interview slot</a>&nbsp;by following the information below.</li>
</ul>
<p><br /> You may check the clock icon next to the Interview to know when the start and end time of each interview round will be.</p>
<p><strong>Be prepared to sign up or cancel the interview within the required time or your application will not be accepted.</strong></p>
<p>Once you have been invited or even scheduled for an interview, you would see an icon next to that interview round on the left bar.<br /> Click that interview round(s) and check frequently your <strong>My Interviews</strong> to catch the latest updates and details.</p>
<p>You may sign up or cancel the time slot directly from<strong> My Interviews </strong>or <strong>Calendar</strong> within the interview round time.</p>
<p><br /> The place of your interview would be marked on both the box of ''<strong>Sign up Interview Time''</strong> under your <strong>My Interviews and Calendar</strong></p>
<p><br /> If you neither see any icon next to all the interview rounds of the left bar nor receive any Interview Invitation email, it means you haven't received any interview offer that were posting interviews this week. <br /> We may add additional interview times without notice. And we encourage you not to rely on email, and check ResJobs often.<strong><br /></strong></p>
<p><strong><br /> <br /> </strong></p>
EOF

rcc_ranking_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Ranking Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before ranking your position.</p>
<p><br /> You may check the clock icon next to the Ranking to know when the start and end time will be.</p>
<p><strong>You need to finish your ranking within [[RankingStartTime]] to</strong></p>
<p><strong>[[RankingEndTime]] or your setting will not be accepted.</strong></p>
<p>You can adjust the ranking result by simple drag and drop actions to make your preferred positions upper than others.</p>
<p><br /><br /></p>
EOF

rcc_offer_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Offer Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Offer step.</p>
<p><br /> You may check the clock icon next to the Offer to know when the start and end time will be.</p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[Offer-OfferStatus-StartTime]] to [[Offer-OfferStatus-EndTime]] or your offer will be withdrawn directly.</strong></p>
<p><br /><br /></p>
EOF

rcc_postmatch_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Post Match Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Post Match step.</p>
<p><br /> You may check the clock icon next to the Post Match when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. If there is no required step, you may check the Offer Status directly.<br /> <br /> </strong></p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[PostMatch-OfferStatus-StartTime]] to</strong></p>
<p><strong>[[PostMatch-OfferStatus-EndTime]], or your offer will be withdrawn directly.</strong></p>
<p><br /><br /></p>
EOF

pa_process_landing = <<-EOF
<h2 style="text-align: center;">[[CurrentProcess]]</h2>
<h2 style="text-align: left;">[[CurrentProcess]]&nbsp;[[CurrentYear]]</h2>
<div class="contentsection"><a name="process"></a>
<h3>[[CurrentProcess]] Process&nbsp;Overview</h3>
<h4>Welcome to the [[CurrentProcess]]&nbsp;Process! For more information on pre-assignment &amp; participating houses, check out the&nbsp;<strong><a href="http://studentaffairs.stanfordtest.edu/resed/profiles/theme/what-are-theme-houses" target="_info">THEMED HOUSING WEBSITE</a></strong>!</h4>
<p>If you are ready to apply, just follow these three easy steps:</p>
<p><strong>Step 1:&nbsp;<a href="http://studentaffairs.stanfordtest.edu/resed/profiles/theme/list" target="_info">Review Theme House Requirements</a>:</strong>&nbsp;All themed houses have their unique set of requirements for pre-assigned residents.&nbsp;<strong>Read these pages carefully</strong>, since you'll be required to fulfill the requirements listed here, if you're placed into a house.</p>
<p><strong>Step 2:&nbsp;<a href="https://sawebapp.stanfordtest.edu/respositions/applicant/preassign/application.jsp?partid=1475">Complete your application materials</a>&nbsp;by [[ApplicationEndTime]].</strong>&nbsp;Remember, you can only apply to&nbsp;<strong>ONE</strong>&nbsp;house &amp; if accepted, you're automatically bound to the&nbsp;<a href="http://studentaffairs.stanfordtest.edu/resed/profiles/theme/list" target="_info">theme requirements</a>&nbsp;of that particular house.</p>
<p><strong>Step 3:&nbsp;<a href="https://sawebapp.stanfordtest.edu/respositions/applicant/preassign/offers.jsp">Check for a pre-assignment offer</a>&nbsp;on [[Offer-OfferStatus-StartTime]].</strong></p>
<p>Use the link above to check if you have been pre-assigned. If you have been pre-assigned, you will be exempted from The Draw &amp; automatically placed into the house to which you have applied. Again, once accepted, you&nbsp;<strong>CANNOT</strong>&nbsp;decline an offer.</p>
<p>&nbsp;Remember, you can only apply to ONE house &amp; if accepted, you're automatically bound to the theme requirements of that particular house.</p>
</div>
<div class="footer">&nbsp;</div>
EOF

pa_application_landing = <<-EOF
<h2 style="text-align: center;">[[CurrentProcess]]: Application Material</h2>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before beginning your application.</p>
<p><br /> A completed application includes:&nbsp;</p>
<ul>
<li>[[CurrentProcess]] Application Form&nbsp;</li>
<li>House Supplemental Questions</li>
</ul>
<p>Use the left bar to access each part of the application materials.&nbsp;You may check the clock icon next to the Application to know when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted.</strong></p>
<p>&nbsp;<strong>When you are ready to officially submit your application materials, be sure to click the "Submit Application" button </strong>to have them made available to Theme Houses for review. Once you have submitted your materials, you may cancel your application by clicking the ''Withdraw Application'' button.</p>
<p>However, you <strong>MUST</strong> accomplish the action of submitting or withdrawing your application no later than [[ApplicationEndTime]].</p>
<p>Application Form</p>
<p>Application materials are due on [[ApplicationEndTime]].</p>
<p>&nbsp;Required Form</p>
<p>&nbsp;*[[CurrentProcess]] Application Form&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<span style="color: #3366ff;">View</span></p>
<p>&nbsp;*House Supplemental Questions &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="color: #3366ff;">View</span></p>
<p>&nbsp;</p>
<div class="contentsection">
<h3>[[TheMessageAboutSubmitApplication]]</h3>
</div>
EOF

pa_interview_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>Pre-Assignment Interview Instruction</strong></span></p>
<p style="text-align: center;">&nbsp;</p>
<p>There is no interview needed for this process.</p>
<p><br /><br /></p>
EOF

pa_ranking_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Ranking Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before ranking your position.</p>
<p><br /> You may check the clock icon next to the Ranking to know when the start and end time will be.</p>
<p><strong>You need to finish your ranking within [[RankingStartTime]] to</strong></p>
<p><strong>[[RankingEndTime]] or your setting will not be accepted.</strong></p>
<p>You can adjust the ranking result by simple drag and drop actions to make your preferred positions upper than others.</p>
<p><br /><br /></p>
EOF

pa_offer_landing = <<-EOF
<p style="text-align: center;"><strong><span style="font-size: 14pt;">[[CurrentProcess]] Offer Instruction</span></strong></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Offer step.</p>
<p><br /> You may check the clock icon next to the Offer to know when the start and end time will be.</p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[Offer-OfferStatus-StartTime]] to [[Offer-OfferStatus-EndTime]] or your offer will be withdrawn directly.</strong></p>
<p>&nbsp;</p>
<p>&nbsp;</p>
EOF

pa_postmatch_landing = <<-EOF
<p style="text-align: center;"><strong><span style="font-size: 14pt;">[[CurrentProcess]] Post Match Instruction</span></strong></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Post Match step.</p>
<p><br /> You may check the clock icon next to the Post Match when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. If there is no required step, you may check the Offer Status directly.<br /> <br /> </strong></p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[PostMatch-OfferStatus-StartTime]] to</strong></p>
<p><strong>[[PostMatch-OfferStatus-EndTime]], or your offer will be withdrawn directly.</strong></p>
<p><br /><br /></p>
EOF

hss_process_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]]</strong></span></p>
<p>Residential Education: RA/Manager/Theme and Focus Assistant Application for [[CurrentYear]]</p>
<p>&nbsp;</p>
<p>Welcome to the Residential Education Student Staff Selection Process for the [[CurrentYear]] Academic Year!</p>
<p>&nbsp;</p>
<p>Prior to accessing online application materials through the links below, please visit http://studentaffairs.stanfordtest.edu/resed. There you can find information regarding the selection process, including but not limited to position descriptions, a timeline, advice on recommendations and FAQs. If you have any questions, comments or concerns at any stage of the process, please email selection@lists.stanfordtest.edu.</p>
<p>For all students who are applying for theme staff positions, please visit https://studentaffairs.stanfordtest.edu/resed/selection to find the supplemental questions.</p>
<p><br /> Application Process Overview</p>
<p>Step 1: <span style="color: #000080;"><span style="color: #3366ff;"><strong>Complete and submit your application materials</strong></span>.</span> Due online on [[ApplicationEndTime]].</p>
<p>Use the link above to access online application materials.</p>
<p><span style="color: #3366ff;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/combined/application.jsp?partid=1415"><span style="color: #3366ff;"><strong>You must include two letters of recommendation in your application materials</strong></span></a></span><strong>.</strong></p>
<p>Use the link above to access the form to request recommendations from your recommenders.</p>
<p>Step 2<strong>:<span style="color: #0000ff;">&nbsp;</span></strong><span style="color: #3366ff;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/combined/status.jsp"><span style="color: #3366ff;"><strong>Sign up for interviews</strong></span></a></span><span style="text-decoration: underline;"><span style="color: #0000ff; text-decoration: underline;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/combined/status.jsp"><span style="color: #0000ff; text-decoration: underline;"><strong>&nbsp;</strong></span></a></span></span><strong>beginning [[InterviewEndTime]]</strong></p>
<p>RFs/CDs/Supervisors/Hiring Staffs will send interview invitation to selected applicants. Use the link above to check if you have been offered any interviews and if yes, to sign up for dates and times.</p>
<p>Step 3<strong>:&nbsp;</strong><span style="color: #3366ff;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/combined/offers.jsp"><span style="color: #3366ff;"><strong>Check for a job offer</strong></span></a></span><strong>. Offers will be made on [[OfferStartTime]]</strong></p>
<p>Use the link above to check if you have been offered a position. If so, please accept or decline the offer by [[OfferEndTime]].</p>
<p>If you are matched to a house, you will receive only one offer. If you decline that offer, you may not be considered for any other Residential Education student staff vacancy.</p>
<p>Questions or comments? Visit the <span style="color: #3366ff;">Help</span> page.</p>
<p>&nbsp;</p>
EOF

hss_application_landing = <<-EOF
<p style="text-align: center;"><strong><span style="font-size: 14pt;">[[CurrentProcess]]: [[CurrentProcess]] Application Materials</span></strong></p>
<p><br /> Please read following instructions thoroughly before beginning your application.</p>
<p>A completed application for <strong>RA/Manager/Theme and Focus Assistant </strong>includes:</p>
<ul>
<li>A Completed application form</li>
<li>Completed recommendations:</li>
</ul>
<p>&nbsp; &nbsp;For new applicants: two (2) recommendations, at least one (1) from a Residential Education professional staff member (Residence Dean, Program Associate, Associate Dean), Resident Fellow/College Director, or Residential Education student staff member (RA, Manager, ATA, ETA, FA, LCATA).</p>
<p>&nbsp; &nbsp;For re-applicants: two (2) recommendations, one (1) from the RF/CD/Supervisor with whom you work(ed), one (1) from a co-staff member or a resident.</p>
<p>A completed application for <strong>Dorm and Row Process (RCC)</strong> includes:</p>
<ul>
<li>A completed application form, including essays.</li>
<li>For applicants who have never been an RCC before: two (2) letter of recommendation</li>
<li>For returning RCC applicants: one (1) reference.</li>
</ul>
<p>A completed application for <strong>Peer Health Educator (PHE)</strong> includes:</p>
<ul>
<li>A completed application form</li>
<li>Two (2) recommendations from individuals who can speak to your character and to the quality of your work. One of those individuals must be a current or former RF, RA or PHE. The other one can be other past or current residential staff members, faculty, staff, or advisors.</li>
</ul>
<p><br /> Use the left bar to access each part of the application materials.</p>
<p><br /> You may check the clock icon next to the Application to know when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. </strong></p>
<p><br /> For recommendations, provide each recommender's information, including email address, using the form that provided by this system. This will send an email to the recommender notifying him/her of your request for a recommendation; the recommender will then be able to access the ResJobs system to complete and submit his/her recommendation online.</p>
<p><strong>When you are ready to officially submit your application materials, be sure to click the "Submit Application" button </strong>to have them made available to Residential Education&nbsp;for review. Once you have submitted your materials, you may cancel your application by clicking the ''Withdraw Application'' button.</p>
<p>&nbsp;</p>
<p>However, you <strong>MUST</strong> accomplish the action of submitting or withdrawing your application no later than [[ApplicationEndTime]].</p>
<p>*<strong>Please note that when you submit your application for the PHE program, your name will be sent to current residential staff for their input on applicants.</strong></p>
<p>&nbsp;</p>
<p>Application Forms</p>
<p>Application materials are [[ApplicationEndTime]].</p>
<p>Required Form</p>
<ul>
<li>Completed application form &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<span style="color: #0000ff;">View</span></li>
<li>Recommendation form &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<span style="color: #0000ff;"> View</span></li>
</ul>
<p><br /> [[TheMessageAboutSubmitApplication]]</p>
<p><br /> Recommendation Form</p>
<p>After a recommendation request has been made, you can check if the recommendation has been submitted by returning to this page.</p>
<p>&nbsp;</p>
<p>Recommendation Form: [[Application-Recommendation-EndTime]]</p>
<p>[[TheMessageAboutRecommendationRequested]]</p>
<p>[[TheMessageAboutRecommendationReceived]]</p>
<p>[[TheMessageAboutRecommendationTimesUp]]</p>
<p>&nbsp;</p>
<p>Questions or comments? Visit the&nbsp;<a href="http://resjobs.stanfordtest.edu/help.jsp">Help</a>&nbsp;page.</p>
EOF

hss_interview_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Interview Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before beginning your interview application.</p>
<p><br /> You may check the clock icon next to the Interview to know when the start and end time of each interview round will be.</p>
<p><strong>Be prepared to sign up or cancel the interview within the required time or your application will not be accepted.</strong><br /> </p>
<p>Once you have been invited or even scheduled for an interview, you would see an icon next to that interview round on the left bar.<br /> Click that interview round(s) and check frequently your <strong>''My Interviews''</strong> to catch the latest updates and details.</p>
<p>You may sign up or cancel the time slot directly from<strong> ''My Interviews'' </strong>or <strong>''Calendar''</strong> within the interview round time.</p>
<p><br /> The place of your interview would be marked on both the box of ''<strong>Sign up Interview Time''</strong> under your <strong>''My Interviews'' and ''Calendar''</strong></p>
<p><br /> If you neither see any icon next to all the interview rounds of the left bar nor receive any Interview Invitation email, it means you haven't received any interview offer that were posting interviews this week. <br /> We may add additional interview times without notice. And we encourage you not to rely on email, and check ResJobs often.<strong><br /> </strong><br /> Questions or comments? Visit the&nbsp;<a href="http://resjobs.stanfordtest.edu/help.jsp">Help</a>&nbsp;page.</p>
<p><strong><br /> <br /> </strong></p>
EOF

hss_ranking_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Ranking Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before ranking your position.</p>
<p><br /> You may check the clock icon next to the Ranking to know when the start and end time will be.</p>
<p><strong>You need to finish your ranking within the required time or your setting will not be accepted.</strong><br /> </p>
<p>You can adjust the ranking result by simple drag and drop actions to make your preferred positions upper than others.</p>
<p><br /> Questions or comments? Visit the&nbsp;<a href="http://resjobs.stanfordtest.edu/help.jsp">Help</a>&nbsp;page.</p>
EOF

hss_offer_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Offer Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Offer step.</p>
<p><br /> You may check the clock icon next to the Offer to know when the start and end time will be.</p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[OfferStartTime]] to [[OfferEndTime]], or your offer will be withdrawn directly.</strong></p>
<p><br /> Questions or comments? Visit the&nbsp;<a href="http://resjobs.stanfordtest.edu/help.jsp">Help</a>&nbsp;page.</p>
<p>&nbsp;</p>
EOF

hss_postmatch_landing = <<-EOF
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]] Post Match Instruction</strong></span></p>
<p>&nbsp;</p>
<p>Please read following instructions thoroughly before going to the Post Match step.</p>
<p><br /> You may check the clock icon next to the Post Match when the start and end time of each step will be. <strong>Be prepared to fulfill each step within the required time or your application will not be accepted. If there is no required step, you may check the Offer Status directly.<br /> <br /> </strong></p>
<p><strong>When you received an offer, you have to confirm or decline this offer within [[PostMatch-OfferStatus-StartTime]] to [[PostMatch-OfferStatus-EndTime]], or your offer will be withdrawn directly.</strong></p>
<p><br /> Questions or comments? Visit the&nbsp;<a href="http://resjobs.stanfordtest.edu/help.jsp">Help</a>&nbsp;page.</p>
EOF

processes_data = [
=begin
  {
    "id"=> 1,
    "name"=> "Dorm and Row Process (RCC)",
    "status"=> 1,
    "display_order"=> 1,
    "link"=> "url1",
    "landing"=> drp_landing,
    "application_materials"=> drp_app,
    "matchType"=> 1,
    "rankType"=> 2,
    "acronym" => "DRP",
    "recommendations_data" => {
      "number"=> 2,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Two recommendations are required.</strong></p>",
    }
  },
=end
  {
    "id"=> 2,
    "name"=> "Graduate Community Associate (CA)",
    "status"=> 1,
    "display_order"=> 2,
    "link"=> "url2",
    "process_landing"=> ca_process_landing,
    "application_landing"=> ca_application_landing,
    "interview_landing"=> ca_interview_landing,
    "ranking_landing"=> ca_ranking_landing,
    "offer_landing"=> ca_offer_landing,
    "postmatch_landing"=> ca_postmatch_landing,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "CA",
    "recommendations_data" => {
      "number"=> 1,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>One recommendations are required.</strong></p>",
    }
  },
  {
    "id"=> 3,
    "name"=> "Graduate Resident Computer Consultant (RCC)",
    "status"=> 1,
    "display_order"=> 3,
    "link"=> "url3",
    "process_landing"=> rcc_process_landing,
    "application_landing"=> rcc_application_landing,
    "interview_landing"=> rcc_interview_landing,
    "ranking_landing"=> rcc_ranking_landing,
    "offer_landing"=> rcc_offer_landing,
    "postmatch_landing"=> rcc_postmatch_landing,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "RCC",
    "recommendations_data" => {
      "number"=> 3,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Three recommendations are required.</strong></p><p><strong>* For current undergraduate RCCs, the recommender must be a RF/CD or Fellow Staff or Resident. If recommender is a RCC, he/she should not also be applying to RCC position again.</strong></p>",
    }
  },
=begin
  {
    "id"=> 4,
    "name"=> "Peer Health Educator (PHE)",
    "status"=> 1,
    "display_order"=> 4,
    "link"=> "url4",
    "landing"=> phe_landing,
    "application_materials"=> phe_app,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "PHE",
    "recommendations_data" => {
      "number"=> 5,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Five recommendations are required.</strong></p>",
    }
  },
=end
  {
    "id"=> 5,
    "name"=> "Pre-Assignment",
    "status"=> 1,
    "display_order"=> 5,
    "link"=> "url5",
    "process_landing"=> pa_process_landing,
    "application_landing"=> pa_application_landing,
    "interview_landing"=> pa_interview_landing,
    "ranking_landing"=> pa_ranking_landing,
    "offer_landing"=> pa_offer_landing,
    "postmatch_landing"=> pa_postmatch_landing,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "PA",
    "recommendations_data" => {
      "number"=> 4,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Four recommendations are required.</strong></p>",
    }
  },
=begin
  {
    "id"=> 6,
    "name"=> "RA/Manager/Theme and Focus Assistant",
    "status"=> 1,
    "display_order"=> 6,
    "link"=> "url6",
    "landing"=> ra_landing,
    "application_materials"=> ra_app,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "RMTFA",
    "recommendations_data" => {
      "number"=> 3,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Three recommendations are required.</strong></p>",
    }
  },
=end
  {
    "id"=> 7,
    "name"=> "House Staff Selection",
    "status"=> 1,
    "display_order"=> 7,
    "link"=> "url6",
    "process_landing"=> hss_process_landing,
    "application_landing"=> hss_application_landing,
    "interview_landing"=> hss_interview_landing,
    "ranking_landing"=> hss_ranking_landing,
    "offer_landing"=> hss_offer_landing,
    "postmatch_landing"=> hss_postmatch_landing,
    "matchType"=> 1,
    "rankType"=> 1,
    "acronym" => "HSS",
    "recommendations_data" => {
      "number"=> 3,
      "show_recommendation"=>false,
      "requirement"=> "<p><strong>Three recommendations are required.</strong></p>",
    }
  }
];

process_step = [
    {
      "name" => "Process",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => true,
      "userView" => false,
      "sub_step" => [{
          "name" => "Set Up Positions",
          "identify_name" => "set_up_positions",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up Rounds",
          "identify_name" => "set_up_rounds",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up System Forms",
          "identify_name" => "set_up_system_forms",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up Recommendation Forms",
          "identify_name" => "set_up_recommendation_forms",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up Interview Forms",
          "identify_name" => "set_up_interview_forms",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up Attachable Forms",
          "identify_name" => "set_up_attachable_forms",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Set Up Emails",
          "identify_name" => "set_up_emails",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "System Message",
          "identify_name" => "system_message",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "Manage Applicants",
          "identify_name" => "applicants",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "name" => "RD Flag",
          "identify_name" => "rd_flag",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        }]
    },
    {
      "name" => "Application",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => true,
      "userView" => true,
      "sub_step" => [{
          "name" => "Select Position",
          "identify_name" => "select_position",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Fill in Form",
          "identify_name" => "fill_in_form",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Recommendation",
          "identify_name" => "recommendation",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Submit Application",
          "identify_name" => "submit_application",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        }]
    },
    {
      "name" => "Interview",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => true,
      "userView" => true,
      "sub_step" => []
    },
    {
      "name" => "Ranking",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => true,
      "userView" => true,
      "sub_step" => [{
          "name" => "Rank Position",
          "identify_name" => "ranking",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        }]
    },
    {
      "name" => "Offer",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => true,
      "userView" => true,
      "sub_step" => [{
          "name" => "Match",
          "identify_name" => "match",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => false
        },
        {
          "rank" => 0,
          "name" => "Offer Status",
          "identify_name" => "offer",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        }]
    },
    {
      "name" => "Post Match",
      "start" => (Time.now - 8.days),
      "end" => (Time.now + 2.months),
      "enabled" => false,
      "userView" => true,
      "sub_step" => [{
          "name" => "Invitation",
          "identify_name" => "post_offer_invitations",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Fill in Form",
          "identify_name" => "post_offer_fill_in_form",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Post Match Interview",
          "identify_name" => "post_offer_interview",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        },
        {
          "name" => "Offer Status",
          "identify_name" => "post_offer_offer",
          "enabled" => true,
          "start" => (Time.now - 7.days),
          "end" => (Time.now + 1.months),
          "userView" => true
        }]
    }
];

ca_application_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/index.jsp">Graduate Community Associate (CA)</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/application.jsp?partid=1464">Application Form</a>: Graduate Community Assistant Application</h2>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Student ID</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Degree/Program</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Are you a co-term?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Spouse / Partner Name (if applicable):</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">How many years have you been at </label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Have you applied to the CA program before?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Stanford (including the current academic year)?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-13" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current Residential Area:</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-14" class="drop-block col-lg-6 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name(s) of your current CA(s):</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Please list other graduate residence you have lived in at Stanford</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-16" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Application Questions</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-17" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Why are you applying to be a CA?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-18" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. What leadership and/or volunteer activities have you been involved in? What have you learned from those leadership/volunteer experiences that may help you in the CA role?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-19" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Describe a team you have been involved with and what role you played.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-20" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. What do you like MOST and LEAST about your residential experience this year? Which neighborhood CA events have you attended? Have you helped your current CAs organize or fun any events? If so, please briefly describe what you did.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-21" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. Describe three events (one from each of these areas: academic, health/wellness, and social) that you would organize as a CA, and explain how each event would build community in your residence.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-22" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">6. Please describe how you would reach out to your residents.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-23" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">7. List your time commitments for the next academic year (including teaching, paid work, sports, organizations, job hunting, etc.). Please estimate the number of hours per week each activity will require.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

ca_application_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/index.jsp\\\"\\u003eGraduate Community Associate (CA)\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/application.jsp?partid=1464\\\"\\u003eApplication Form\\u003c/a\\u003e: Graduate Community Assistant Application\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Student ID\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Degree/Program\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":1,\"description\":\"Are you a co-term?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Spouse / Partner Name (if applicable):\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"How many years have you been at \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":1,\"description\":\"Have you applied to the CA program before?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":8,\"column\":0,\"description\":\"Stanford (including the current academic year)?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":0,\"description\":\"Current Residential Area:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":1,\"description\":\"Name(s) of your current CA(s):\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":0,\"description\":\"Please list other graduate residence you have lived in at Stanford\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":11,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eApplication Questions\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":12,\"column\":0,\"description\":\"1. Why are you applying to be a CA?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"2. What leadership and/or volunteer activities have you been involved in? What have you learned from those leadership/volunteer experiences that may help you in the CA role?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"3. Describe a team you have been involved with and what role you played.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"4. What do you like MOST and LEAST about your residential experience this year? Which neighborhood CA events have you attended? Have you helped your current CAs organize or fun any events? If so, please briefly describe what you did.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"5. Describe three events (one from each of these areas: academic, health/wellness, and social) that you would organize as a CA, and explain how each event would build community in your residence.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"6. Please describe how you would reach out to your residents.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"7. List your time commitments for the next academic year (including teaching, paid work, sports, organizations, job hunting, etc.). Please estimate the number of hours per week each activity will require.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

ca_system_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/index.jsp">Graduate Community Associate (CA)</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/application.jsp?partid=1464">Application Form</a>: Graduate Community Assistant Application</h2>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">First Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Middle Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-5" class="drop-block col-lg-4 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Last Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">SUNetID</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Degree/Program</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Are you a co-term?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Spouse / Partner Name (if applicable):</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">How many years have you been at </label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-13" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Have you applied to the CA program before?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-14" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Stanford (including the current academic year)?</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current Residential Area:</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-16" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name(s) of your current CA(s):</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-17" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Please list other graduate residence you have lived in at Stanford</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-18" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Application Questions</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-19" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Why are you applying to be a CA?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-20" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. What leadership and/or volunteer activities have you been involved in? What have you learned from those leadership/volunteer experiences that may help you in the CA role?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-21" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Describe a team you have been involved with and what role you played.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-22" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. What do you like MOST and LEAST about your residential experience this year? Which neighborhood CA events have you attended? Have you helped your current CAs organize or fun any events? If so, please briefly describe what you did.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-23" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. Describe three events (one from each of these areas: academic, health/wellness, and social) that you would organize as a CA, and explain how each event would build community in your residence.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-24" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">6. Please describe how you would reach out to your residents.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-25" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">7. List your time commitments for the next academic year (including teaching, paid work, sports, organizations, job hunting, etc.). Please estimate the number of hours per week each activity will require.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

ca_system_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/index.jsp\\\"\\u003eGraduate Community Associate (CA)\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-ca/application.jsp?partid=1464\\\"\\u003eApplication Form\\u003c/a\\u003e: Graduate Community Assistant Application\\u003c/h2\\u003e\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"First Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Middle Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":3,\"column\":2,\"description\":\"Last Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"SUNetID\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Phone\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":4,\"column\":2,\"description\":\"Email\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Degree/Program\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":1,\"description\":\"Are you a co-term?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Spouse / Partner Name (if applicable):\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"How many years have you been at \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":1,\"description\":\"Have you applied to the CA program before?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":8,\"column\":0,\"description\":\"Stanford (including the current academic year)?\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":0,\"description\":\"Current Residential Area:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":1,\"description\":\"Name(s) of your current CA(s):\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":0,\"description\":\"Please list other graduate residence you have lived in at Stanford\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":11,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eApplication Questions\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":12,\"column\":0,\"description\":\"1. Why are you applying to be a CA?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"2. What leadership and/or volunteer activities have you been involved in? What have you learned from those leadership/volunteer experiences that may help you in the CA role?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"3. Describe a team you have been involved with and what role you played.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"4. What do you like MOST and LEAST about your residential experience this year? Which neighborhood CA events have you attended? Have you helped your current CAs organize or fun any events? If so, please briefly describe what you did.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"5. Describe three events (one from each of these areas: academic, health/wellness, and social) that you would organize as a CA, and explain how each event would build community in your residence.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"6. Please describe how you would reach out to your residents.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"7. List your time commitments for the next academic year (including teaching, paid work, sports, organizations, job hunting, etc.). Please estimate the number of hours per week each activity will require.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

ca_interview_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><strong>Interview Review Form for GCA</strong></h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2>
<p><span style="color: #000000;"><strong>RECOMMENDATION:</strong></span></p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Row:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Upperclass:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Four Class:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Freshmen:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Describe the applicant's understanding of the this role and responsibilities.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Additional comments, including any potential conflicts with the position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2></div>
        </div></div></div>
EOF

ca_interview_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eInterview Review Form for GCA\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cspan style=\\\"color: #000000;\\\"\\u003e\\u003cstrong\\u003eRECOMMENDATION:\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Row:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Upperclass:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Four Class:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Freshmen:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Describe the applicant's understanding of the this role and responsibilities.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Additional comments, including any potential conflicts with the position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\",\"type\":\"description\"}]"

rcc_application_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/index.jsp">Graduate Resident Computer Consultant (RCC)</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/application.jsp?partid=1437">Graduate RCC Application Materials</a>: Graduate RCC Application</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Preferred Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">SUID</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Radio button</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Male</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>Female</span></label></div></div></div><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Ethnicity</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone (if any)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Citizenship/Visa Status</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus residence</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Room</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus Phone (dial 7-CALL from room phone for number)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current Mailing Address</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-13" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Year in school</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-14" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Department/Academic Major(s</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Select your status for the current academic year</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-16" class="drop-block col-lg-6 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Undergraduate university &amp; degree</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-17" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-18" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-20" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.</strong></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-13" style="border: 2px dashed transparent;"><div id="exist-drop-19" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-21" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Photo</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-14" style="border: 2px dashed transparent;"><div id="exist-drop-20" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-22" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Please provide a photo of yourself. It must be 250 pixels by 250 pixels and a clear headshot of yourself (think passport photo).</strong>&nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename)</p>
</div>
        </div><div id="exist-sort-23" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="file">File Upload</label>
          <input type="file">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-15" style="border: 2px dashed transparent;"><div id="exist-drop-21" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-24" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Applicant Profile</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-16" style="border: 2px dashed transparent;"><div id="exist-drop-22" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-25" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">1. Please select one of the following:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>I have never been an RCC before</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>I am currently an RCC</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option2-0"><span>I was an RCC in a previous year</span></label></div></div><div id="exist-sort-26" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">2. If you have never been an RCC before, have you previously applied for the RCC position?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-27" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Previous/current/future Stanford jobs (if any)? Please include job title, department, hours and duration for each job. In addition, please also list any RAships or CAships.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-28" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">4. Select your status for the next academic year (not the current year):</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-29" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-30" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">5. Degree you are pursuing</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-31" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-32" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">6. Number of years you have attended Stanford, including the current academic year</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-33" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">7. Number of years you have lived in the residences on campus, including the current academic year</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-34" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">8. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-35" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If no, please explain why</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-36" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">9. Would you be willing to move for the RCC position? (RCCs must live in their service area.)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-37" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">10. If positions are available, are you interested in starting the RCC position early (eg. Summer)?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes, Summer 2015</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No, I would like to start Fall 2015</span></label></div></div><div id="exist-sort-38" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">11. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-39" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">12. Do you acknowledge that you will be available on campus for training and opening beginning early August 2014?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-40" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">13. How did you hear about the RCC position?</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-41" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If you selected "Other," please enter here</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-42" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">14. What are your hobbies and interests?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-17" style="border: 2px dashed transparent;"><div id="exist-drop-23" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-43" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><strong><span style="font-size: 14pt;">Essays (for all applicants)</span></strong></h3>
</div>
        </div><div id="exist-sort-44" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">15. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-45" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">16. Please tell us why we should hire you. Bonus points for creativity.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-18" style="border: 2px dashed transparent;"><div id="exist-drop-24" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-46" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><strong><span style="font-size: 14pt;">For new Applicants or former RCCs reapplying only:</span></strong></h3>
</div>
        </div><div id="exist-sort-47" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">17. In addition to helping residents with computer and network issues, RCCs educate residents as well as serve as members of the Rescomp community. Refer to http://stucomp.stanfordtest.edu/jobs/rcc for more details on the position. Please describe why you are qualified for the RCC position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-48" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">18. Describe any previous experience working on a team and how you would problem solve as a team member.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-49" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">19. List any skills and experience relevant to the RCC position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-50" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">20. Please explain your process for troubleshooting problems you've never seen before.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-51" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">21. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-52" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">22. Who is someone you look up to and explain why he/she is an exemplar for you.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-53" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>For Current RCCs Only</strong></span></h3>
</div>
        </div><div id="exist-sort-54" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">23. Please share what you have accomplished as an RCC this year so far.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-55" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">24. What have you contributed to the greater RCC and Rescomp community this year? What do you hope to contribute next year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-56" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>25. For current graduate RCCs, please provide a reference:</strong></p>
</div>
        </div><div id="exist-sort-57" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-58" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Title</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-59" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Relationship</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-60" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-61" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-62" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>26. For current graduate RCCs, please provide a secondary reference</strong></p>
</div>
        </div><div id="exist-sort-63" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-64" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Title</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-65" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Relationship</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-66" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-67" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div></div>
EOF

rcc_application_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/index.jsp\\\"\\u003eGraduate Resident Computer Consultant (RCC)\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/application.jsp?partid=1437\\\"\\u003eGraduate RCC Application Materials\\u003c/a\\u003e: Graduate RCC Application\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Preferred Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":1,\"description\":\"SUID\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Radio button\",\"type\":\"radio\",\"options\":[\"Male\",\"\\u003cbr /\\u003e\",\"Female\"],\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Ethnicity\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Cell Phone (if any)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Citizenship/Visa Status\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Campus residence\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":1,\"description\":\"Room\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"Campus Phone (dial 7-CALL from room phone for number)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":8,\"column\":0,\"description\":\"Current Mailing Address\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":0,\"description\":\"Year in school\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":1,\"description\":\"Department/Academic Major(s\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":0,\"description\":\"Select your status for the current academic year\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":1,\"description\":\"Undergraduate university \\u0026amp; degree\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":11,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eOPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":13,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003ePhoto\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease provide a photo of yourself. It must be 250 pixels by 250 pixels and a clear headshot of yourself (think passport photo).\\u003c/strong\\u003e\\u0026nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename)\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"File Upload\",\"type\":\"file\"},{\"row\":15,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eApplicant Profile\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":16,\"column\":0,\"description\":\"1. Please select one of the following:\",\"type\":\"radio\",\"options\":[\"I have never been an RCC before\",\"\\u003cbr /\\u003e\",\"I am currently an RCC\",\"\\u003cbr /\\u003e\",\"I was an RCC in a previous year\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"2. If you have never been an RCC before, have you previously applied for the RCC position?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"3. Previous/current/future Stanford jobs (if any)? Please include job title, department, hours and duration for each job. In addition, please also list any RAships or CAships.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"4. Select your status for the next academic year (not the current year):\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"5. Degree you are pursuing\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"6. Number of years you have attended Stanford, including the current academic year\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"7. Number of years you have lived in the residences on campus, including the current academic year\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"8. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If no, please explain why\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"9. Would you be willing to move for the RCC position? (RCCs must live in their service area.)\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"10. If positions are available, are you interested in starting the RCC position early (eg. Summer)?\",\"type\":\"radio\",\"options\":[\"Yes, Summer 2015\",\"\\u003cbr /\\u003e\",\"No, I would like to start Fall 2015\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"11. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"12. Do you acknowledge that you will be available on campus for training and opening beginning early August 2014?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"13. How did you hear about the RCC position?\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"14. What are your hobbies and interests?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eEssays (for all applicants)\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":17,\"column\":0,\"description\":\"15. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":0,\"description\":\"16. Please tell us why we should hire you. Bonus points for creativity.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eFor new Applicants or former RCCs reapplying only:\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"17. In addition to helping residents with computer and network issues, RCCs educate residents as well as serve as members of the Rescomp community. Refer to http://stucomp.stanfordtest.edu/jobs/rcc for more details on the position. Please describe why you are qualified for the RCC position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"18. Describe any previous experience working on a team and how you would problem solve as a team member.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"19. List any skills and experience relevant to the RCC position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"20. Please explain your process for troubleshooting problems you've never seen before.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"21. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"22. Who is someone you look up to and explain why he/she is an exemplar for you.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eFor Current RCCs Only\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"23. Please share what you have accomplished as an RCC this year so far.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"24. What have you contributed to the greater RCC and Rescomp community this year? What do you hope to contribute next year?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003e25. For current graduate RCCs, please provide a reference:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Title\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Relationship\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003e26. For current graduate RCCs, please provide a secondary reference\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Title\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Relationship\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false}]"

rcc_system_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/index.jsp">Graduate Resident Computer Consultant (RCC)</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/application.jsp?partid=1437">Graduate RCC Application Materials</a>: Graduate RCC Application</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">First Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Middle Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Last Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Preferred Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">SUNetID</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Radio button</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Male</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>Female</span></label></div></div></div><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Ethnicity</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone (if any)</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-10" class="drop-block col-lg-4 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Citizenship/Visa Status</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus residence</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-13" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Room</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-14" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus Phone (dial 7-CALL from room phone for number)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Address</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-16" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Year in school</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-17" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Department/Academic Major(s)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-18" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-20" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Select your status for the current academic year</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-19" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-21" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Undergraduate university &amp; degree</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-20" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-22" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-21" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-23" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.</strong></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-13" style="border: 2px dashed transparent;"><div id="exist-drop-22" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-24" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Photo</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-14" style="border: 2px dashed transparent;"><div id="exist-drop-23" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-25" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Please provide a photo of yourself. It must be 250 pixels by 250 pixels and a clear headshot of yourself (think passport photo).</strong>&nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename)</p>
</div>
        </div><div id="exist-sort-26" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="file">File Upload</label>
          <input type="file">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-15" style="border: 2px dashed transparent;"><div id="exist-drop-24" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-27" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;">Applicant Profile</span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-16" style="border: 2px dashed transparent;"><div id="exist-drop-25" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-28" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">1. Please select one of the following:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>I have never been an RCC before</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>I am currently an RCC</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option2-0"><span>I was an RCC in a previous year</span></label></div></div><div id="exist-sort-29" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">2. If you have never been an RCC before, have you previously applied for the RCC position?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-30" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Previous/current/future Stanford jobs (if any)? Please include job title, department, hours and duration for each job. In addition, please also list any RAships or CAships.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-31" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">4. Select your status for the next academic year (not the current year):</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-32" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-33" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">5. Degree you are pursuing</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-34" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-35" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">6. Number of years you have attended Stanford, including the current academic year</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-36" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">7. Number of years you have lived in the residences on campus, including the current academic year</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-37" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">8. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-38" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If no, please explain why</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-39" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">9. Would you be willing to move for the RCC position? (RCCs must live in their service area.)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-40" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">10. If positions are available, are you interested in starting the RCC position early (eg. Summer)?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes, Summer 2015</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No, I would like to start Fall 2015</span></label></div></div><div id="exist-sort-41" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">11. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-42" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">12. Do you acknowledge that you will be available on campus for training and opening beginning early August 2014?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-43" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">13. How did you hear about the RCC position?</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-44" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If you selected "Other," please enter here</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-45" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">14. What are your hobbies and interests?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-17" style="border: 2px dashed transparent;"><div id="exist-drop-26" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-46" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><strong><span style="font-size: 14pt;">Essays (for all applicants)</span></strong></h3>
</div>
        </div><div id="exist-sort-47" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">15. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-48" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">16. Please tell us why we should hire you. Bonus points for creativity.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-18" style="border: 2px dashed transparent;"><div id="exist-drop-27" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-49" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><strong><span style="font-size: 14pt;">For new Applicants or former RCCs reapplying only:</span></strong></h3>
</div>
        </div><div id="exist-sort-50" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">17. In addition to helping residents with computer and network issues, RCCs educate residents as well as serve as members of the Rescomp community. Refer to http://stucomp.stanfordtest.edu/jobs/rcc for more details on the position. Please describe why you are qualified for the RCC position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-51" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">18. Describe any previous experience working on a team and how you would problem solve as a team member.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-52" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">19. List any skills and experience relevant to the RCC position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-53" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">20. Please explain your process for troubleshooting problems you've never seen before.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-54" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">21. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-55" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">22. Who is someone you look up to and explain why he/she is an exemplar for you.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-56" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>For Current RCCs Only</strong></span></h3>
</div>
        </div><div id="exist-sort-57" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">23. Please share what you have accomplished as an RCC this year so far.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-58" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">24. What have you contributed to the greater RCC and Rescomp community this year? What do you hope to contribute next year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-59" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>25. For current graduate RCCs, please provide a reference:</strong></p>
</div>
        </div><div id="exist-sort-60" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-61" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Title</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-62" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Relationship</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-63" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-64" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-65" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>26. For current graduate RCCs, please provide a secondary reference</strong></p>
</div>
        </div><div id="exist-sort-66" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-67" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Title</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-68" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Relationship</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-69" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-70" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div></div>
EOF

rcc_system_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/index.jsp\\\"\\u003eGraduate Resident Computer Consultant (RCC)\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/grad-rcc/application.jsp?partid=1437\\\"\\u003eGraduate RCC Application Materials\\u003c/a\\u003e: Graduate RCC Application\\u003c/h2\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"First Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":1,\"description\":\"Middle Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":2,\"description\":\"Last Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Preferred Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":1,\"description\":\"SUNetID\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Radio button\",\"type\":\"radio\",\"options\":[\"Male\",\"\\u003cbr /\\u003e\",\"Female\"],\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Ethnicity\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Cell Phone (if any)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":2,\"description\":\"Phone\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Citizenship/Visa Status\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Campus residence\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":1,\"description\":\"Room\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"Campus Phone (dial 7-CALL from room phone for number)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":8,\"column\":0,\"description\":\"Address\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":9,\"column\":0,\"description\":\"Year in school\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":9,\"column\":1,\"description\":\"Department/Academic Major(s)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":0,\"description\":\"Select your status for the current academic year\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":10,\"column\":1,\"description\":\"Undergraduate university \\u0026amp; degree\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":11,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"\\n\\u003cp\\u003e\\u003cstrong\\u003eOPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":13,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003ePhoto\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease provide a photo of yourself. It must be 250 pixels by 250 pixels and a clear headshot of yourself (think passport photo).\\u003c/strong\\u003e\\u0026nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename)\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"File Upload\",\"type\":\"file\"},{\"row\":15,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eApplicant Profile\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":16,\"column\":0,\"description\":\"1. Please select one of the following:\",\"type\":\"radio\",\"options\":[\"I have never been an RCC before\",\"\\u003cbr /\\u003e\",\"I am currently an RCC\",\"\\u003cbr /\\u003e\",\"I was an RCC in a previous year\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"2. If you have never been an RCC before, have you previously applied for the RCC position?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"3. Previous/current/future Stanford jobs (if any)? Please include job title, department, hours and duration for each job. In addition, please also list any RAships or CAships.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"4. Select your status for the next academic year (not the current year):\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"5. Degree you are pursuing\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"6. Number of years you have attended Stanford, including the current academic year\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"7. Number of years you have lived in the residences on campus, including the current academic year\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"8. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If no, please explain why\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"9. Would you be willing to move for the RCC position? (RCCs must live in their service area.)\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"10. If positions are available, are you interested in starting the RCC position early (eg. Summer)?\",\"type\":\"radio\",\"options\":[\"Yes, Summer 2015\",\"\\u003cbr /\\u003e\",\"No, I would like to start Fall 2015\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"11. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"12. Do you acknowledge that you will be available on campus for training and opening beginning early August 2014?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"13. How did you hear about the RCC position?\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":0,\"description\":\"14. What are your hobbies and interests?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eEssays (for all applicants)\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":17,\"column\":0,\"description\":\"15. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":0,\"description\":\"16. Please tell us why we should hire you. Bonus points for creativity.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eFor new Applicants or former RCCs reapplying only:\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"17. In addition to helping residents with computer and network issues, RCCs educate residents as well as serve as members of the Rescomp community. Refer to http://stucomp.stanfordtest.edu/jobs/rcc for more details on the position. Please describe why you are qualified for the RCC position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"18. Describe any previous experience working on a team and how you would problem solve as a team member.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"19. List any skills and experience relevant to the RCC position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"20. Please explain your process for troubleshooting problems you've never seen before.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"21. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"22. Who is someone you look up to and explain why he/she is an exemplar for you.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eFor Current RCCs Only\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"23. Please share what you have accomplished as an RCC this year so far.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"24. What have you contributed to the greater RCC and Rescomp community this year? What do you hope to contribute next year?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\u003cp\\u003e\\u003cstrong\\u003e25. For current graduate RCCs, please provide a reference:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Title\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Relationship\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"\\n\\u003cp\\u003e\\u003cstrong\\u003e26. For current graduate RCCs, please provide a secondary reference\\u003c/strong\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Title\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Relationship\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":18,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false}]"

rcc_interview_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><strong>Interview Review Form for&nbsp;GRCC</strong></h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2>
<p><span style="color: #000000;"><strong>RECOMMENDATION:</strong></span></p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Row:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Upperclass:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Four Class:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Freshmen:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Describe the applicant's understanding of the this role and responsibilities.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Additional comments, including any potential conflicts with the position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2></div>
        </div></div></div>
EOF

rcc_interview_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eInterview Review Form for\\u0026nbsp;GRCC\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cspan style=\\\"color: #000000;\\\"\\u003e\\u003cstrong\\u003eRECOMMENDATION:\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Row:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Upperclass:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Four Class:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Freshmen:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Describe the applicant's understanding of the this role and responsibilities.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Additional comments, including any potential conflicts with the position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\",\"type\":\"description\"}]"

rcc_recommendation_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><strong><span style="font-size: 14pt;">Graduate Resident Computer Consultant (RCC)</span></strong></h2>
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>: Recommendation Form</strong></span></p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>To the Recommender<br> <br> RCCs are undergraduate and graduate students who live in University residences and educate residents on all aspects of computing at Stanford, consult with residents on computer related problems, and support in-room network connections. RCCs usually work as members of a staff team. Most importantly, RCCs are expected to be available to residents. RCCs work primarily with the residence staff, their designated Residential Computer Cluster Technician, Networking and Communications Services, and the Residential Computing central support staff to accomplish their goals. For more information, visit the RCC Job Description at</p>
<p>http://rescomp.stanfordtest.edu/about/jobs/rcc/.<br> <br> Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Please complete the recommendation form by using the form below.</strong></p>
<p><strong>&nbsp;</strong></p>
<p>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<p>To officially submit your recommendation, hit "<strong>Submit</strong>." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.&nbsp;</p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 align="center"><span lang="EN-US">Recommendation Questions</span></h3>
<p><span lang="EN-US">Please respond to the following questions.</span></p>
</div>
        </div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly list the candidate's strengths.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly discuss the areas in which the candidate might improve.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">In no more than 250 words, please comment on the applicant's personal qualities in relation to the RCC's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

rcc_recommendation_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eGraduate Resident Computer Consultant (RCC)\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003e: Recommendation Form\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003eTo the Recommender\\u003cbr\\u003e \\u003cbr\\u003e RCCs are undergraduate and graduate students who live in University residences and educate residents on all aspects of computing at Stanford, consult with residents on computer related problems, and support in-room network connections. RCCs usually work as members of a staff team. Most importantly, RCCs are expected to be available to residents. RCCs work primarily with the residence staff, their designated Residential Computer Cluster Technician, Networking and Communications Services, and the Residential Computing central support staff to accomplish their goals. For more information, visit the RCC Job Description at\\u003c/p\\u003e\\n\\u003cp\\u003ehttp://rescomp.stanfordtest.edu/about/jobs/rcc/.\\u003cbr\\u003e \\u003cbr\\u003e Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003eTo officially submit your recommendation, hit \\\"\\u003cstrong\\u003eSubmit\\u003c/strong\\u003e.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 align=\\\"center\\\"\\u003e\\u003cspan lang=\\\"EN-US\\\"\\u003eRecommendation Questions\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u003cspan lang=\\\"EN-US\\\"\\u003ePlease respond to the following questions.\\u003c/span\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Briefly list the candidate's strengths.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Briefly discuss the areas in which the candidate might improve.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to the RCC's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

pa_application_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><span style="font-size: 14pt;"><strong><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/index.jsp">Pre-Assignment</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/application.jsp?partid=1476">Application Material</a>: Pre-Assignment Application Form</strong></span></h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></h3>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">SUID</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Preferred Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone (if any)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current campus residence</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current Mailing Address</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Please list any other house(s) you may have lived in</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Room</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Year in school</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-8" class="drop-block col-lg-6 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Department/Academic Major(s)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>Applicant Profile</strong></span></h3>
</div>
        </div><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Select your housing status for the next academic year (not current year)?</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-18" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Number of years you have attended Stanford, including the current academic year:</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-19" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-20" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If no, please explain why:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-21" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>General Terms and Conditions</strong></span></h3>
</div>
        </div><div id="exist-sort-22" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that if pre-assigned to a house, I relinquish the right to enter the 2014-2015 Undergraduate Housing Draw. I certify that I have at least one year of guaranteed undergraduate housing remaining to take advantage of this opportunity. I certify that I have read, understand and meet the stipulations stated as part of the Policies &amp; Eligibility for Pre-Assignment.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-23" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that once pre-assigned I must complete all of the requirements for the specific house as indicated below &amp; on each house's profile page on the Themed WebSite. I also understand that failure to fulfill these requirements once pre-assigned may result in disciplinary action up to and including loss of on-campus housing.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-24" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I also understand that students who pre-assign to a house are not guaranteed any particular room type (single, one room double, two room double).</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div></div></div>
EOF

pa_application_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/index.jsp\\\"\\u003ePre-Assignment\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/application.jsp?partid=1476\\\"\\u003eApplication Material\\u003c/a\\u003e: Pre-Assignment Application Form\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"SUID\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":1,\"description\":\"Preferred Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":1,\"description\":\"Cell Phone (if any)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Current campus residence\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Campus Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Current Mailing Address\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Please list any other house(s) you may have lived in\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Room\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Year in school\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Department/Academic Major(s)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eApplicant Profile\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":5,\"column\":0,\"description\":\"Select your housing status for the next academic year (not current year)?\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Number of years you have attended Stanford, including the current academic year:\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"If no, please explain why:\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eGeneral Terms and Conditions\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":5,\"column\":0,\"description\":\"I understand that if pre-assigned to a house, I relinquish the right to enter the 2014-2015 Undergraduate Housing Draw. I certify that I have at least one year of guaranteed undergraduate housing remaining to take advantage of this opportunity. I certify that I have read, understand and meet the stipulations stated as part of the Policies \\u0026amp; Eligibility for Pre-Assignment.\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"I understand that once pre-assigned I must complete all of the requirements for the specific house as indicated below \\u0026amp; on each house's profile page on the Themed WebSite. I also understand that failure to fulfill these requirements once pre-assigned may result in disciplinary action up to and including loss of on-campus housing.\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"I also understand that students who pre-assign to a house are not guaranteed any particular room type (single, one room double, two room double).\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false}]"

pa_system_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><span style="font-size: 14pt;"><strong><a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/index.jsp">Pre-Assignment</a>:&nbsp;<a href="https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/application.jsp?partid=1476">Application Material</a>: Pre-Assignment Application Form</strong></span></h2>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>Personal Information</strong></span></h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">

          <label class="simple" ps="yes" rq="no">First Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">

          <label class="simple" ps="yes" rq="no">Middle Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-3" class="drop-block col-lg-4 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">

          <label class="simple" ps="yes" rq="no">Last Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">SUNetID</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Email</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Preferred Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone (if any)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">

          <label class="simple" ps="yes" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current campus residence</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-12" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Campus Phone</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Current Mailing Address</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Please list any other house(s) you may have lived in</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Room</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Year in school</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you selected "Other," please enter here</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Department/Academic Major(s)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>Applicant Profile</strong></span></h3>
</div>
        </div><div id="exist-sort-20" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Select your housing status for the next academic year (not current year)?</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-21" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="select" rq="no">Number of years you have attended Stanford, including the current academic year:</label>
          <select><option value="option1">Select 1</option><option value="option2">Select 2</option><option value="option3">Select 3</option></select>
        </div><div id="exist-sort-22" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-23" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If no, please explain why:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-24" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3 style="text-align: center;"><span style="font-size: 14pt;"><strong>General Terms and Conditions</strong></span></h3>
</div>
        </div><div id="exist-sort-25" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that if pre-assigned to a house, I relinquish the right to enter the 2014-2015 Undergraduate Housing Draw. I certify that I have at least one year of guaranteed undergraduate housing remaining to take advantage of this opportunity. I certify that I have read, understand and meet the stipulations stated as part of the Policies &amp; Eligibility for Pre-Assignment.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-26" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that once pre-assigned I must complete all of the requirements for the specific house as indicated below &amp; on each house's profile page on the Themed WebSite. I also understand that failure to fulfill these requirements once pre-assigned may result in disciplinary action up to and including loss of on-campus housing.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div><div id="exist-sort-27" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I also understand that students who pre-assign to a house are not guaranteed any particular room type (single, one room double, two room double).</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>No</span></label></div></div></div></div>
EOF

pa_system_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003e\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/index.jsp\\\"\\u003ePre-Assignment\\u003c/a\\u003e:\\u0026nbsp;\\u003ca href=\\\"https://saisappdev96.stanfordtest.edu/resjobs/applicant/preassign/application.jsp?partid=1476\\\"\\u003eApplication Material\\u003c/a\\u003e: Pre-Assignment Application Form\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePersonal Information\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"First Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":1,\"description\":\"Middle Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":2,\"description\":\"Last Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"SUNetID\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":2,\"column\":1,\"description\":\"Preferred Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":1,\"description\":\"Cell Phone (if any)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Current campus residence\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Campus Phone\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Current Mailing Address\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Please list any other house(s) you may have lived in\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":3,\"column\":1,\"description\":\"Room\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Year in school\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"If you selected \\\"Other,\\\" please enter here\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":1,\"description\":\"Department/Academic Major(s)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eApplicant Profile\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":5,\"column\":0,\"description\":\"Select your housing status for the next academic year (not current year)?\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Number of years you have attended Stanford, including the current academic year:\",\"type\":\"select\",\"options\":[\"Select 1\",\"Select 2\",\"Select 3\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"If no, please explain why:\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"\\n\\u003ch3 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eGeneral Terms and Conditions\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h3\\u003e\\n\",\"type\":\"description\"},{\"row\":5,\"column\":0,\"description\":\"I understand that if pre-assigned to a house, I relinquish the right to enter the 2014-2015 Undergraduate Housing Draw. I certify that I have at least one year of guaranteed undergraduate housing remaining to take advantage of this opportunity. I certify that I have read, understand and meet the stipulations stated as part of the Policies \\u0026amp; Eligibility for Pre-Assignment.\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"I understand that once pre-assigned I must complete all of the requirements for the specific house as indicated below \\u0026amp; on each house's profile page on the Themed WebSite. I also understand that failure to fulfill these requirements once pre-assigned may result in disciplinary action up to and including loss of on-campus housing.\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"I also understand that students who pre-assign to a house are not guaranteed any particular room type (single, one room double, two room double).\",\"type\":\"radio\",\"options\":[\"Yes\",\"\\u003cbr /\\u003e\",\"No\"],\"rq\":false}]"

pa_interview_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><strong>Interview Review Form for&nbsp;Pre-Assignment</strong></h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2>
<p><span style="color: #000000;"><strong>RECOMMENDATION:</strong></span></p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Row:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Upperclass:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Four Class:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Freshmen:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Describe the applicant's understanding of the PA's role and responsibilities.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Assess the applicant's ability as an PA, including technical knowledge, teaching and resident interactions.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Additional comments, including any potential conflicts with the position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2></div>
        </div></div></div>
EOF

pa_interview_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eInterview Review Form for\\u0026nbsp;Pre-Assignment\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cspan style=\\\"color: #000000;\\\"\\u003e\\u003cstrong\\u003eRECOMMENDATION:\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Row:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Upperclass:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Four Class:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Freshmen:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Describe the applicant's understanding of the PA's role and responsibilities.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Assess the applicant's ability as an PA, including technical knowledge, teaching and resident interactions.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Additional comments, including any potential conflicts with the position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\",\"type\":\"description\"}]"

# Branner House Supplemental Questions
pa_form_1 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><span style="font-size: 14pt;"><strong>House Supplemental Questions</strong></span></h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<h2><span style="font-size: 14pt;"><strong>Tier Requirement</strong></span></h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Branner will REQUIRE the use of a TIER TWO Housing choice. If you do not have TIER TWO available, TIER ONE will be used. If you do not have TIER ONE or TIER TWO available, TIER THREE will be used.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2><strong>Branner Requirements</strong></h2>
<h3><strong>Requirements to Qualify for Pre-Assignment</strong></h3>
<p>Pre-assignment to Branner will be considered for students who fulfill the following conditions:</p>
<ol>
<li>A history of participation in public service.</li>
<li>Demonstrate a basic understanding of the principles of ethical and effective service. (see&nbsp;<a href="http://studentaffairs.stanfordtest.edu/haas/about/mission/principles" target="_info">Haas Website</a>)</li>
<li>An interest in reflecting and focusing more deeply on the issues and challenges of living a life of public service.</li>
</ol>
<h3><strong>Requirements If Assigned</strong></h3>
<ol>
<li>Active and ongoing participation in, and a sustained commitment to at least one year long public service project during 2014-2015.</li>
<li>Active involvement and participation in Branner based public service activities (speakers, trainings and other special events) throughout 2014-2015. This will include regular community dinner meetings and at least four special public service events each quarter.</li>
<li>Participation in a one and a half day retreat at the start of Fall Quarter.</li>
<li>Participation in a one-day off campus service field trip at the start of Winter Quarter.</li>
<li>A commitment to ethical and effective service (see the Haas Center for Public Service Principles of Ethical and Effective Service).</li>
<li>A commitment to creating a reflective and supportive public service community in Branner Hall.</li>
</ol>
<h2><strong>Branner Essays</strong></h2>
<p><strong>We encourage individuals with similar service interests to pre-assign as a group (in essence a draw group) no larger than four members, thereby enabling them to develop more fully their shared public service interest. Each member of the group must complete their own application.</strong></p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If you are applying as part of a group, please list the names of the group members here:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">List any significant past public service interests and activities. Be sure to include your role. (How long you were involved and the level of time commitment for each activity.)(&lt;=200 words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Describe an ethical consideration or complexity that you encountered in past public service work and how you responded to it. (&lt;=200words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Describe how public service is (or could be) integrated with your academic experience at Stanford University. (&lt;=200words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">If you are applying for pre-assignment as part of a group please describe what you hope to accomplish in your public service interest area living and working together in Branner. (&lt;=200words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_1 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch2\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eTier Requirement\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Branner will REQUIRE the use of a TIER TWO Housing choice. If you do not have TIER TWO available, TIER ONE will be used. If you do not have TIER ONE or TIER TWO available, TIER THREE will be used.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003e\\u003cstrong\\u003eBranner Requirements\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003ch3\\u003e\\u003cstrong\\u003eRequirements to Qualify for Pre-Assignment\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Branner will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eA history of participation in public service.\\u003c/li\\u003e\\n\\u003cli\\u003eDemonstrate a basic understanding of the principles of ethical and effective service. (see\\u0026nbsp;\\u003ca href=\\\"http://studentaffairs.stanfordtest.edu/haas/about/mission/principles\\\" target=\\\"_info\\\"\\u003eHaas Website\\u003c/a\\u003e)\\u003c/li\\u003e\\n\\u003cli\\u003eAn interest in reflecting and focusing more deeply on the issues and challenges of living a life of public service.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003e\\u003cstrong\\u003eRequirements If Assigned\\u003c/strong\\u003e\\u003c/h3\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eActive and ongoing participation in, and a sustained commitment to at least one year long public service project during 2014-2015.\\u003c/li\\u003e\\n\\u003cli\\u003eActive involvement and participation in Branner based public service activities (speakers, trainings and other special events) throughout 2014-2015. This will include regular community dinner meetings and at least four special public service events each quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eParticipation in a one and a half day retreat at the start of Fall Quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eParticipation in a one-day off campus service field trip at the start of Winter Quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eA commitment to ethical and effective service (see the Haas Center for Public Service Principles of Ethical and Effective Service).\\u003c/li\\u003e\\n\\u003cli\\u003eA commitment to creating a reflective and supportive public service community in Branner Hall.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003e\\u003cstrong\\u003eBranner Essays\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003eWe encourage individuals with similar service interests to pre-assign as a group (in essence a draw group) no larger than four members, thereby enabling them to develop more fully their shared public service interest. Each member of the group must complete their own application.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"If you are applying as part of a group, please list the names of the group members here:\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"List any significant past public service interests and activities. Be sure to include your role. (How long you were involved and the level of time commitment for each activity.)(\\u0026lt;=200 words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Describe an ethical consideration or complexity that you encountered in past public service work and how you responded to it. (\\u0026lt;=200words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Describe how public service is (or could be) integrated with your academic experience at Stanford University. (\\u0026lt;=200words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"If you are applying for pre-assignment as part of a group please describe what you hope to accomplish in your public service interest area living and working together in Branner. (\\u0026lt;=200words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Casa Italiana House Supplemental Questions
pa_form_2 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Casa Italiana will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>Casa Italiana Requirements</h2>
<p>Preference is given to students who have already taken the initiative to learn Italian (completion of Italian 3 or equivalent) or is adequately fluent. However, Italian fluency does not guarantee pre-assignment to the house. We will also consider students (regardless of language ability) who show a&nbsp;<strong>strong</strong>&nbsp;interest in becoming involved in the house and furthering their knowledge of Italian culture and language.</p>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<ol>
<li><strong>Pre-assignment Requirements</strong>: enrollment and completion of house seminar (Fall plus one other quarter -- see below) and attendance at more than half of the quarterly-scheduled theme.</li>
<li><strong>House Seminar</strong>: Each resident is required to participate in two quarters of house seminar per year of residence. The house seminar, ItalLang 126, is a two-unit CR/NC course that<strong>must be included in the Axess study list</strong>. Residents living in the house for one-two quarters only must participate in one quarter of house seminar.</li>
<li><strong>Language and Culture</strong>: As a Language and Culture Residence, La Casa Italiana is dedicated to providing opportunities for residents to improve and share their cultural knowledge and language skills. Each resident is expected to contribute to the community. Beyond the house seminar requirement, students are encouraged to attend the weekly Tavola Italiana (Italian language dinners) and to participate in cultural and academic events planned by the Academic Theme Associate and the Graduate Theme Affiliate. Tavola is held every week on Wednesdays or Thursdays and invites guests and students interested in practicing their Italian. Residents are expected to speak Italian to the best of their ability throughout the meal. Quarterly, residents will assess what they have learned from Language and Culture activities in order to assess the contributions of La Casa Italiana to the intellectual life of its residents.</li>
</ol>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>Casa Italiana Essays</h2>
<p><strong>Please respond to the following questions in no more than 100 words.</strong></p>
</div>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1A. [Italian-speaking applicants only]: IN ITALIAN describe a memorable Italian/Italy-related experience. This experience does not need to have taken place in Italy. How does this experience relate to your interest in Italian culture today?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1B. [Non-Italian speakers only]: Describe your interest in Italy and why do you want to live in Casa. How would you contribute to or support the theme and community?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. [All applicants] Describe a seminar that you would like to attend as a Casa resident. Explain the subject, goals, and overall purpose of the seminar and why you think it would be beneficial for Casa residents to take this class. The class must have something to do with Italy.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. [All applicants] What do you feel your role in the house is being a pre-assigner who is connected to Italian culture and/or the language, Italian, in some way ?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_2 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Casa Italiana will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eCasa Italiana Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003ePreference is given to students who have already taken the initiative to learn Italian (completion of Italian 3 or equivalent) or is adequately fluent. However, Italian fluency does not guarantee pre-assignment to the house. We will also consider students (regardless of language ability) who show a\\u0026nbsp;\\u003cstrong\\u003estrong\\u003c/strong\\u003e\\u0026nbsp;interest in becoming involved in the house and furthering their knowledge of Italian culture and language.\\u003c/p\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003e\\u003cstrong\\u003ePre-assignment Requirements\\u003c/strong\\u003e: enrollment and completion of house seminar (Fall plus one other quarter -- see below) and attendance at more than half of the quarterly-scheduled theme.\\u003c/li\\u003e\\n\\u003cli\\u003e\\u003cstrong\\u003eHouse Seminar\\u003c/strong\\u003e: Each resident is required to participate in two quarters of house seminar per year of residence. The house seminar, ItalLang 126, is a two-unit CR/NC course that\\u003cstrong\\u003emust be included in the Axess study list\\u003c/strong\\u003e. Residents living in the house for one-two quarters only must participate in one quarter of house seminar.\\u003c/li\\u003e\\n\\u003cli\\u003e\\u003cstrong\\u003eLanguage and Culture\\u003c/strong\\u003e: As a Language and Culture Residence, La Casa Italiana is dedicated to providing opportunities for residents to improve and share their cultural knowledge and language skills. Each resident is expected to contribute to the community. Beyond the house seminar requirement, students are encouraged to attend the weekly Tavola Italiana (Italian language dinners) and to participate in cultural and academic events planned by the Academic Theme Associate and the Graduate Theme Affiliate. Tavola is held every week on Wednesdays or Thursdays and invites guests and students interested in practicing their Italian. Residents are expected to speak Italian to the best of their ability throughout the meal. Quarterly, residents will assess what they have learned from Language and Culture activities in order to assess the contributions of La Casa Italiana to the intellectual life of its residents.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eCasa Italiana Essays\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease respond to the following questions in no more than 100 words.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1A. [Italian-speaking applicants only]: IN ITALIAN describe a memorable Italian/Italy-related experience. This experience does not need to have taken place in Italy. How does this experience relate to your interest in Italian culture today?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"1B. [Non-Italian speakers only]: Describe your interest in Italy and why do you want to live in Casa. How would you contribute to or support the theme and community?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. [All applicants] Describe a seminar that you would like to attend as a Casa resident. Explain the subject, goals, and overall purpose of the seminar and why you think it would be beneficial for Casa residents to take this class. The class must have something to do with Italy.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. [All applicants] What do you feel your role in the house is being a pre-assigner who is connected to Italian culture and/or the language, Italian, in some way ?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# 576 Alvarado House Supplemental Questions
pa_form_3 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>&nbsp;House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to 576 Alvarado will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>576 Alvarado Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<ol>
<li>Every pre-assignment applicant must attend the five-hour work day (date TBA) or make other arrangements with house managers.</li>
<li>Complete a house tour of 576 Alvarado with a current 576 Alvarado manager.</li>
<li>Attend a dinner at 576 Alvarado. (Not required, but strongly recommended)</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>576 Alvarado is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.</p>
<h2>576 Alvarado Essay</h2>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please write a brief essay describing why you wish to live in 576 Alvarado, and how you plan to contribute to the community. You are encouraged to express yourself however you wish.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_3 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003e\\u0026nbsp;House Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to 576 Alvarado will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003e576 Alvarado Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery pre-assignment applicant must attend the five-hour work day (date TBA) or make other arrangements with house managers.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of 576 Alvarado with a current 576 Alvarado manager.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at 576 Alvarado. (Not required, but strongly recommended)\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003e576 Alvarado is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.\\u003c/p\\u003e\\n\\u003ch2\\u003e576 Alvarado Essay\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Please write a brief essay describing why you wish to live in 576 Alvarado, and how you plan to contribute to the community. You are encouraged to express yourself however you wish.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Columbae House Supplemental Questions
pa_form_4 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Columbae will REQUIRE the use of a TIER TWO housing choice or better.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>Columbae Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Columbae will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Every pre-assignment applicant must complete a house job (this could be a dinner clean or a dinner cook job on a Sunday - Thursday evening) at Columbae.</li>
<li>Complete a house tour of Columbae.</li>
<li>Attend a dinner at Columbae.</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>Columbae is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.</p>
<h2>Columbae Essay</h2>
</div>
        </div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please write a brief essay describing why you wish to live in Columbae, and how you plan to contribute to the community. For standard prose, writing about (up to) 200 words is a fine guideline, but don't let this stifle your creative desires --- you are encouraged to express yourself however you wish.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_4 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Columbae will REQUIRE the use of a TIER TWO housing choice or better.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eColumbae Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Columbae will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery pre-assignment applicant must complete a house job (this could be a dinner clean or a dinner cook job on a Sunday - Thursday evening) at Columbae.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of Columbae.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at Columbae.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eColumbae is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.\\u003c/p\\u003e\\n\\u003ch2\\u003eColumbae Essay\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Please write a brief essay describing why you wish to live in Columbae, and how you plan to contribute to the community. For standard prose, writing about (up to) 200 words is a fine guideline, but don't let this stifle your creative desires --- you are encouraged to express yourself however you wish.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Crothers House Supplemental Questions
pa_form_5 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p>&nbsp;<em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Room Assignments</h2>
<ol>
<li>Students going abroad winter and spring quarters are encouraged to apply!</li>
<li>Students going abroad fall quarter cannot apply, but they are encouraged to list Crothers "high" on their Housing preference for their return to Stanford.</li>
<li>Roommate pairs can be considered together if both applications note roommate name on pre-assignment application.</li>
<li>Pre-assigned theme students are clustered together in Crothers Memorial.</li>
<li>There will be a theme in-house draw (separate from the in-house draw for the rest of Crothers) with designated rooms to choose from in Crothers Memorial.</li>
<li>Preference for singles is given but NOT guaranteed to seniors writing an honors thesis.</li>
<li>One room doubles and a few singles available to pre-assigned students.</li>
</ol>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Crothers will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>Theme Requirements</h2>
<ol>
<li>Active leadership in at least one Global Citizenship theme program during the 2014-2015 academic year.</li>
<li>Seniors writing honors theses must present their work to the dorm.</li>
<li>Active participation in at least 5 dorm-based theme activities (speakers, workshops, dinners, field trips and other special events) per quarter during 2014-2015.</li>
</ol>
<h2>Crothers Additional Information</h2>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">1. To assist with rooming configurations please list your gender here:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">2. Are you planning, or will you be applying, to go to an overseas campus during winter or spring quarter(s)?: </label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>3. Please submit an unofficial transcript and a resume to&nbsp;<a href="mailto:acnapier@stanfordtest.edu">Arabella Napier</a>&nbsp;(acnapier@stanfordtest.edu) , Program Associate for Crothers.</strong></p>
<p>&nbsp;</p>
<h2>Crothers Essays</h2>
<p>&nbsp;</p>
<p><strong>Please write ONE essay of no more than 350 words that answers the following questions:</strong></p>
</div>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<ol>
<li>Describe what has attracted you to the theme of global citizenship. What global issues seem important to you and why?</li>
<li>How might the programming and opportunities in Crothers relate to your plans for the future?</li>
<li>Describe a program you would like to organize in Crothers during the year.</li>
</ol>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no"></label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<p>Questions about this application or the pre-assignment process for Crothers should be directed to Arabella Napier, Program Associate for Crothers, at&nbsp;<a href="mailto:acnapier@stanfordtest.edu">acnapier@stanfordtest.edu</a></p>
<p>&nbsp;</p>
</div>
        </div></div></div>
EOF
pa_form_schema_5 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eRoom Assignments\\u003c/h2\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eStudents going abroad winter and spring quarters are encouraged to apply!\\u003c/li\\u003e\\n\\u003cli\\u003eStudents going abroad fall quarter cannot apply, but they are encouraged to list Crothers \\\"high\\\" on their Housing preference for their return to Stanford.\\u003c/li\\u003e\\n\\u003cli\\u003eRoommate pairs can be considered together if both applications note roommate name on pre-assignment application.\\u003c/li\\u003e\\n\\u003cli\\u003ePre-assigned theme students are clustered together in Crothers Memorial.\\u003c/li\\u003e\\n\\u003cli\\u003eThere will be a theme in-house draw (separate from the in-house draw for the rest of Crothers) with designated rooms to choose from in Crothers Memorial.\\u003c/li\\u003e\\n\\u003cli\\u003ePreference for singles is given but NOT guaranteed to seniors writing an honors thesis.\\u003c/li\\u003e\\n\\u003cli\\u003eOne room doubles and a few singles available to pre-assigned students.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Crothers will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eTheme Requirements\\u003c/h2\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eActive leadership in at least one Global Citizenship theme program during the 2014-2015 academic year.\\u003c/li\\u003e\\n\\u003cli\\u003eSeniors writing honors theses must present their work to the dorm.\\u003c/li\\u003e\\n\\u003cli\\u003eActive participation in at least 5 dorm-based theme activities (speakers, workshops, dinners, field trips and other special events) per quarter during 2014-2015.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eCrothers Additional Information\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. To assist with rooming configurations please list your gender here:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Are you planning, or will you be applying, to go to an overseas campus during winter or spring quarter(s)?: \",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003e3. Please submit an unofficial transcript and a resume to\\u0026nbsp;\\u003ca href=\\\"mailto:acnapier@stanfordtest.edu\\\"\\u003eArabella Napier\\u003c/a\\u003e\\u0026nbsp;(acnapier@stanfordtest.edu) , Program Associate for Crothers.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch2\\u003eCrothers Essays\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease write ONE essay of no more than 350 words that answers the following questions:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003col\\u003e\\n\\u003cli\\u003eDescribe what has attracted you to the theme of global citizenship. What global issues seem important to you and why?\\u003c/li\\u003e\\n\\u003cli\\u003eHow might the programming and opportunities in Crothers relate to your plans for the future?\\u003c/li\\u003e\\n\\u003cli\\u003eDescribe a program you would like to organize in Crothers during the year.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003eQuestions about this application or the pre-assignment process for Crothers should be directed to Arabella Napier, Program Associate for Crothers, at\\u0026nbsp;\\u003ca href=\\\"mailto:acnapier@stanfordtest.edu\\\"\\u003eacnapier@stanfordtest.edu\\u003c/a\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"}]"

# East House Supplemental Questions
pa_form_6 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>ouse Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="East">
<p>As you complete your application, bear in mind the three requirements for Pre-Assigned Residents in EAST:</p>
<ol>
<li>Enroll in two out of three 1-unit, quarter-long seminars(EDUC100ABC).</li>
<li>Assist actively the EAST Academic Theme Associates in developing and executing at least two theme events per quarter.</li>
<li>Participate actively in other theme-related events throughout the year by attending at least half of the theme events per quarter.</li>
</ol>
<p>Please complete all questions in the application form below.</p>
<h2>Tier Requirement</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to EAST will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="East">
<h2>EAST Requirements</h2>
<p>To be considered for Pre-assignment, students must meet ONE of the following requirements:</p>
<ol>
<li>20 units of Education courses or courses cross-listed in Education (email transcript)</li>
<li>Have declared a minor in Education (email transcript)</li>
<li>Be an honors student in Education (email transcript)</li>
<li>Have extensive education-related experience (e.g., active participation in an education-related student or community organization) and a commitment to share this with the House. To fulfill this requirement, please describe in detail how you intend to share this experience with the residents of EAST House during the academic year. Your essay should be 300-500 words in length.</li>
</ol></div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="East">
<h2>EAST Essays</h2>
<p><strong>Please answer each of the following questions in three total pages.</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Explain what interests you about the field of Education and how you would inspire others to be passionate about the field.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. Describe a large event that you would like to help organize at EAST House. Describe the topic and goals. Address what you would do specifically to attract interest in the event among House residents and the wider Stanford community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. What is one word that describes why people appreciate or enjoy working with you?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_6 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"East\\\"\\u003e\\n\\u003cp\\u003eAs you complete your application, bear in mind the three requirements for Pre-Assigned Residents in EAST:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEnroll in two out of three 1-unit, quarter-long seminars(EDUC100ABC).\\u003c/li\\u003e\\n\\u003cli\\u003eAssist actively the EAST Academic Theme Associates in developing and executing at least two theme events per quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eParticipate actively in other theme-related events throughout the year by attending at least half of the theme events per quarter.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below.\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to EAST will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"East\\\"\\u003e\\n\\u003ch2\\u003eEAST Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003eTo be considered for Pre-assignment, students must meet ONE of the following requirements:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003e20 units of Education courses or courses cross-listed in Education (email transcript)\\u003c/li\\u003e\\n\\u003cli\\u003eHave declared a minor in Education (email transcript)\\u003c/li\\u003e\\n\\u003cli\\u003eBe an honors student in Education (email transcript)\\u003c/li\\u003e\\n\\u003cli\\u003eHave extensive education-related experience (e.g., active participation in an education-related student or community organization) and a commitment to share this with the House. To fulfill this requirement, please describe in detail how you intend to share this experience with the residents of EAST House during the academic year. Your essay should be 300-500 words in length.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"East\\\"\\u003e\\n\\u003ch2\\u003eEAST Essays\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease answer each of the following questions in three total pages.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Explain what interests you about the field of Education and how you would inspire others to be passionate about the field.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Describe a large event that you would like to help organize at EAST House. Describe the topic and goals. Address what you would do specifically to attract interest in the event among House residents and the wider Stanford community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. What is one word that describes why people appreciate or enjoy working with you?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# EBF House Supplemental Questions
pa_form_7 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="EBF">
<h2>Tier Requirement</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to EBF will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="EBF">
<ul>
<li>EBF now houses 54 residents.</li>
<li>Pre-assignees should contact&nbsp;<a href="mailto:ihoward@stanfordtest.edu">Imani Howard</a>&nbsp;regarding pre-assignment questions and scheduling of the house job.</li>
<li>EBF no longer has a theme manager. We have 2 Kitchen managers and 1 Jobs Manager.</li>
</ul>
<h2>EBF Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<ol>
<li>Every pre-assignment applicant must attend a work day at EBF during Spring Quarter (on a Sunday TBD). This is designed to give applicants a sense of the responsibilities involved in maintaining our own house.</li>
<li>Attend the subsequent dinner with the house after completing your work day tasks. Unwind with us!</li>
<li>Attend at least one Happy Hour during Spring Quarter (and sign your name on the board taped to the R.A..s door, off the lounge).</li>
<li>Pre-assignees MUST come complete a job at EBF (not just at any co-op). The other two conditions still hold.</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>EBF is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.</p>
<h2>EBF Essay</h2>
<p><strong>Please answer 2 of the following questions</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Describe your ideal week in EBF.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. What would be your dream job in EBF? It does not have to be realistic. Get creative! You should address how your job would contribute to the community as a whole.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Suggest a house bonding activity. Past events have included olympics style competitions, Iron Chef cook-off etc.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_7 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"EBF\\\"\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to EBF will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"EBF\\\"\\u003e\\n\\u003cul\\u003e\\n\\u003cli\\u003eEBF now houses 54 residents.\\u003c/li\\u003e\\n\\u003cli\\u003ePre-assignees should contact\\u0026nbsp;\\u003ca href=\\\"mailto:ihoward@stanfordtest.edu\\\"\\u003eImani Howard\\u003c/a\\u003e\\u0026nbsp;regarding pre-assignment questions and scheduling of the house job.\\u003c/li\\u003e\\n\\u003cli\\u003eEBF no longer has a theme manager. We have 2 Kitchen managers and 1 Jobs Manager.\\u003c/li\\u003e\\n\\u003c/ul\\u003e\\n\\u003ch2\\u003eEBF Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery pre-assignment applicant must attend a work day at EBF during Spring Quarter (on a Sunday TBD). This is designed to give applicants a sense of the responsibilities involved in maintaining our own house.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend the subsequent dinner with the house after completing your work day tasks. Unwind with us!\\u003c/li\\u003e\\n\\u003cli\\u003eAttend at least one Happy Hour during Spring Quarter (and sign your name on the board taped to the R.A..s door, off the lounge).\\u003c/li\\u003e\\n\\u003cli\\u003ePre-assignees MUST come complete a job at EBF (not just at any co-op). The other two conditions still hold.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eEBF is a co-op, a wonderful place. We run the house: cooking, cleaning, general housekeeping, event organization. We have a jobs system in place to organize and divide the work. House chores make for a great community-building experience. It requires that students do their part and take responsibility for the house as a whole.\\u003c/p\\u003e\\n\\u003ch2\\u003eEBF Essay\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease answer 2 of the following questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Describe your ideal week in EBF.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. What would be your dream job in EBF? It does not have to be realistic. Get creative! You should address how your job would contribute to the community as a whole.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. Suggest a house bonding activity. Past events have included olympics style competitions, Iron Chef cook-off etc.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# FroSoCo House Supplemental Questions
pa_form_8 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="FroSoCo">
<h2>Tier Requirement</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to FroSoCo will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="FroSoCo">
<h2>FroSoCo Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to FroSoCo will be considered for students who fulfill any of the following conditions:</p>
<ol>
<li>Returning to FroSoCo for your Sophomore Year.</li>
<li>Being Sponsored by a current FroSoCo Resident. (Please complete Essay 1)</li>
<li>Have a special interest in being a part of the FroSoCo community. (Please complete Essays 1 &amp; 2).</li>
</ol></div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you are being Sponsored by someone please enter your sponsor's name here:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">If you are Sponsoring someone please enter their name(s) here:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="FroSoCo">
<h2><strong>FroSoCo Essays</strong></h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Essay 1 (for all in-coming students): In 500 words or less, please discuss why you would like to be a part of the FroSoCo community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Essay 2 (for students WITHOUT sponsors): In 500 words or less, please discuss what you think you would contribute to the FroSoCo community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_8 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"FroSoCo\\\"\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to FroSoCo will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"FroSoCo\\\"\\u003e\\n\\u003ch2\\u003eFroSoCo Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to FroSoCo will be considered for students who fulfill any of the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eReturning to FroSoCo for your Sophomore Year.\\u003c/li\\u003e\\n\\u003cli\\u003eBeing Sponsored by a current FroSoCo Resident. (Please complete Essay 1)\\u003c/li\\u003e\\n\\u003cli\\u003eHave a special interest in being a part of the FroSoCo community. (Please complete Essays 1 \\u0026amp; 2).\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"If you are being Sponsored by someone please enter your sponsor's name here:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"If you are Sponsoring someone please enter their name(s) here:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"FroSoCo\\\"\\u003e\\n\\u003ch2\\u003e\\u003cstrong\\u003eFroSoCo Essays\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Essay 1 (for all in-coming students): In 500 words or less, please discuss why you would like to be a part of the FroSoCo community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Essay 2 (for students WITHOUT sponsors): In 500 words or less, please discuss what you think you would contribute to the FroSoCo community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Hammarskjold House Supplemental Questions
pa_form_9 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>House Supplemental Questions</h2>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="FroSoCo">
<h2>Tier Requirement</h2>
</div>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Hammarskjold will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Hammarskjold">
<h2>Hammarskjold Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Hammarskjold will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Every preassignment applicant must complete a house job (usually a Sunday Hash) at any Co-Op.</li>
<li>Complete a house tour of Hammarskjold.</li>
<li>Attend a dinner at Hammarskjold. (Not required, but strongly recommended)</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>If assigned to Hammarskjold you must:</p>
<ol>
<li>Present one theme project to house residents</li>
<li>Do a biweekly clean.</li>
<li>Do a house job once a week.</li>
<li>Do an end-of-the-quarter clean.</li>
</ol>
<h2>Hammarskjold Essay</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Please write a brief essay of no more than 200 words describing why you wish to live in Hammarskjold, and how you plan to contribute to the community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. The Hammarskjold theme is the International House. Every Hammarskjold resident is required (and given a budget) to present a theme project to the rest of the house regarding their international heritage, experience, or interests. Theme projects in the past have included culture-specific food, a visual display, a movie, and interactive crafts, among other activities. Each project must include an educational element. In less than 100 words, describe one idea for a theme project: a creative way in which you could educate the house about a culture or nationality.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_9 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eHouse Supplemental Questions\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"FroSoCo\\\"\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Hammarskjold will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Hammarskjold\\\"\\u003e\\n\\u003ch2\\u003eHammarskjold Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Hammarskjold will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery preassignment applicant must complete a house job (usually a Sunday Hash) at any Co-Op.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of Hammarskjold.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at Hammarskjold. (Not required, but strongly recommended)\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eIf assigned to Hammarskjold you must:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003ePresent one theme project to house residents\\u003c/li\\u003e\\n\\u003cli\\u003eDo a biweekly clean.\\u003c/li\\u003e\\n\\u003cli\\u003eDo a house job once a week.\\u003c/li\\u003e\\n\\u003cli\\u003eDo an end-of-the-quarter clean.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eHammarskjold Essay\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Please write a brief essay of no more than 200 words describing why you wish to live in Hammarskjold, and how you plan to contribute to the community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. The Hammarskjold theme is the International House. Every Hammarskjold resident is required (and given a budget) to present a theme project to the rest of the house regarding their international heritage, experience, or interests. Theme projects in the past have included culture-specific food, a visual display, a movie, and interactive crafts, among other activities. Each project must include an educational element. In less than 100 words, describe one idea for a theme project: a creative way in which you could educate the house about a culture or nationality.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Haus Mitterleuropa House Supplemental Questions
pa_form_10 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Haus Mitt will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Haus Mitterleuropa">
<h2>Haus Mitt Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Haus Mitteleuropa will be considered for students who fulfill at least one of the following conditions. Priority will be given to students with the most German background and experience.</p>
<ul>
<li>Successful completion of at least 1 Quarter of GERLANG, GERGEN, or GERLIT classes (please highlight relevant portions of unofficial transcript).</li>
<li>At least one quarter of study at Stanford-in-Berlin or another study abroad program in Germany, Austria, or German-speaking Switzerland (please highlight relevant portions of unofficial transcript).</li>
<li>Prior or native knowledge of German language (please arrange to meet by April 22nd with current theme staff to display this:&nbsp;<a href="mailto:beatrix@stanfordtest.edu">Bee Lockwood</a>&nbsp;or&nbsp;<a href="mailto:agathab@stanfordtest.edu">Agatha Bacelar</a></li>
.
<li>Strong interest in Haus Mitt's theme, demonstrated by your essays (below) or previous attendance to Haus Mitt theme classes.</li>
<li>Attend 8 Haus Mitt classes or other theme activities each quarter of residence in Haus Mitt (signing up for official credit on Axess is optional; attendance is not).</li>
<li>Complete a theme project if living in Haus Mitt for more than 1 quarter (A theme project is an individual or group project on some topic relating to German culture, language, history, etc. Students often choose to do a brief presentation for fellow housemates.)</li>
</ul>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Haus Mitterleuropa">
<h3>Requirements if Assigned</h3>
<p>If assigned to Haus Mitt you must:</p>
<ol>
<li>Purchase the Haus Mitt meal plan and perform weekly hashing duties, as well as a quarterly Sunday clean</li>
<li>Receive 8 Haus Mitt theme points by attending classes or other theme activities each quarter of residence in Haus Mitt (signing up for official credit on Axess is optional; attendance is not)</li>
<li>Complete a theme project if living in Haus Mitt for more than 1 quarter (A theme project is an individual or group project on some topic relating to German culture, language, history, etc. Students often choose to do a brief presentation for fellow housemates.)</li>
<li><strong>**It is strongly recommended that all applicants attend at least one Stammtisch (Tuesdays at 6pm) before April 22nd to become familiar with the theme programming and to demonstrate interest and enthusiasm.</strong></li>
</ol>
<h2>Haus Mitt Essays</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Please detail why you would like to live in the German/Central European theme house.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. Explain how you would contribute to the Haus Mitt as a resident.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Describe a potential theme project to be presented to Haus Mitt (prior theme projects have included holiday celebrations, musical or theatrical performances, cooking demonstrations, cultural presentations, etc.)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_10 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Haus Mitt will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Haus Mitterleuropa\\\"\\u003e\\n\\u003ch2\\u003eHaus Mitt Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Haus Mitteleuropa will be considered for students who fulfill at least one of the following conditions. Priority will be given to students with the most German background and experience.\\u003c/p\\u003e\\n\\u003cul\\u003e\\n\\u003cli\\u003eSuccessful completion of at least 1 Quarter of GERLANG, GERGEN, or GERLIT classes (please highlight relevant portions of unofficial transcript).\\u003c/li\\u003e\\n\\u003cli\\u003eAt least one quarter of study at Stanford-in-Berlin or another study abroad program in Germany, Austria, or German-speaking Switzerland (please highlight relevant portions of unofficial transcript).\\u003c/li\\u003e\\n\\u003cli\\u003ePrior or native knowledge of German language (please arrange to meet by April 22nd with current theme staff to display this:\\u0026nbsp;\\u003ca href=\\\"mailto:beatrix@stanfordtest.edu\\\"\\u003eBee Lockwood\\u003c/a\\u003e\\u0026nbsp;or\\u0026nbsp;\\u003ca href=\\\"mailto:agathab@stanfordtest.edu\\\"\\u003eAgatha Bacelar\\u003c/a\\u003e\\u003c/li\\u003e\\n.\\n\\u003cli\\u003eStrong interest in Haus Mitt's theme, demonstrated by your essays (below) or previous attendance to Haus Mitt theme classes.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend 8 Haus Mitt classes or other theme activities each quarter of residence in Haus Mitt (signing up for official credit on Axess is optional; attendance is not).\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a theme project if living in Haus Mitt for more than 1 quarter (A theme project is an individual or group project on some topic relating to German culture, language, history, etc. Students often choose to do a brief presentation for fellow housemates.)\\u003c/li\\u003e\\n\\u003c/ul\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Haus Mitterleuropa\\\"\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eIf assigned to Haus Mitt you must:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003ePurchase the Haus Mitt meal plan and perform weekly hashing duties, as well as a quarterly Sunday clean\\u003c/li\\u003e\\n\\u003cli\\u003eReceive 8 Haus Mitt theme points by attending classes or other theme activities each quarter of residence in Haus Mitt (signing up for official credit on Axess is optional; attendance is not)\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a theme project if living in Haus Mitt for more than 1 quarter (A theme project is an individual or group project on some topic relating to German culture, language, history, etc. Students often choose to do a brief presentation for fellow housemates.)\\u003c/li\\u003e\\n\\u003cli\\u003e\\u003cstrong\\u003e**It is strongly recommended that all applicants attend at least one Stammtisch (Tuesdays at 6pm) before April 22nd to become familiar with the theme programming and to demonstrate interest and enthusiasm.\\u003c/strong\\u003e\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eHaus Mitt Essays\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Please detail why you would like to live in the German/Central European theme house.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Explain how you would contribute to the Haus Mitt as a resident.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. Describe a potential theme project to be presented to Haus Mitt (prior theme projects have included holiday celebrations, musical or theatrical performances, cooking demonstrations, cultural presentations, etc.)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Kairos House Supplemental Questions
pa_form_11 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Kairos will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Kairos">
<h2>Kairos Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Every preassignment applicant must complete a house job.</li>
<li>Complete a house tour of Kairos while completing a supplemental questionnaire.</li>
<li>Attend a dinner at Kairos. (Not required, but strongly recommended)</li>
</ol>
<p>Information on completing these requirements can be found on&nbsp;<a href="http://coop.stanfordtest.edu/" target="info">coop.stanfordtest.edu.</a></p>
<h2>Kairos Essay</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Please write a brief essay of no more than 200 words describing why you wish to live in Kairos, and how you plan to contribute to the community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. Describe your perfect day.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Use this space to express yourself however you'd like.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_11 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Kairos will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Kairos\\\"\\u003e\\n\\u003ch2\\u003eKairos Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery preassignment applicant must complete a house job.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of Kairos while completing a supplemental questionnaire.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at Kairos. (Not required, but strongly recommended)\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003eInformation on completing these requirements can be found on\\u0026nbsp;\\u003ca href=\\\"http://coop.stanfordtest.edu/\\\" target=\\\"info\\\"\\u003ecoop.stanfordtest.edu.\\u003c/a\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eKairos Essay\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Please write a brief essay of no more than 200 words describing why you wish to live in Kairos, and how you plan to contribute to the community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Describe your perfect day.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. Use this space to express yourself however you'd like.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Kimball House Supplemental Questions
pa_form_12 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="Kimball">
<p>Thank you for your interest in pre-assigning to Kimball! Please complete all questions in the application form below.</p>
</div>
<p>&nbsp;</p>
<h2>Tier Requirement</h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Kimball will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Kimball">
<h2>Kimball Arts Theme Requirements</h2>
<p>To pre-assign to Kimball Hall, you must:</p>
<ol>
<li>Demonstrated interest and active engagement in the arts (visual, literary, performing or other).</li>
<li>Provide a faculty reference who can speak to your creativity and commitment to the arts. It is not necessary to get a recommendation; simply ask your recommender for permission for us to e-mail or call for a reference. Include your recommender'name, position, e-mail and campus phone.</li>
<li>Commit to attend and participate in participate in Kimball arts related activities sufficient to receive your required allotment of theme points (see attached point policy).</li>
</ol>
<h2>Kimball Essays:</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please write a brief statement (150-200 words) describing an arts event that you would like to organize or participate in.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Kimball">
<h2>Evidence of Creative Work:</h2>
<p><strong>Please submit a digital portfolio or other clear evidence of your creative work to&nbsp;<a href="mailto:wheelerl@stanfordtest.edu">Laura Wheeler</a>&nbsp;(wheelerl@stanfordtest.edu), Program Associate for the Arts in Manzanita office. Your submission of creative work should be no larger than an 8.5x11 sheet of paper and no thicker than a CD. It can be a copy or photograph of an original piece, a sample of creative writing, a recording or DVD.</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div></div></div>
EOF
pa_form_schema_12 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Kimball\\\"\\u003e\\n\\u003cp\\u003eThank you for your interest in pre-assigning to Kimball! Please complete all questions in the application form below.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Kimball will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Kimball\\\"\\u003e\\n\\u003ch2\\u003eKimball Arts Theme Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003eTo pre-assign to Kimball Hall, you must:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eDemonstrated interest and active engagement in the arts (visual, literary, performing or other).\\u003c/li\\u003e\\n\\u003cli\\u003eProvide a faculty reference who can speak to your creativity and commitment to the arts. It is not necessary to get a recommendation; simply ask your recommender for permission for us to e-mail or call for a reference. Include your recommender'name, position, e-mail and campus phone.\\u003c/li\\u003e\\n\\u003cli\\u003eCommit to attend and participate in participate in Kimball arts related activities sufficient to receive your required allotment of theme points (see attached point policy).\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eKimball Essays:\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Please write a brief statement (150-200 words) describing an arts event that you would like to organize or participate in.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Kimball\\\"\\u003e\\n\\u003ch2\\u003eEvidence of Creative Work:\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease submit a digital portfolio or other clear evidence of your creative work to\\u0026nbsp;\\u003ca href=\\\"mailto:wheelerl@stanfordtest.edu\\\"\\u003eLaura Wheeler\\u003c/a\\u003e\\u0026nbsp;(wheelerl@stanfordtest.edu), Program Associate for the Arts in Manzanita office. Your submission of creative work should be no larger than an 8.5x11 sheet of paper and no thicker than a CD. It can be a copy or photograph of an original piece, a sample of creative writing, a recording or DVD.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"}]"

# La Maison Francaise House Supplemental Questions
pa_form_13 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="La Maison Francaise">
<p>Please complete all questions in the application form below.</p>
</div>
<p>&nbsp;</p>
<h2>Tier Requirement</h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to La Maison will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="La Maison Francaise">
<h2>La Maison Fran��aise Requirements</h2>
<p>Pre-assignment to La Maison Fran��aise will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Successful completion of French 3 by the end of Spring Quarter 2013 OR&nbsp;<br>At least one quarter of participation in the Stanford in Paris program OR&nbsp;<br>Demonstration of adequate fluency in French, via interview administered by a representative of the Department of French and Italian. Contact&nbsp;<a href="mailto:patricia@stanfordtest.edu">Patricia de Castries</a>&nbsp;for details.</li>
<li>Inclusion of an unofficial transcript at the time of the pre-assignment application submission.</li>
<li>Completion of at least 8 "theme points" per quarter of residency. This requirement can be satisfied by taking classes offered by the Department of French and Italian listed as FRENLANG, FRENLIT, or FRENGEN. La Maison Fran��aise in-house seminars and cultural events also count towards the requirement.</li>
<li>Completion of one theme project to be presented to the house residents.</li>
<li>Attendance at more than half of the quarterly scheduled theme presentations.</li>
</ol>
<p>To verfiy eligibility, please include of an unofficial transcript at the time of the pre-assignment application submission.</p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="La Maison Francaise">
<h2>La Maison Fran��aise Essays</h2>
<p><strong><em>French speakers</em>: Please complete the following questions IN FRENCH in no more than 200 words.</strong></p>
<p><strong><em>Non-French speakers</em>: Please complete the following questions in English in no more than 200 words.</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Please describe a theme project to be presented at La Maison Francaise during the course of your year in residence. Prior theme projects have included holiday celebrations, theatrical performances, cooking demonstrations, and many, many more. Creativity and excitement are encouraged!</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. You have 24 hours in Paris. What do you do?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. You've just bumped into Carla Bruni and spilled a glass of warm red wine all over her brand new white blouse. Sarkozy saw it happen, and watches you menacingly. How do you get out of this fix?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. [Non-French speakers ONLY]: Please descript your interest in French culture and why you want to live in La Maison Francaise. How would you contribute to or support the theme and community?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_13 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"La Maison Francaise\\\"\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to La Maison will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"La Maison Francaise\\\"\\u003e\\n\\u003ch2\\u003eLa Maison Fran��aise Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003ePre-assignment to La Maison Fran��aise will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eSuccessful completion of French 3 by the end of Spring Quarter 2013 OR\\u0026nbsp;\\u003cbr\\u003eAt least one quarter of participation in the Stanford in Paris program OR\\u0026nbsp;\\u003cbr\\u003eDemonstration of adequate fluency in French, via interview administered by a representative of the Department of French and Italian. Contact\\u0026nbsp;\\u003ca href=\\\"mailto:patricia@stanfordtest.edu\\\"\\u003ePatricia de Castries\\u003c/a\\u003e\\u0026nbsp;for details.\\u003c/li\\u003e\\n\\u003cli\\u003eInclusion of an unofficial transcript at the time of the pre-assignment application submission.\\u003c/li\\u003e\\n\\u003cli\\u003eCompletion of at least 8 \\\"theme points\\\" per quarter of residency. This requirement can be satisfied by taking classes offered by the Department of French and Italian listed as FRENLANG, FRENLIT, or FRENGEN. La Maison Fran��aise in-house seminars and cultural events also count towards the requirement.\\u003c/li\\u003e\\n\\u003cli\\u003eCompletion of one theme project to be presented to the house residents.\\u003c/li\\u003e\\n\\u003cli\\u003eAttendance at more than half of the quarterly scheduled theme presentations.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003eTo verfiy eligibility, please include of an unofficial transcript at the time of the pre-assignment application submission.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"La Maison Francaise\\\"\\u003e\\n\\u003ch2\\u003eLa Maison Fran��aise Essays\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u003cem\\u003eFrench speakers\\u003c/em\\u003e: Please complete the following questions IN FRENCH in no more than 200 words.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u003cem\\u003eNon-French speakers\\u003c/em\\u003e: Please complete the following questions in English in no more than 200 words.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Please describe a theme project to be presented at La Maison Francaise during the course of your year in residence. Prior theme projects have included holiday celebrations, theatrical performances, cooking demonstrations, and many, many more. Creativity and excitement are encouraged!\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. You have 24 hours in Paris. What do you do?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. You've just bumped into Carla Bruni and spilled a glass of warm red wine all over her brand new white blouse. Sarkozy saw it happen, and watches you menacingly. How do you get out of this fix?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"4. [Non-French speakers ONLY]: Please descript your interest in French culture and why you want to live in La Maison Francaise. How would you contribute to or support the theme and community?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Muwekma House Supplemental Questions
pa_form_14 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="Muwekma">
<p>Please complete all questions in the application form below.</p>
<p>&nbsp;</p>
</div>
<p>&nbsp;</p>
<h2>Tier Requirement</h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Muwekma will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Muwekma">
<h2>Muwekma Requirements</h2>
<p>If assigned to Muwekma I must:</p>
<ol>
<li>Complete at least one quarter of house seminar, offered fall and winter quarters</li>
<li>Complete 4 volunteer hours for the Stanford Powwow or Stanford Luau during spring quarter</li>
</ol>
<p>Some applicants will be selected to come in for interviews with our preassignment staff. We really appreciate your time and interest in Muwekma-Tah-Ruk.</p>
<h2>Muwekma Essays</h2>
<p>Please answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.</p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Have you lived in Muwekma-Tah-Ruk before and if so, in what years?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. Why do you want to live in Muwekma-Tah-Ruk?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. How much do you know about Native American, Alaska Native, or Native Pacific Islander cultures?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. What do you hope to share about native cultures with your fellow residents? What do you hope to take away about other cultures?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. If you were to design a program associated with the house theme, what would you want to do? Please be creative and specific!</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">6. Describe a distinct memory or experience that you've had with your tribe or other respective culture. If you can't think of one, please describe a memorable experience you've had with your family.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">7. What does community mean to you?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">8. What was the latest conflict you experienced? How did you react to it?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">9. What would you pass on to freshmen from your Stanford experience?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">10. What's your passion and how have you explored it at Stanford?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">11. __ + __ + __ = Happy Me! Fill in the blanks in the below text area and explain.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_14 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Muwekma\\\"\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Muwekma will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Muwekma\\\"\\u003e\\n\\u003ch2\\u003eMuwekma Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003eIf assigned to Muwekma I must:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eComplete at least one quarter of house seminar, offered fall and winter quarters\\u003c/li\\u003e\\n\\u003cli\\u003eComplete 4 volunteer hours for the Stanford Powwow or Stanford Luau during spring quarter\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003eSome applicants will be selected to come in for interviews with our preassignment staff. We really appreciate your time and interest in Muwekma-Tah-Ruk.\\u003c/p\\u003e\\n\\u003ch2\\u003eMuwekma Essays\\u003c/h2\\u003e\\n\\u003cp\\u003ePlease answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Have you lived in Muwekma-Tah-Ruk before and if so, in what years?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Why do you want to live in Muwekma-Tah-Ruk?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. How much do you know about Native American, Alaska Native, or Native Pacific Islander cultures?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"4. What do you hope to share about native cultures with your fellow residents? What do you hope to take away about other cultures?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"5. If you were to design a program associated with the house theme, what would you want to do? Please be creative and specific!\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"6. Describe a distinct memory or experience that you've had with your tribe or other respective culture. If you can't think of one, please describe a memorable experience you've had with your family.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"7. What does community mean to you?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"8. What was the latest conflict you experienced? How did you react to it?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"9. What would you pass on to freshmen from your Stanford experience?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"10. What's your passion and how have you explored it at Stanford?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"11. __ + __ + __ = Happy Me! Fill in the blanks in the below text area and explain.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Okada House Supplemental Questions
pa_form_15 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Okada will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Okada">
<h2>Okada Requirements</h2>
<p>Pre-assignment to Okada will be made for students who agree to the following conditions:</p>
<ol>
<li>Participate in dorm life, attend house meetings regularly, and support other dorm activities (including other theme project presentations).</li>
<li>Complete a theme project (see essay question #2 below).</li>
<li>Participate in at least one off-campus dorm event each quarter.</li>
<li>Participate in the Listen to the Silence conference in January and/or the Asian/Pacific Islander Heritage Month celebration in May. This may include organizational duties such as publicity and volunteer shifts for events.</li>
<li>Residents planning to participate in a study abroad program in 2014-15, are not eligible for pre-assignment in Okada.</li>
</ol>
<h2>Okada Essays</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Why do you want to live in Okada? How will you contribute to the cultural vibrancy of the dorm? (200 words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please describe a theme project you would like to present to Okada residents. It should be well thought out and reflect the dorm's theme. A good theme project focuses on Asian American history, culture, or identity, and is interactive and fun. Be creative. Do not propose a project on Asian foods, hepatitis B or blood donor matching, unless you are presenting some new aspect. (300 words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_15 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Okada will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Okada\\\"\\u003e\\n\\u003ch2\\u003eOkada Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003ePre-assignment to Okada will be made for students who agree to the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eParticipate in dorm life, attend house meetings regularly, and support other dorm activities (including other theme project presentations).\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a theme project (see essay question #2 below).\\u003c/li\\u003e\\n\\u003cli\\u003eParticipate in at least one off-campus dorm event each quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eParticipate in the Listen to the Silence conference in January and/or the Asian/Pacific Islander Heritage Month celebration in May. This may include organizational duties such as publicity and volunteer shifts for events.\\u003c/li\\u003e\\n\\u003cli\\u003eResidents planning to participate in a study abroad program in 2014-15, are not eligible for pre-assignment in Okada.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eOkada Essays\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Why do you want to live in Okada? How will you contribute to the cultural vibrancy of the dorm? (200 words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Please describe a theme project you would like to present to Okada residents. It should be well thought out and reflect the dorm's theme. A good theme project focuses on Asian American history, culture, or identity, and is interactive and fun. Be creative. Do not propose a project on Asian foods, hepatitis B or blood donor matching, unless you are presenting some new aspect. (300 words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Slav Dom House Supplemental Questions
pa_form_16 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Slav Dom will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Slav Dom">
<h2>Slav Dom Requirements</h2>
<p>I understand I must complete&nbsp;<strong>all</strong>&nbsp;of the theme requirements for Slavianskii Dom or will risk loss of housing.</p>
<ol>
<li>For each quarter a resident lives in Slav Dom, regardless of pre-assignment status, the resident must acquire 8 theme points. Points can be acquired by attending in-house lectures, classes, and field trips, or by taking coursework related to the theme of the house and sharing this knowledge with the residents by teaching a class, giving a presentation, etc.</li>
<li>Each student must complete a theme project. The guidelines are as follows:
<ul>
<li>The project should have educational, theme-related content</li>
<li>The project should demonstrate serious effort (about 8 hours of work)</li>
<li>The project should be written up in the form of a 3-4 page paper or presented in a creative format, such as a poster. There will also be an oral presentation to the house. Residents will be expected to attend each other's theme presentations.</li>
</ul>
</li>
</ol>
<p>The theme requirement for Slavianskii Dom is an integral part of the house's mission, and should be taken seriously. Should you choose not to complete the theme requirements, you will be asked to leave Slavianskii Dom and find alternative housing, or your account will be put on hold.</p>
<h2>Slav Dom Essays</h2>
<p><strong>Pre-assignment to Slavianskii Dom will be granted to students who fulfill at least&nbsp;<em>ONE</em>&nbsp;of the following or all that apply:</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Spoken proficiency in an Eastern European language or a language of the Former Soviet Union. (Please include below a description of the language(s) and discuss how you became fluent, e.g. bi-lingual household, time spent living abroad, etc. The Theme Associates reserve the right to verify this ability with a language test).</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. Successful completion of 10 units of coursework in the Slavic Department by the end of Spring Quarter 2014. (An unofficial transcript is required at the tiime of preassignment application submission). Please list the course numbers, course names, and quarter(s) in which courses were taken below.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. The completion of one quarter abroad with the Stanford in Moscow Overseas Studies Program or a related overseas studies program. (An unofficial transcript is required at the time of preassignment application submission). Please indicate the Program &amp; quarter you were abroad below.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. Two quarters or more of residence in Slavianskii Dom in good standing with the requirements of the house, or regular attendance of in-house events. Please indicate the quarters of residence and/or events attended below.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. Students who do not meet any of these requirements but who are interested in pre-assignment may submit an essay detailing why they feel their personal experience, interests, and academic background merit pre-assignment and how they feel they would contribute to the academic theme. (Students may include an unofficial transcript if appropriate or a description of a relevant research project such as an honors thesis).</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div></div></div>
EOF
pa_form_schema_16 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Slav Dom will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Slav Dom\\\"\\u003e\\n\\u003ch2\\u003eSlav Dom Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003eI understand I must complete\\u0026nbsp;\\u003cstrong\\u003eall\\u003c/strong\\u003e\\u0026nbsp;of the theme requirements for Slavianskii Dom or will risk loss of housing.\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eFor each quarter a resident lives in Slav Dom, regardless of pre-assignment status, the resident must acquire 8 theme points. Points can be acquired by attending in-house lectures, classes, and field trips, or by taking coursework related to the theme of the house and sharing this knowledge with the residents by teaching a class, giving a presentation, etc.\\u003c/li\\u003e\\n\\u003cli\\u003eEach student must complete a theme project. The guidelines are as follows:\\n\\u003cul\\u003e\\n\\u003cli\\u003eThe project should have educational, theme-related content\\u003c/li\\u003e\\n\\u003cli\\u003eThe project should demonstrate serious effort (about 8 hours of work)\\u003c/li\\u003e\\n\\u003cli\\u003eThe project should be written up in the form of a 3-4 page paper or presented in a creative format, such as a poster. There will also be an oral presentation to the house. Residents will be expected to attend each other's theme presentations.\\u003c/li\\u003e\\n\\u003c/ul\\u003e\\n\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003eThe theme requirement for Slavianskii Dom is an integral part of the house's mission, and should be taken seriously. Should you choose not to complete the theme requirements, you will be asked to leave Slavianskii Dom and find alternative housing, or your account will be put on hold.\\u003c/p\\u003e\\n\\u003ch2\\u003eSlav Dom Essays\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePre-assignment to Slavianskii Dom will be granted to students who fulfill at least\\u0026nbsp;\\u003cem\\u003eONE\\u003c/em\\u003e\\u0026nbsp;of the following or all that apply:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Spoken proficiency in an Eastern European language or a language of the Former Soviet Union. (Please include below a description of the language(s) and discuss how you became fluent, e.g. bi-lingual household, time spent living abroad, etc. The Theme Associates reserve the right to verify this ability with a language test).\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. Successful completion of 10 units of coursework in the Slavic Department by the end of Spring Quarter 2014. (An unofficial transcript is required at the tiime of preassignment application submission). Please list the course numbers, course names, and quarter(s) in which courses were taken below.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. The completion of one quarter abroad with the Stanford in Moscow Overseas Studies Program or a related overseas studies program. (An unofficial transcript is required at the time of preassignment application submission). Please indicate the Program \\u0026amp; quarter you were abroad below.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"4. Two quarters or more of residence in Slavianskii Dom in good standing with the requirements of the house, or regular attendance of in-house events. Please indicate the quarters of residence and/or events attended below.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"5. Students who do not meet any of these requirements but who are interested in pre-assignment may submit an essay detailing why they feel their personal experience, interests, and academic background merit pre-assignment and how they feel they would contribute to the academic theme. (Students may include an unofficial transcript if appropriate or a description of a relevant research project such as an honors thesis).\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false}]"

# Storey House Supplemental Questions
pa_form_17 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Storey will REQUIRE the use of a TIER TWO housing choice. If tier two is no longer available, then TIER ONE will be used.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Storey">
<h2>Storey Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Storey House will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Are Human Biology majors OR have a strong interest in Human Biology</li>
<li>Are willing to meet all of the pre-assignment requirements once assigned (see below).</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>Pre-assignment will be considered for students who agree to complete the following requirements.</p>
<ol>
<li>Attend three HumBio theme events per quarter.</li>
<li>Discuss events attended and present academic interests in monthly pre-assigned student meetings.</li>
<li>Take the 1-unit Spring-Quarter student initiated course (SIC) taught by the ATAs.</li>
<li>Attend two field trips over the course of the year (these events will be put on by the ATAs).</li>
</ol>
<p><strong>Note:</strong>&nbsp;These requirements are subject to slight change by next year's ATAs.</p>
<h2>Storey Essays</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Describe how your interests relate to HumBio, and describe one interest in particular that you would like to share with the house in a presentation, activity, or theme-event. (max 500 words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Do you plan on going abroad next year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">List any HumBio-related courses you have taken or plan on taking next year, including HumBio-related lecture series, events, clubs, or activities.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please list three possible house themes for the 2014-2015 year (i.e. Ancient Hi-STOREY, STOR-opical Rainforest, etc.) with associated events.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_17 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Storey will REQUIRE the use of a TIER TWO housing choice. If tier two is no longer available, then TIER ONE will be used.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Storey\\\"\\u003e\\n\\u003ch2\\u003eStorey Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Storey House will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eAre Human Biology majors OR have a strong interest in Human Biology\\u003c/li\\u003e\\n\\u003cli\\u003eAre willing to meet all of the pre-assignment requirements once assigned (see below).\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment will be considered for students who agree to complete the following requirements.\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eAttend three HumBio theme events per quarter.\\u003c/li\\u003e\\n\\u003cli\\u003eDiscuss events attended and present academic interests in monthly pre-assigned student meetings.\\u003c/li\\u003e\\n\\u003cli\\u003eTake the 1-unit Spring-Quarter student initiated course (SIC) taught by the ATAs.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend two field trips over the course of the year (these events will be put on by the ATAs).\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003eNote:\\u003c/strong\\u003e\\u0026nbsp;These requirements are subject to slight change by next year's ATAs.\\u003c/p\\u003e\\n\\u003ch2\\u003eStorey Essays\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Describe how your interests relate to HumBio, and describe one interest in particular that you would like to share with the house in a presentation, activity, or theme-event. (max 500 words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Do you plan on going abroad next year?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"List any HumBio-related courses you have taken or plan on taking next year, including HumBio-related lecture series, events, clubs, or activities.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Please list three possible house themes for the 2014-2015 year (i.e. Ancient Hi-STOREY, STOR-opical Rainforest, etc.) with associated events.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Castano House Supplemental Questions
pa_form_18 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Castano will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2>Castano Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Castano be considered for students who fulfill the following conditions:</p>
<ol>
<li>Are a current resident in Castano.</li>
<li>Have an interest in being an active participant in building Castano community.</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>If assigned to Castano you must</p>
<ol>
<li>Attend the Community Leadership course (Fall Quarter preferred): Tuesday evenings, 7:30 - 9pm</li>
<li>Attend staff meetings (Typically 1 - 2 meetings per month) with the RAs, PHE and RCC.</li>
<li>Participate in the Staff Retreat the week before school starts.</li>
</ol>
<h2>Castano Essays</h2>
<p>Castano creates a community environment that fosters the opportunity to find one's voice and engage in learning from each other. With this in mind, please answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. What has Castano meant to you this year and why do you want to come back?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. How do you plan to foster a strong community next year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_18 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Castano will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2\\u003eCastano Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Castano be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eAre a current resident in Castano.\\u003c/li\\u003e\\n\\u003cli\\u003eHave an interest in being an active participant in building Castano community.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eIf assigned to Castano you must\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eAttend the Community Leadership course (Fall Quarter preferred): Tuesday evenings, 7:30 - 9pm\\u003c/li\\u003e\\n\\u003cli\\u003eAttend staff meetings (Typically 1 - 2 meetings per month) with the RAs, PHE and RCC.\\u003c/li\\u003e\\n\\u003cli\\u003eParticipate in the Staff Retreat the week before school starts.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eCastano Essays\\u003c/h2\\u003e\\n\\u003cp\\u003eCastano creates a community environment that fosters the opportunity to find one's voice and engage in learning from each other. With this in mind, please answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. What has Castano meant to you this year and why do you want to come back?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. How do you plan to foster a strong community next year?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Substance Free House Supplemental Questions
pa_form_19 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Substance-Free will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Substance-Free">
<h2>Requirements to Qualify for Pre-Assignment</h2>
<p>Pre-assignment to Substance-Free will be open to any student, regardless of major, sophomore through senior that demonstrates a strong commitment for living substance free.</p>
<h2>Requirements if Assigned</h2>
<p>Pre-assigned students will be expected to complete the following:</p>
<ol>
<li>Residents will not be in possession of, use, or be under the influence of, alcohol, tobacco, or other illegal substances while within the residence. Nor will they misuse legal substances or prescription drugs.</li>
<li>Residents will ensure that all guests adhere completely to the Substance-Free Community Standards.</li>
<li>Residents will actively participate in creating and sustaining a substance free community.</li>
</ol>
<h2>Substance-Free Essay</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Why do you want to live in the Substance-Free Community?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">How would you help to build and substain the Substance-Free Community?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">How would you hold others in your community responsible if they breeched their commitment to the Substance-Free Community Standards?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_19 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Substance-Free will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Substance-Free\\\"\\u003e\\n\\u003ch2\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h2\\u003e\\n\\u003cp\\u003ePre-assignment to Substance-Free will be open to any student, regardless of major, sophomore through senior that demonstrates a strong commitment for living substance free.\\u003c/p\\u003e\\n\\u003ch2\\u003eRequirements if Assigned\\u003c/h2\\u003e\\n\\u003cp\\u003ePre-assigned students will be expected to complete the following:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eResidents will not be in possession of, use, or be under the influence of, alcohol, tobacco, or other illegal substances while within the residence. Nor will they misuse legal substances or prescription drugs.\\u003c/li\\u003e\\n\\u003cli\\u003eResidents will ensure that all guests adhere completely to the Substance-Free Community Standards.\\u003c/li\\u003e\\n\\u003cli\\u003eResidents will actively participate in creating and sustaining a substance free community.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eSubstance-Free Essay\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Why do you want to live in the Substance-Free Community?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"How would you help to build and substain the Substance-Free Community?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"How would you hold others in your community responsible if they breeched their commitment to the Substance-Free Community Standards?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Synergy House Supplemental Questions
pa_form_20 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<p>&nbsp;</p>
<div id="Synergy">
<h2>Synergy</h2>
<p>Synergy is a student-run cooperative community on the campus of Stanford. Cooperative organizations were central to the founders' vision for Stanford University, and have existed on the campus since it opened its doors in 1891. Synergy itself has a rich forty-year history. It was founded in 1972, growing out of a student-initiated course that sought to establish and experiment with a community encouraging cooperative relationships, collective action, and alternative lifestyles.</p>
<p>Synergy has a warm, eccentric, and tight-knit community. There's always good music playing in the kitchen and often someone on a guitar or the piano. We throw awesome parties for Halloween and Valentine's Day and host many more intimate gatherings.</p>
<p>Synergy sits atop a quiet, forested hill and is an idyllic refuge from the rest of campus. When you walk up our path and under the prayer flags, you step into a different world: our big, beautiful house has a secluded lawn, garden, and - from the roof - a sweeping view of the whole bay area. We also have spacious common rooms, four porches, a movie projector room, and a fantastic open kitchen. Synergy is vegetarian and serves dinner Sunday-Friday (but you certainly don't have to be vegetarian to live here!). House policy is made by consensus, which means every resident has a voice and all decisions (noise and job policies, what social events to have, etc.) must be approved by everyone present at the consensus meeting. We also change rooms every quarter through a consensus process.</p>
</div>
<p>&nbsp;</p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Synergy will REQUIRE the use of a TIER TWO housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Synergy">
<h2>Synergy Requirements</h2>
<p>Pre-assignment to Synergy will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Every pre-assignment applicant must complete a cooking/cleaning job (duration of about 1.5 hours) at Synergy, unless the applicant is currently living in a co-op.</li>
<li>Complete a house tour of Synergy, and receive a brief overview of the consensus process Synergy uses to make decisions.</li>
<li>Attend a dinner at Synergy.</li>
</ol>
<h2>Synergy Essay</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please write a brief essay of no more than 200 words describing why you wish to live in Synergy, and how you plan to contribute to the community Why do you want to live in Synergy? How will you contribute to the vibrancy of the dorm? (200 words)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_20 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Synergy\\\"\\u003e\\n\\u003ch2\\u003eSynergy\\u003c/h2\\u003e\\n\\u003cp\\u003eSynergy is a student-run cooperative community on the campus of Stanford. Cooperative organizations were central to the founders' vision for Stanford University, and have existed on the campus since it opened its doors in 1891. Synergy itself has a rich forty-year history. It was founded in 1972, growing out of a student-initiated course that sought to establish and experiment with a community encouraging cooperative relationships, collective action, and alternative lifestyles.\\u003c/p\\u003e\\n\\u003cp\\u003eSynergy has a warm, eccentric, and tight-knit community. There's always good music playing in the kitchen and often someone on a guitar or the piano. We throw awesome parties for Halloween and Valentine's Day and host many more intimate gatherings.\\u003c/p\\u003e\\n\\u003cp\\u003eSynergy sits atop a quiet, forested hill and is an idyllic refuge from the rest of campus. When you walk up our path and under the prayer flags, you step into a different world: our big, beautiful house has a secluded lawn, garden, and - from the roof - a sweeping view of the whole bay area. We also have spacious common rooms, four porches, a movie projector room, and a fantastic open kitchen. Synergy is vegetarian and serves dinner Sunday-Friday (but you certainly don't have to be vegetarian to live here!). House policy is made by consensus, which means every resident has a voice and all decisions (noise and job policies, what social events to have, etc.) must be approved by everyone present at the consensus meeting. We also change rooms every quarter through a consensus process.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Synergy will REQUIRE the use of a TIER TWO housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Synergy\\\"\\u003e\\n\\u003ch2\\u003eSynergy Requirements\\u003c/h2\\u003e\\n\\u003cp\\u003ePre-assignment to Synergy will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery pre-assignment applicant must complete a cooking/cleaning job (duration of about 1.5 hours) at Synergy, unless the applicant is currently living in a co-op.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of Synergy, and receive a brief overview of the consensus process Synergy uses to make decisions.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at Synergy.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eSynergy Essay\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Please write a brief essay of no more than 200 words describing why you wish to live in Synergy, and how you plan to contribute to the community Why do you want to live in Synergy? How will you contribute to the vibrancy of the dorm? (200 words)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Terra House Supplemental Questions
pa_form_21 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Terra will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Terra">
<h2>Terra Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Terra will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Every pre-assignment applicant must complete a house job at Terra.</li>
<li>Complete a house tour of Terra.</li>
<li>Attend a dinner at Terra.</li>
</ol>
<p>Information on completing these requirements can be found on&nbsp;<a href="http://coop.stanfordtest.edu/" target="info">coop.stanfordtest.edu.</a></p>
<h2>Terra Essays</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Please write a brief essay of no more than 200 words describing why you wish to live in Terra, and how you plan to contribute to the community.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_21 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Terra will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Terra\\\"\\u003e\\n\\u003ch2\\u003eTerra Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Terra will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eEvery pre-assignment applicant must complete a house job at Terra.\\u003c/li\\u003e\\n\\u003cli\\u003eComplete a house tour of Terra.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend a dinner at Terra.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003cp\\u003eInformation on completing these requirements can be found on\\u0026nbsp;\\u003ca href=\\\"http://coop.stanfordtest.edu/\\\" target=\\\"info\\\"\\u003ecoop.stanfordtest.edu.\\u003c/a\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTerra Essays\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Please write a brief essay of no more than 200 words describing why you wish to live in Terra, and how you plan to contribute to the community.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

# Ujamaa House Supplemental Questions
pa_form_22 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Ujamaa will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Ujamaa">
<h2>Ujamaa Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>&nbsp;</p>
<p>Pre-assignment to Ujamaa will be considered for students who complete and submit an Ujamaa Scholars Theme Proposal. The&nbsp;<a href="http://studentaffairs.stanfordtest.edu/sites/default/files/resed/files/Ujamaa%20Scholars%20Theme%20Proposal%20Instructions.pdf" target="_win">guidelines of the Ujamaa Scholars Theme Proposal can be found here</a>&nbsp;as well as a&nbsp;<a href="https://studentaffairs.stanfordtest.edu/sites/default/files/resed/files/SAMPLE%20Ujamaa%20Scholars%20Proposal%202014-2015-4.pdf" target="_win">sample proposal</a>&nbsp;for your reference.</p>
<p>The Ujamaa Scholars Program is designed to continue a long history of intellectual discourse focused on the African Diaspora in Ujamaa House. As an Ujamaa Scholar, you will be responsible for presenting a program that explores a topic of your choice that exposes residents to issues related to the Black experience. Your program is expected to be one hour, which includes question and answer.</p>
<h3>Requirements if Assigned</h3>
<p>If assigned as an Ujamaa Scholar you will be required to attend an hour meeting this spring quarter, a fall quarter welcome reception, and at least four theme programs per quarter. This program is an enhanced version of our current Theme Program Series. If you have any questions or would like a tour of our residence, please contact the&nbsp;<a href="mailto:ccz@stanfordtest.edu">Chris Corces-Zimmerman</a></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I will submit an unofficial transcript to Chris Corces-Zimmerman (ccz@stanfordtest.edu) AND preassignment@lists.stanfordtest.edu as part of my application.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Ujamaa">
<h2>Basic Questions</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Student ID:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Title of the program:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Previous residences:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Class year</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">The quarter you prefer to present: </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Ujamaa">
<h2>Ujamaa Essays</h2>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Why are you applying to be an Ujamaa Scholar?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. What activities have you been involved in at Stanford?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Why do you want to live in Ujamaa?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. Using the proposal guidelines above, please describe your Theme Proposal (i.e. purpose, learning outcomes, how will you structure the presentation, etc)</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. How would you publicize your program?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Ujamaa">
<p><strong>Please submit your theme proposal file (please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename.)</strong></p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="file">File Upload</label>
          <input type="file">
        </div></div></div>
EOF
pa_form_schema_22 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Ujamaa will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Ujamaa\\\"\\u003e\\n\\u003ch2\\u003eUjamaa Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003ePre-assignment to Ujamaa will be considered for students who complete and submit an Ujamaa Scholars Theme Proposal. The\\u0026nbsp;\\u003ca href=\\\"http://studentaffairs.stanfordtest.edu/sites/default/files/resed/files/Ujamaa%20Scholars%20Theme%20Proposal%20Instructions.pdf\\\" target=\\\"_win\\\"\\u003eguidelines of the Ujamaa Scholars Theme Proposal can be found here\\u003c/a\\u003e\\u0026nbsp;as well as a\\u0026nbsp;\\u003ca href=\\\"https://studentaffairs.stanfordtest.edu/sites/default/files/resed/files/SAMPLE%20Ujamaa%20Scholars%20Proposal%202014-2015-4.pdf\\\" target=\\\"_win\\\"\\u003esample proposal\\u003c/a\\u003e\\u0026nbsp;for your reference.\\u003c/p\\u003e\\n\\u003cp\\u003eThe Ujamaa Scholars Program is designed to continue a long history of intellectual discourse focused on the African Diaspora in Ujamaa House. As an Ujamaa Scholar, you will be responsible for presenting a program that explores a topic of your choice that exposes residents to issues related to the Black experience. Your program is expected to be one hour, which includes question and answer.\\u003c/p\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eIf assigned as an Ujamaa Scholar you will be required to attend an hour meeting this spring quarter, a fall quarter welcome reception, and at least four theme programs per quarter. This program is an enhanced version of our current Theme Program Series. If you have any questions or would like a tour of our residence, please contact the\\u0026nbsp;\\u003ca href=\\\"mailto:ccz@stanfordtest.edu\\\"\\u003eChris Corces-Zimmerman\\u003c/a\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I will submit an unofficial transcript to Chris Corces-Zimmerman (ccz@stanfordtest.edu) AND preassignment@lists.stanfordtest.edu as part of my application.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Ujamaa\\\"\\u003e\\n\\u003ch2\\u003eBasic Questions\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Student ID:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Title of the program:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Previous residences:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Class year\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"The quarter you prefer to present: \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Ujamaa\\\"\\u003e\\n\\u003ch2\\u003eUjamaa Essays\\u003c/h2\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Why are you applying to be an Ujamaa Scholar?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. What activities have you been involved in at Stanford?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. Why do you want to live in Ujamaa?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"4. Using the proposal guidelines above, please describe your Theme Proposal (i.e. purpose, learning outcomes, how will you structure the presentation, etc)\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"5. How would you publicize your program?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Ujamaa\\\"\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease submit your theme proposal file (please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename.)\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"File Upload\",\"type\":\"file\"}]"

# Casa Zapata House Supplemental Questions
pa_form_23 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>House Supplemental Questions</strong></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to periodically hit "Save" while working in order to avoid losing your work.</strong>&nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.</p>
<p><em>Please note: saving does not submit your materials; you must submit your application from the application materials page.</em></p>
<h2>Tier Requirement</h2>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">I understand that pre-assignment to Casa Zapata will REQUIRE the use of a TIER THREE housing choice.</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>&nbsp;</p>
<div id="Casa Zapata">
<h2>Casa Zapata Requirements</h2>
<h3>Requirements to Qualify for Pre-Assignment</h3>
<p>Pre-assignment to Casa Zapata will be considered for students who fulfill the following conditions:</p>
<ol>
<li>Have an interest in Casa Zapata's theme and, through their application, demonstrate the ability to contribute to the dorm's learning environment.</li>
</ol>
<h3>Requirements if Assigned</h3>
<p>If assigned to Casa Zapata you must</p>
<ol>
<li>Present at least one theme project - subject to approval by, and consultation with, the Resident Fellows and staff - for dorm residents.</li>
<li>Attend at least 8 of the 10 priority resident theme presentations.</li>
<li>Attend one orientation session prior to presenting in the dorm.</li>
<li>Fill volunteer roles in Zapata-Wide Educational and Cultural Programs such as Zoot Suit and other Casa Zapata dorm traditions.</li>
</ol>
<h2>Casa Zapata Essays</h2>
<p>Casa Zapata creates a learning environment that fosters exploration of Chicano/Latino history, tradition and culture. With this in mind, please answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.</p>
</div>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Tell us why you are interested in living in Casa Zapata.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. How will you contribute to the community at Zapata? What are your strengths as a prospective resident?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. Present an idea for a theme program that contributes to the theme of Zapata. Be creative and suggest a program that reflects your personal interests and passion! This program does not need to be a lecture, but rather should be integrated with the theme of the dorm and reflect your particular desire to live in Casa Zapata. Your proposal does not need to follow a particular presentation format. You are not committing to this program right now - so feel free to use this opportunity to explore an idea.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. What will students learn as a result of your program?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">5. Is there anything else you would like to share with us?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF
pa_form_schema_23 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eHouse Supplemental Questions\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to periodically hit \\\"Save\\\" while working in order to avoid losing your work.\\u003c/strong\\u003e\\u0026nbsp;For short answer/essay questions, you may want to compose your responses in NotePad or TextEdit and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cem\\u003ePlease note: saving does not submit your materials; you must submit your application from the application materials page.\\u003c/em\\u003e\\u003c/p\\u003e\\n\\u003ch2\\u003eTier Requirement\\u003c/h2\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"I understand that pre-assignment to Casa Zapata will REQUIRE the use of a TIER THREE housing choice.\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"Casa Zapata\\\"\\u003e\\n\\u003ch2\\u003eCasa Zapata Requirements\\u003c/h2\\u003e\\n\\u003ch3\\u003eRequirements to Qualify for Pre-Assignment\\u003c/h3\\u003e\\n\\u003cp\\u003ePre-assignment to Casa Zapata will be considered for students who fulfill the following conditions:\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003eHave an interest in Casa Zapata's theme and, through their application, demonstrate the ability to contribute to the dorm's learning environment.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch3\\u003eRequirements if Assigned\\u003c/h3\\u003e\\n\\u003cp\\u003eIf assigned to Casa Zapata you must\\u003c/p\\u003e\\n\\u003col\\u003e\\n\\u003cli\\u003ePresent at least one theme project - subject to approval by, and consultation with, the Resident Fellows and staff - for dorm residents.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend at least 8 of the 10 priority resident theme presentations.\\u003c/li\\u003e\\n\\u003cli\\u003eAttend one orientation session prior to presenting in the dorm.\\u003c/li\\u003e\\n\\u003cli\\u003eFill volunteer roles in Zapata-Wide Educational and Cultural Programs such as Zoot Suit and other Casa Zapata dorm traditions.\\u003c/li\\u003e\\n\\u003c/ol\\u003e\\n\\u003ch2\\u003eCasa Zapata Essays\\u003c/h2\\u003e\\n\\u003cp\\u003eCasa Zapata creates a learning environment that fosters exploration of Chicano/Latino history, tradition and culture. With this in mind, please answer the following questions honestly and thoughtfully. The house staff will use this application to help facilitate the pre-assignment decision process.\\u003c/p\\u003e\\n\\u003c/div\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"1. Tell us why you are interested in living in Casa Zapata.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"2. How will you contribute to the community at Zapata? What are your strengths as a prospective resident?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"3. Present an idea for a theme program that contributes to the theme of Zapata. Be creative and suggest a program that reflects your personal interests and passion! This program does not need to be a lecture, but rather should be integrated with the theme of the dorm and reflect your particular desire to live in Casa Zapata. Your proposal does not need to follow a particular presentation format. You are not committing to this program right now - so feel free to use this opportunity to explore an idea.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"4. What will students learn as a result of your program?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"5. Is there anything else you would like to share with us?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_application_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>[[CurrentProcess]]: Application Materials: Application Form</strong></span><br> </p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.<br> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></p>
<p style="text-align: center;"><strong>Profile</strong></p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Name</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">SUNet ID</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">University ID Number</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone Number</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Local Address</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Home Phone Number</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Home Address</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Away Spring</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Away Winter</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Major(s)</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Please list all the Residences you have lived in on campus, and any positions you held in those residences:</strong></p>
</div>
        </div><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 1:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 2:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 3:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 4:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Please select which Residential Education student staff position(s) you are applying to:</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Resident Assistant (RA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Kitchen Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Financial Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Co-Op Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Community Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Academic Theme Associate (ATA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Ethnic Theme Associate (ETA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Focus Assistant (FA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option8-0"><span>Language and Culture Academic Theme Associate (LCATA)</span></label></div></div><div id="exist-sort-18" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Please list your projected number of units for each quarter of the [[CurrentYear]]&nbsp;academic year:</strong></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Fall Quarter</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-20" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Winter Quarter</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-3" class="drop-block col-lg-4 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-21" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Spring Quarter</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-22" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>List your extracurricular activities for the [[CurrentYear]]&nbsp;academic year. Include activities such as job searches, graduate school applications/interviews, as well as other extracurriculars (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-23" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 1:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-24" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 2:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-25" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 3:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-26" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 4:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-27" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 5:</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-28" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Our residential communities are a place of invaluable intellectual and interpersonal learning, and student staff engagement within our communities plays an integral role in that learning process. List 5 ways in which you have been engaged with your residence(s), involved with Residential Education, and/or engaged with the larger Stanford community. (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-29" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 1:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-30" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 2:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-31" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 3:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-32" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 4:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-33" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 5:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-34" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Some of the best learning experiences come when students share their intellectual interests with each other. List five intellectual interests of yours (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-35" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 1:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-36" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 2:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-37" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 3:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-38" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 4:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-39" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 5:  </label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-40" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3>Essays</h3>
<p>&nbsp;</p>
<p>Due Date:<span style="background-color: #ffffff;">&nbsp;<span style="color: #800000;">[[ApplicationEndTime]].</span></span></p>
<p>&nbsp;</p>
<ul>
<li>We recommend that, instead of composing your essay directly in the web browser, you type up your responses in a text editor (such as Notepad, or TextEdit), then highlight the text of each question, select&nbsp;<strong>"Copy"</strong>&nbsp;from the Edit menu, then switch to the browser, and select&nbsp;<strong>"Edit | Paste"</strong>&nbsp;to paste in your responses.</li>
<li>When you cut and paste from a word processor like Microsoft Word and save your changes in the web browser, some of your punctuations may be lost or appear as strange characters in the saved version; this is because Microsoft Word sometimes replaces some punctuation marks, such as ellipsis (...) with special non-standard characters. We recommend against using Microsoft Word. But, if you do draft you responses in a word processor, we recommend that you proof read the text in the web browser and replace the altered punctuation with the correct characters.</li>
<li>Use the TAB key to switch between boxes.</li>
<li>Please skip a line between paragraphs.</li>
<li>You are limited to&nbsp;<strong>250 words</strong>&nbsp;per question. Many supervisors will not read beyond this amount.</li>
</ul>
</div>
        </div><div id="exist-sort-41" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Why do you want to be on house staff. No really, Why? (Be warned, everyone answers this question in the same way -- please take some time to really reflect on your "why").</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-42" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. We think that part of the role of a student staff member is to facilitate and enable interesting and engaging conversations among house members. Please chose one of the following two questions with this in mind:  Option 1: Some of the best learning experiences on campus come when students share their intellectual (not necessarily academic) interests with each other. Describe something that you are intellectually excited or passionate about, and give some concrete ideas for how you will engage the residents in this interest.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-43" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Option 2: Tell us about a book, movie or piece of music/art/writing that you were so excited about that you wanted to share it with others. What is the book, movie or piece of music/art/writing, and why is it exciting to you?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-44" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. OPTIONAL: If not captured in your responses to previous questions, please use this space to express additional information you feel relevant to your candidacy (feel free to expand on one of the experiences you listed in the short answer questions above).</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-45" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. OPTIONAL: As part of the selection process, we ask Residence Deans, Resident Fellows, and Program Associates their perspectives regarding experiences and challenges you may have encountered in your time at Stanford, as these are frequently an opportunity for learning and growth. If you like, take the space below to address any challenges you have faced that may have come to the attention of a Residence Dean, Resident Fellow, or Program Associate.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_application_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003e[[CurrentProcess]]: Application Materials: Application Form\\u003c/strong\\u003e\\u003c/span\\u003e\\u003cbr\\u003e \\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003cbr\\u003e \\u003cstrong\\u003e\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp; \\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eProfile\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Name\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"SUNet ID\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"University ID Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Cell Phone Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Local Address\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Home Phone Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Home Address\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Away Spring\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Away Winter\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Major(s)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease list all the Residences you have lived in on campus, and any positions you held in those residences:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Position 1:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Position 2:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Position 3:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Position 4:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Please select which Residential Education student staff position(s) you are applying to:\",\"type\":\"checkbox\",\"options\":[\"Resident Assistant (RA)\",\"\\u003cbr /\\u003e\",\"Kitchen Manager\",\"\\u003cbr /\\u003e\",\"Financial Manager\",\"\\u003cbr /\\u003e\",\"Co-Op Manager\",\"\\u003cbr /\\u003e\",\"Community Manager\",\"\\u003cbr /\\u003e\",\"Academic Theme Associate (ATA)\",\"\\u003cbr /\\u003e\",\"Ethnic Theme Associate (ETA)\",\"\\u003cbr /\\u003e\",\"Focus Assistant (FA)\",\"\\u003cbr /\\u003e\",\"Language and Culture Academic Theme Associate (LCATA)\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease list your projected number of units for each quarter of the [[CurrentYear]]\\u0026nbsp;academic year:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"Fall Quarter\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":1,\"description\":\"Winter Quarter\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":2,\"description\":\"Spring Quarter\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eList your extracurricular activities for the [[CurrentYear]]\\u0026nbsp;academic year. Include activities such as job searches, graduate school applications/interviews, as well as other extracurriculars (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Activity 1:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Activity 2:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Activity 3:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Activity 4:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Activity 5:\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eOur residential communities are a place of invaluable intellectual and interpersonal learning, and student staff engagement within our communities plays an integral role in that learning process. List 5 ways in which you have been engaged with your residence(s), involved with Residential Education, and/or engaged with the larger Stanford community. (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Involvement 1:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Involvement 2:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Involvement 3:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Involvement 4:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Involvement 5:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eSome of the best learning experiences come when students share their intellectual interests with each other. List five intellectual interests of yours (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Experiences 1:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Experiences 2:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Experiences 3:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Experiences 4:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Experiences 5:  \",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eEssays\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003eDue Date:\\u003cspan style=\\\"background-color: #ffffff;\\\"\\u003e\\u0026nbsp;\\u003cspan style=\\\"color: #800000;\\\"\\u003e[[ApplicationEndTime]].\\u003c/span\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cul\\u003e\\n\\u003cli\\u003eWe recommend that, instead of composing your essay directly in the web browser, you type up your responses in a text editor (such as Notepad, or TextEdit), then highlight the text of each question, select\\u0026nbsp;\\u003cstrong\\u003e\\\"Copy\\\"\\u003c/strong\\u003e\\u0026nbsp;from the Edit menu, then switch to the browser, and select\\u0026nbsp;\\u003cstrong\\u003e\\\"Edit | Paste\\\"\\u003c/strong\\u003e\\u0026nbsp;to paste in your responses.\\u003c/li\\u003e\\n\\u003cli\\u003eWhen you cut and paste from a word processor like Microsoft Word and save your changes in the web browser, some of your punctuations may be lost or appear as strange characters in the saved version; this is because Microsoft Word sometimes replaces some punctuation marks, such as ellipsis (...) with special non-standard characters. We recommend against using Microsoft Word. But, if you do draft you responses in a word processor, we recommend that you proof read the text in the web browser and replace the altered punctuation with the correct characters.\\u003c/li\\u003e\\n\\u003cli\\u003eUse the TAB key to switch between boxes.\\u003c/li\\u003e\\n\\u003cli\\u003ePlease skip a line between paragraphs.\\u003c/li\\u003e\\n\\u003cli\\u003eYou are limited to\\u0026nbsp;\\u003cstrong\\u003e250 words\\u003c/strong\\u003e\\u0026nbsp;per question. Many supervisors will not read beyond this amount.\\u003c/li\\u003e\\n\\u003c/ul\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"1. Why do you want to be on house staff. No really, Why? (Be warned, everyone answers this question in the same way -- please take some time to really reflect on your \\\"why\\\").\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"2. We think that part of the role of a student staff member is to facilitate and enable interesting and engaging conversations among house members. Please chose one of the following two questions with this in mind:  Option 1: Some of the best learning experiences on campus come when students share their intellectual (not necessarily academic) interests with each other. Describe something that you are intellectually excited or passionate about, and give some concrete ideas for how you will engage the residents in this interest.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Option 2: Tell us about a book, movie or piece of music/art/writing that you were so excited about that you wanted to share it with others. What is the book, movie or piece of music/art/writing, and why is it exciting to you?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"3. OPTIONAL: If not captured in your responses to previous questions, please use this space to express additional information you feel relevant to your candidacy (feel free to expand on one of the experiences you listed in the short answer questions above).\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"4. OPTIONAL: As part of the selection process, we ask Residence Deans, Resident Fellows, and Program Associates their perspectives regarding experiences and challenges you may have encountered in your time at Stanford, as these are frequently an opportunity for learning and growth. If you like, take the space below to address any challenges you have faced that may have come to the attention of a Residence Dean, Resident Fellow, or Program Associate.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_system_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: center;">&nbsp;</p>
<h1 class="ng-binding"><strong><span style="font-size: 14pt;">House Staff Selection</span></strong></h1>
<p style="text-align: center;"><span style="font-size: 14pt;"><strong>: Application Materials: Application Form</strong></span></p>
<p>Please complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.</p>
<p><strong>Please remember to hit "Save" after working in order to avoid losing your work.</strong> For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.<br> <strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></p>
<p style="text-align: center;"><strong><span style="font-size: 12pt;">Profile</span><br> <br> </strong></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">First Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Middle Name</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Last Name</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">SUNetID</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">University ID</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Number</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Cell Phone Number</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Phone</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Local Address</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Home Phone Number</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="yes" rq="no">Address</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Away Spring</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-13" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Away Winter</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-14" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Major(s)</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-13" style="border: 2px dashed transparent;"><div id="exist-drop-16" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<table width="70%">
<tbody>
<tr>
<td>
<p><strong>Please list all the Residences you have lived in on campus, and any positions you held in those residences:</strong></p>
</td>
</tr>
</tbody>
</table>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-14" style="border: 2px dashed transparent;"><div id="exist-drop-17" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">House 1</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-18" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 1</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-19" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-19" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>(if applicable)</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-15" style="border: 2px dashed transparent;"><div id="exist-drop-20" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-20" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">House 2</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-21" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-21" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 2</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-22" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-22" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>(if applicable)</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-16" style="border: 2px dashed transparent;"><div id="exist-drop-23" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-23" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">House 3</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-24" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-24" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 3</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-25" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-25" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>(if applicable)</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-17" style="border: 2px dashed transparent;"><div id="exist-drop-26" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-26" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">House 4</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-27" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-27" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Position 4</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-28" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-28" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p>(if applicable)</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-18" style="border: 2px dashed transparent;"><div id="exist-drop-29" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-29" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple" rq="no">Please select which Residential Education student staff position(s) you are applying to:</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Resident Assistant (RA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Kitchen Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Financial Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Co-Op Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Community Manager</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Academic Theme Associate (ATA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Ethnic Theme Associate (ETA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Focus Assistant (FA)</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option8-0"><span>Language and Culture Academic Theme Associate (LCATA)</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-19" style="border: 2px dashed transparent;"><div id="exist-drop-30" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-30" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Please list your projected number of units for each quarter of the 2014-15 academic year:</strong></p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-20" style="border: 2px dashed transparent;"><div id="exist-drop-31" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-31" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Fall Quarter</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-32" class="drop-block ui-droppable ui-sortable col-lg-4" style="border: 2px dashed transparent;"><div id="exist-sort-32" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Winter Quarte</label>
          <input type="text" style="width: 100%;">
        </div></div><div id="exist-drop-33" class="drop-block col-lg-4 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-33" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Spring Quarter</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-21" style="border: 2px dashed transparent;"><div id="exist-drop-34" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-34" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>List your extracurricular activities for the 2014 - 2015 academic year. Include activities such as job searches, graduate school applications/interviews, as well as other extracurriculars (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-35" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 1</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-36" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 2</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-37" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 3</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-38" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 4</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-39" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Activity 5</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-22" style="border: 2px dashed transparent;"><div id="exist-drop-35" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-40" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Our residential communities are a place of invaluable intellectual and interpersonal learning, and student staff engagement within our communities plays an integral role in that learning process. List 5 ways in which you have been engaged with your residence(s), involved with Residential Education, and/or engaged with the larger Stanford community. (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-41" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 1</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-42" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 2</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-43" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 3</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-44" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 4</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-45" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Involvement 5</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-23" style="border: 2px dashed transparent;"><div id="exist-drop-36" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-46" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong>Some of the best learning experiences come when students share their intellectual interests with each other. List five intellectual interests of yours (Please limit your responses to 25 words or fewer).</strong></p>
</div>
        </div><div id="exist-sort-47" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 1</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-48" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 2</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-49" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 3</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-50" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 4</label>
          <input type="text" style="width: 100%;">
        </div><div id="exist-sort-51" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple" ps="no" rq="no">Experiences 5</label>
          <input type="text" style="width: 100%;">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-24" style="border: 2px dashed transparent;"><div id="exist-drop-37" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-52" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h3>Essays</h3>
<p>&nbsp;</p>
<p>Due Date:</p>
<p><strong>Tuesday, December 30, 2014, 11:59 PM.</strong></p>
<p>&nbsp;</p>
<ul>
<li>We recommend that, instead of composing your essay directly in the web browser, you type up your responses in a text editor (such as Notepad, or TextEdit), then highlight the text of each question, select&nbsp;<strong>"Copy"</strong>&nbsp;from the Edit menu, then switch to the browser, and select&nbsp;<strong>"Edit | Paste"</strong>&nbsp;to paste in your responses.</li>
<li>When you cut and paste from a word processor like Microsoft Word and save your changes in the web browser, some of your punctuations may be lost or appear as strange characters in the saved version; this is because Microsoft Word sometimes replaces some punctuation marks, such as ellipsis (...) with special non-standard characters. We recommend against using Microsoft Word. But, if you do draft you responses in a word processor, we recommend that you proof read the text in the web browser and replace the altered punctuation with the correct characters.</li>
<li>Use the TAB key to switch between boxes.</li>
<li>Please skip a line between paragraphs.</li>
<li>You are limited to&nbsp;<strong>250 words</strong>&nbsp;per question. Many supervisors will not read beyond this amount.</li>
</ul>
</div>
        </div><div id="exist-sort-53" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">1. Why do you want to be on house staff. No really, Why? (Be warned, everyone answers this question in the same way -- please take some time to really reflect on your "why").</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-54" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">2. We think that part of the role of a student staff member is to facilitate and enable interesting and engaging conversations among house members. Please chose one of the following two questions with this in mind:  Option 1: Some of the best learning experiences on campus come when students share their intellectual (not necessarily academic) interests with each other. Describe something that you are intellectually excited or passionate about, and give some concrete ideas for how you will engage the residents in this interest.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-55" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Option 2: Tell us about a book, movie or piece of music/art/writing that you were so excited about that you wanted to share it with others. What is the book, movie or piece of music/art/writing, and why is it exciting to you?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-56" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">3. OPTIONAL: If not captured in your responses to previous questions, please use this space to express additional information you feel relevant to your candidacy (feel free to expand on one of the experiences you listed in the short answer questions above).</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-57" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">4. OPTIONAL: As part of the selection process, we ask Residence Deans, Resident Fellows, and Program Associates their perspectives regarding experiences and challenges you may have encountered in your time at Stanford, as these are frequently an opportunity for learning and growth. If you like, take the space below to address any challenges you have faced that may have come to the attention of a Residence Dean, Resident Fellow, or Program Associate.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_system_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ch1 class=\\\"ng-binding\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eHouse Staff Selection\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h1\\u003e\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003e: Application Materials: Application Form\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete all questions in the application form below. Some personal information, such as your name, may be already filled-in for you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease remember to hit \\\"Save\\\" after working in order to avoid losing your work.\\u003c/strong\\u003e For short answer/essay questions, you may want to compose your responses in NotePad, TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003cbr\\u003e \\u003cstrong\\u003e\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp;\\u0026nbsp; \\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 12pt;\\\"\\u003eProfile\\u003c/span\\u003e\\u003cbr\\u003e \\u003cbr\\u003e \\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"First Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":1,\"description\":\"Middle Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":2,\"description\":\"Last Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"SUNetID\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"University ID\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Cell Phone Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":1,\"description\":\"Phone\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Local Address\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"Home Phone Number\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":8,\"column\":0,\"description\":\"Address\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":9,\"column\":0,\"description\":\"Away Spring\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":10,\"column\":0,\"description\":\"Away Winter\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":11,\"column\":0,\"description\":\"Major(s)\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":12,\"column\":0,\"description\":\"OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":13,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ctable width=\\\"70%\\\"\\u003e\\n\\u003ctbody\\u003e\\n\\u003ctr\\u003e\\n\\u003ctd\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease list all the Residences you have lived in on campus, and any positions you held in those residences:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/td\\u003e\\n\\u003c/tr\\u003e\\n\\u003c/tbody\\u003e\\n\\u003c/table\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"House 1\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":14,\"column\":1,\"description\":\"Position 1\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":14,\"column\":2,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e(if applicable)\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":15,\"column\":0,\"description\":\"House 2\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":15,\"column\":1,\"description\":\"Position 2\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":15,\"column\":2,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e(if applicable)\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":16,\"column\":0,\"description\":\"House 3\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":1,\"description\":\"Position 3\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":16,\"column\":2,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e(if applicable)\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":17,\"column\":0,\"description\":\"House 4\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":1,\"description\":\"Position 4\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":17,\"column\":2,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e(if applicable)\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":18,\"column\":0,\"description\":\"Please select which Residential Education student staff position(s) you are applying to:\",\"type\":\"checkbox\",\"options\":[\"Resident Assistant (RA)\",\"\\u003cbr /\\u003e\",\"Kitchen Manager\",\"\\u003cbr /\\u003e\",\"Financial Manager\",\"\\u003cbr /\\u003e\",\"Co-Op Manager\",\"\\u003cbr /\\u003e\",\"Community Manager\",\"\\u003cbr /\\u003e\",\"Academic Theme Associate (ATA)\",\"\\u003cbr /\\u003e\",\"Ethnic Theme Associate (ETA)\",\"\\u003cbr /\\u003e\",\"Focus Assistant (FA)\",\"\\u003cbr /\\u003e\",\"Language and Culture Academic Theme Associate (LCATA)\"],\"rq\":false},{\"row\":19,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease list your projected number of units for each quarter of the 2014-15 academic year:\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":20,\"column\":0,\"description\":\"Fall Quarter\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":20,\"column\":1,\"description\":\"Winter Quarte\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":20,\"column\":2,\"description\":\"Spring Quarter\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":21,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eList your extracurricular activities for the 2014 - 2015 academic year. Include activities such as job searches, graduate school applications/interviews, as well as other extracurriculars (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":21,\"column\":0,\"description\":\"Activity 1\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":21,\"column\":0,\"description\":\"Activity 2\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":21,\"column\":0,\"description\":\"Activity 3\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":21,\"column\":0,\"description\":\"Activity 4\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":21,\"column\":0,\"description\":\"Activity 5\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":22,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eOur residential communities are a place of invaluable intellectual and interpersonal learning, and student staff engagement within our communities plays an integral role in that learning process. List 5 ways in which you have been engaged with your residence(s), involved with Residential Education, and/or engaged with the larger Stanford community. (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":22,\"column\":0,\"description\":\"Involvement 1\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":22,\"column\":0,\"description\":\"Involvement 2\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":22,\"column\":0,\"description\":\"Involvement 3\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":22,\"column\":0,\"description\":\"Involvement 4\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":22,\"column\":0,\"description\":\"Involvement 5\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":23,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003eSome of the best learning experiences come when students share their intellectual interests with each other. List five intellectual interests of yours (Please limit your responses to 25 words or fewer).\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":23,\"column\":0,\"description\":\"Experiences 1\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":23,\"column\":0,\"description\":\"Experiences 2\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":23,\"column\":0,\"description\":\"Experiences 3\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":23,\"column\":0,\"description\":\"Experiences 4\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":23,\"column\":0,\"description\":\"Experiences 5\",\"type\":\"text\",\"ps\":false,\"rq\":false},{\"row\":24,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eEssays\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003eDue Date:\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003eTuesday, December 30, 2014, 11:59 PM.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cul\\u003e\\n\\u003cli\\u003eWe recommend that, instead of composing your essay directly in the web browser, you type up your responses in a text editor (such as Notepad, or TextEdit), then highlight the text of each question, select\\u0026nbsp;\\u003cstrong\\u003e\\\"Copy\\\"\\u003c/strong\\u003e\\u0026nbsp;from the Edit menu, then switch to the browser, and select\\u0026nbsp;\\u003cstrong\\u003e\\\"Edit | Paste\\\"\\u003c/strong\\u003e\\u0026nbsp;to paste in your responses.\\u003c/li\\u003e\\n\\u003cli\\u003eWhen you cut and paste from a word processor like Microsoft Word and save your changes in the web browser, some of your punctuations may be lost or appear as strange characters in the saved version; this is because Microsoft Word sometimes replaces some punctuation marks, such as ellipsis (...) with special non-standard characters. We recommend against using Microsoft Word. But, if you do draft you responses in a word processor, we recommend that you proof read the text in the web browser and replace the altered punctuation with the correct characters.\\u003c/li\\u003e\\n\\u003cli\\u003eUse the TAB key to switch between boxes.\\u003c/li\\u003e\\n\\u003cli\\u003ePlease skip a line between paragraphs.\\u003c/li\\u003e\\n\\u003cli\\u003eYou are limited to\\u0026nbsp;\\u003cstrong\\u003e250 words\\u003c/strong\\u003e\\u0026nbsp;per question. Many supervisors will not read beyond this amount.\\u003c/li\\u003e\\n\\u003c/ul\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":24,\"column\":0,\"description\":\"1. Why do you want to be on house staff. No really, Why? (Be warned, everyone answers this question in the same way -- please take some time to really reflect on your \\\"why\\\").\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":24,\"column\":0,\"description\":\"2. We think that part of the role of a student staff member is to facilitate and enable interesting and engaging conversations among house members. Please chose one of the following two questions with this in mind:  Option 1: Some of the best learning experiences on campus come when students share their intellectual (not necessarily academic) interests with each other. Describe something that you are intellectually excited or passionate about, and give some concrete ideas for how you will engage the residents in this interest.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":24,\"column\":0,\"description\":\"Option 2: Tell us about a book, movie or piece of music/art/writing that you were so excited about that you wanted to share it with others. What is the book, movie or piece of music/art/writing, and why is it exciting to you?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":24,\"column\":0,\"description\":\"3. OPTIONAL: If not captured in your responses to previous questions, please use this space to express additional information you feel relevant to your candidacy (feel free to expand on one of the experiences you listed in the short answer questions above).\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":24,\"column\":0,\"description\":\"4. OPTIONAL: As part of the selection process, we ask Residence Deans, Resident Fellows, and Program Associates their perspectives regarding experiences and challenges you may have encountered in your time at Stanford, as these are frequently an opportunity for learning and growth. If you like, take the space below to address any challenges you have faced that may have come to the attention of a Residence Dean, Resident Fellow, or Program Associate.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_interview_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<h2 style="text-align: center;"><strong>Interview Review Form for&nbsp;HSS</strong></h2>
<p>&nbsp;</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2>
<p><span style="color: #000000;"><strong>RECOMMENDATION:</strong></span></p>
</div>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Row:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Upperclass:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Four Class:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Freshmen:</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Strongly recommend</span></label><label class="radio"><input type="radio" value="option0-1"><span>Recommend</span></label><label class="radio"><input type="radio" value="option0-2"><span>Recommend with reservations</span></label><label class="radio"><input type="radio" value="option0-3"><span>Do not recommend</span></label><label class="radio"><input type="radio" value="option0-4"><span>N/A</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Describe the applicant's understanding of the this role and responsibilities.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" rq="no" ps="no">Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Additional comments, including any potential conflicts with the position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h2 style="text-align: left;"><span style="color: #ff0000;"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2></div>
        </div></div></div>
EOF

hss_interview_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eInterview Review Form for\\u0026nbsp;HSS\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cspan style=\\\"color: #000000;\\\"\\u003e\\u003cstrong\\u003eRECOMMENDATION:\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Row:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Upperclass:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Four Class:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Freshmen:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Describe the applicant's understanding of the this role and responsibilities.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Assess the applicant's ability as this role, including relevant knowledge, teaching and resident interactions.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Additional comments, including any potential conflicts with the position.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\",\"type\":\"description\"}]"

hss_recommendation_form_1 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p style="text-align: left;"><strong><span style="font-size: 14pt;">RA/Manager/Theme and Focus Assistant: New Applicant Recommendation Form</span></strong><br> <br> To the Recommender<br> <br> Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.</p>
<p>Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Please complete the recommendation form by using the form below.</strong></p>
<p><strong>&nbsp;</strong></p>
<p>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<h3>To officially submit your recommendation, hit "Submit." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. </h3>
<p>Recommendation Questions</p>
<p>Please respond to the following questions.</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">How well do you know the applicant you are recommending?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Very Well</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>Pretty Well</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option2-0"><span>Not Well</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Respect For Others</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option8-0"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option9-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">In no more than 250 words, please comment on the applicant's personal qualities in relation to the RA's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_recommendation_form_schema_1 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp style=\\\"text-align: left;\\\"\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eRA/Manager/Theme and Focus Assistant: New Applicant Recommendation Form\\u003c/span\\u003e\\u003c/strong\\u003e\\u003cbr\\u003e \\u003cbr\\u003e To the Recommender\\u003cbr\\u003e \\u003cbr\\u003e Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.\\u003c/p\\u003e\\n\\u003cp\\u003eBecause current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch3\\u003eTo officially submit your recommendation, hit \\\"Submit.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. \\u003c/h3\\u003e\\n\\u003cp\\u003eRecommendation Questions\\u003c/p\\u003e\\n\\u003cp\\u003ePlease respond to the following questions.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"How well do you know the applicant you are recommending?\",\"type\":\"radio\",\"options\":[\"Very Well\",\"\\u003cbr /\\u003e\",\"Pretty Well\",\"\\u003cbr /\\u003e\",\"Not Well\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"\\u003cbr /\\u003e\",\"Respect For Others\",\"\\u003cbr /\\u003e\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to the RA's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_recommendation_form_2 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><span style="font-size: 14pt;"><strong>RA/Manager/Theme and Focus Assistant: Re-applicant Recommendation Form #1 (to be completed by your RF/CD/Supervisor)</strong></span><br> <br> To the Recommender<br> <br> Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.</p>
<p>Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Please complete the recommendation form by using the form below.</strong></p>
<p><strong>&nbsp;</strong></p>
<p>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<h3>To officially submit your recommendation, hit "Submit." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. <br> </h3>
<h3>Recommendation Questions</h3>
<p>This applicant has applied for reappointment to the student residence staff.</p>
<p>For reappointment to the same house or for consideration for appointment to other houses, a reapplicant must have the recommendation of his/her Resident Fellow or Director. Resident Fellows/College Director/Row Director will be the only residence staff allowed to read this evaluation.</p>
<p>Please complete these questions evaluating the candidate's performance as a student staff member this past year.</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label><label class="checkbox"><input type="checkbox" value="option6-1"><span>Respect For Others</span></label><label class="checkbox"><input type="checkbox" value="option6-2"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rate the candidate's position performance in the following areas:</p>
        </div><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Promoting intellectual life, including programming</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Counseling/Advising (dealing with difficult situations)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-12" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Community Building (including promoting cross-cultural interaction and understanding)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Availability and approachability</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Working with others in the house and on the staff team</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">What noteworthy contributions has the candidate made to the house?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Indicate any areas of position performance that needed improvement during the year. How did the candidate respond to constructive criticism? What changes resulted?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Would you support another decision to rehire this candidate?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Please explain your response. What reservations, if any, would you have about rehiring this candidate? If you would like to comment on your responses to questions 1 through 4, please do so here.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_recommendation_form_schema_2 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eRA/Manager/Theme and Focus Assistant: Re-applicant Recommendation Form #1 (to be completed by your RF/CD/Supervisor)\\u003c/strong\\u003e\\u003c/span\\u003e\\u003cbr\\u003e \\u003cbr\\u003e To the Recommender\\u003cbr\\u003e \\u003cbr\\u003e Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.\\u003c/p\\u003e\\n\\u003cp\\u003eBecause current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch3\\u003eTo officially submit your recommendation, hit \\\"Submit.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. \\u003cbr\\u003e \\u003c/h3\\u003e\\n\\u003ch3\\u003eRecommendation Questions\\u003c/h3\\u003e\\n\\u003cp\\u003eThis applicant has applied for reappointment to the student residence staff.\\u003c/p\\u003e\\n\\u003cp\\u003eFor reappointment to the same house or for consideration for appointment to other houses, a reapplicant must have the recommendation of his/her Resident Fellow or Director. Resident Fellows/College Director/Row Director will be the only residence staff allowed to read this evaluation.\\u003c/p\\u003e\\n\\u003cp\\u003ePlease complete these questions evaluating the candidate's performance as a student staff member this past year.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"Respect For Others\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Please rate the candidate's position performance in the following areas:\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"Promoting intellectual life, including programming\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Counseling/Advising (dealing with difficult situations)\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Community Building (including promoting cross-cultural interaction and understanding)\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Availability and approachability\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"Working with others in the house and on the staff team\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"],\"rq\":false},{\"row\":4,\"column\":0,\"description\":\"What noteworthy contributions has the candidate made to the house?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":5,\"column\":0,\"description\":\"Indicate any areas of position performance that needed improvement during the year. How did the candidate respond to constructive criticism? What changes resulted?\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":6,\"column\":0,\"description\":\"Would you support another decision to rehire this candidate?\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"],\"rq\":false},{\"row\":7,\"column\":0,\"description\":\"Please explain your response. What reservations, if any, would you have about rehiring this candidate? If you would like to comment on your responses to questions 1 through 4, please do so here.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_recommendation_form_3 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><span style="font-size: 14pt;"><strong>RA/Manager/Theme and Focus Assistant: Re-applicant Recommendation Form #2 (to be completed by a co-staff member or a resident)</strong></span><br> <br> To the Recommender<br> <br> Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.</p>
<p>Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p><strong>&nbsp;</strong></p>
<p><strong>Please complete the recommendation form by using the form below.</strong></p>
<p><strong>&nbsp;</strong></p>
<p>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<h3>To officially submit your recommendation, hit "Submit." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.</h3>
<h3>&nbsp;</h3>
<h3>Recommendation Questions</h3>
<p>Please respond to the following questions.</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Relationship to the applicant (please check one):</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Co-staff Member</span></label><label class="radio"><input type="radio" value="option0-1"><span>Resident</span></label></div></div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">How well do you know the applicant?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Very well</span></label><label class="radio"><input type="radio" value="option0-1"><span>Pretty well</span></label><label class="radio"><input type="radio" value="option0-2"><span>Not well</span></label></div></div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label><label class="checkbox"><input type="checkbox" value="option6-1"><span>Respect For Others</span></label><label class="checkbox"><input type="checkbox" value="option6-2"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">In no more than 250 words, please comment on the applicant's personal qualities in relation to a student staff member's responsibilities in the residences. Please include references to their performance as a student staff member during the year. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_recommendation_form_schema_3 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003eRA/Manager/Theme and Focus Assistant: Re-applicant Recommendation Form #2 (to be completed by a co-staff member or a resident)\\u003c/strong\\u003e\\u003c/span\\u003e\\u003cbr\\u003e \\u003cbr\\u003e To the Recommender\\u003cbr\\u003e \\u003cbr\\u003e Residential Education Student Staff are undergraduate students who live in University residences and help cultivate learning environments that contribute to residents' academic progress and success and personal growth, and to the building of healthy and vital communities. Residential Education Student Staff work as members of a staff team. Specifically, Residential Education Student Staff are expected to promote the intellectual life of the house; to create opportunities for students to clarify their interests, values, and attitudes; to provide personal and academic counseling and referral; to know and explain University policies; to be available to students; and to guide residents in assuming responsibility for their personal and communal lives.\\u003c/p\\u003e\\n\\u003cp\\u003eBecause current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch3\\u003eTo officially submit your recommendation, hit \\\"Submit.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.\\u003c/h3\\u003e\\n\\u003ch3\\u003e\\u0026nbsp;\\u003c/h3\\u003e\\n\\u003ch3\\u003eRecommendation Questions\\u003c/h3\\u003e\\n\\u003cp\\u003ePlease respond to the following questions.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Relationship to the applicant (please check one):\",\"type\":\"radio\",\"options\":[\"Co-staff Member\",\"Resident\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"How well do you know the applicant?\",\"type\":\"radio\",\"options\":[\"Very well\",\"Pretty well\",\"Not well\"],\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"Respect For Others\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"],\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":2,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"],\"rq\":false},{\"row\":3,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to a student staff member's responsibilities in the residences. Please include references to their performance as a student staff member during the year. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_recommendation_form_4 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><span style="font-size: 14pt;"><strong>Peer Health Educator (PHE): PHE Recommendations</strong> </span><br> <br> To the Recommender</p>
<p><br> Peer Health Educators (PHEs) are residential staff specialists who actively promote and support student health, wellness and safety.</p>
<p>PHEs are affiliates of Health Promotion Services (HPS) at the Vaden Health Center. They are co-supervised by HPS and their Resident Fellows. HPS provides education, supervision and intensive training to PHEs. For more information, visit the PHE description at http://studentaffairs.stanfordtest.edu/resed/studentstaffjobs/phe</p>
<p>Because Health Promotion Services staff rely heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p><strong>&nbsp;</strong><strong>&nbsp;</strong><strong>Please complete the recommendation form by using the form below.</strong><strong>&nbsp;</strong></p>
<p>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<h3>To officially submit your recommendation, hit "Submit." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.</h3>
<h3><br> Recommendation Questions</h3>
<p>Please respond to the following questions.</p>
</div>
        </div><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly list the candidate's strengths.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly discuss the areas in which the candidate might improve.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">In no more than 250 words, please comment on the applicant's personal qualities in relation to Peer Health Educators responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: serve as a role model for healthy living, maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_recommendation_form_schema_4 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003e\\u003cstrong\\u003ePeer Health Educator (PHE): PHE Recommendations\\u003c/strong\\u003e \\u003c/span\\u003e\\u003cbr\\u003e \\u003cbr\\u003e To the Recommender\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cbr\\u003e Peer Health Educators (PHEs) are residential staff specialists who actively promote and support student health, wellness and safety.\\u003c/p\\u003e\\n\\u003cp\\u003ePHEs are affiliates of Health Promotion Services (HPS) at the Vaden Health Center. They are co-supervised by HPS and their Resident Fellows. HPS provides education, supervision and intensive training to PHEs. For more information, visit the PHE description at http://studentaffairs.stanfordtest.edu/resed/studentstaffjobs/phe\\u003c/p\\u003e\\n\\u003cp\\u003eBecause Health Promotion Services staff rely heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch3\\u003eTo officially submit your recommendation, hit \\\"Submit.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email.\\u003c/h3\\u003e\\n\\u003ch3\\u003e\\u003cbr\\u003e Recommendation Questions\\u003c/h3\\u003e\\n\\u003cp\\u003ePlease respond to the following questions.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Briefly list the candidate's strengths.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Briefly discuss the areas in which the candidate might improve.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to Peer Health Educators responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: serve as a role model for healthy living, maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

hss_recommendation_form_5 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description" rq="no">
<p><strong><span style="font-size: 14pt;">Dorm and Row Process (RCC): Recommendation Form</span></strong><br> <br> To the Recommender<br> <br> RCCs are undergraduate and graduate students who live in University residences and educate residents on all aspects of computing at Stanford, consult with residents on computer related problems, and support in-room network connections. RCCs usually work as members of a staff team. Most importantly, RCCs are expected to be available to residents. RCCs work primarily with the residence staff, their designated Residential Computer Cluster Technician, Networking and Communications Services, and the Residential Computing central support staff to accomplish their goals. For more information, visit the RCC Job Description at http://rescomp.stanfordtest.edu/about/jobs/rcc/.</p>
<p>&nbsp;</p>
<p>Because current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.</p>
<p>&nbsp;<strong>Please complete the recommendation form by using the form below.</strong></p>
<p><strong>&nbsp;</strong>You may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.</p>
<h3>To officially submit your recommendation, hit "Submit." You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. <br> </h3>
<h3>Recommendation Questions</h3>
<p>Please respond to the following questions.</p>
</div>
        </div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly list the candidate's strengths.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">Briefly discuss the areas in which the candidate might improve.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area" ps="no" rq="no">In no more than 250 words, please comment on the applicant's personal qualities in relation to the RCC's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

hss_recommendation_form_schema_5 = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u003cspan style=\\\"font-size: 14pt;\\\"\\u003eDorm and Row Process (RCC): Recommendation Form\\u003c/span\\u003e\\u003c/strong\\u003e\\u003cbr\\u003e \\u003cbr\\u003e To the Recommender\\u003cbr\\u003e \\u003cbr\\u003e RCCs are undergraduate and graduate students who live in University residences and educate residents on all aspects of computing at Stanford, consult with residents on computer related problems, and support in-room network connections. RCCs usually work as members of a staff team. Most importantly, RCCs are expected to be available to residents. RCCs work primarily with the residence staff, their designated Residential Computer Cluster Technician, Networking and Communications Services, and the Residential Computing central support staff to accomplish their goals. For more information, visit the RCC Job Description at http://rescomp.stanfordtest.edu/about/jobs/rcc/.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003eBecause current residence staff members who are taking part in the selection process rely so heavily upon the recommendations, it is important that you respond to the questions thoughtfully and realistically. Thank you.\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003cstrong\\u003ePlease complete the recommendation form by using the form below.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003eYou may want to compose your responses in NotePad or TextEdit, or some other text editing program and then cut and paste your responses into the appropriate text boxes.\\u003c/p\\u003e\\n\\u003ch3\\u003eTo officially submit your recommendation, hit \\\"Submit.\\\" You may still revise the recommendation form after you submitted it. However, please remember you are no longer able to make changes after the deadline stated in the email. \\u003cbr\\u003e \\u003c/h3\\u003e\\n\\u003ch3\\u003eRecommendation Questions\\u003c/h3\\u003e\\n\\u003cp\\u003ePlease respond to the following questions.\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Briefly list the candidate's strengths.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"Briefly discuss the areas in which the candidate might improve.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false},{\"row\":0,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to the RCC's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to refer to some or all of the following characteristics: maturity (reliability, good judgment, defined personal and academic interests); energy and creativity (demonstrated initiative in academic and extracurricular areas, intellectual curiosity, ability to generate enthusiasm in others); organizational ability (ability to initiate and follow through on projects, ability to involve others in projects); leadership skills (willingness to exercise authority, ability to delegate tasks and manage time effectively); openness to others of different backgrounds; approachability.\",\"type\":\"textarea\",\"ps\":false,\"rq\":false}]"

default_application_form = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>Personal Information</h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Name:</label>
          <input type="text">
        </div></div><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Preferred Name:</label>
          <input type="text">
        </div></div><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">SUID:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Gender:</label>
          <input type="text">
        </div></div><div id="exist-drop-6" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-5" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Ethnicity:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-6" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Email:</label>
          <input type="text">
        </div></div><div id="exist-drop-8" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-7" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Cell Phone (if any):</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-9" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Citizenship/Visa Status:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-10" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Campus residence:</label>
          <input type="text">
        </div></div><div id="exist-drop-11" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Room:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-12" class="drop-block ui-droppable ui-sortable col-lg-6" style="border: 2px dashed transparent;"><div id="exist-sort-11" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Campus Phone:</label>
          <input type="text">
        </div></div><div id="exist-drop-13" class="drop-block col-lg-6 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-12" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Department/Academic Major(s):</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-8" style="border: 2px dashed transparent;"><div id="exist-drop-14" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-13" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Current Mailing Address:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-9" style="border: 2px dashed transparent;"><div id="exist-drop-15" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Year in school:</label>
          <input type="text">
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-10" style="border: 2px dashed transparent;"><div id="exist-drop-16" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<p>&nbsp;</p>
<table border="0" width="100%" cellspacing="5" cellpadding="5">
<tbody>
<tr>
<td colspan="4" valign="top">
<p><strong>OPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.</strong></p>
</td>
</tr>
<tr>
<td colspan="4" valign="top">&nbsp;</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-11" style="border: 2px dashed transparent;"><div id="exist-drop-17" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>Photo (COMPLETELY OPTIONAL)</h3>
<p><strong>Please provide a photo of yourself. If you choose to provide one, please insure that the photo be&nbsp;<span style="text-decoration: underline;">250 pixels by 250 pixels</span>&nbsp;and a clear headshot of yourself. It should look similar to a passport photo.</strong>&nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename.)</p>
<p>&nbsp;</p>
<div id="photo">&nbsp;</div>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-12" style="border: 2px dashed transparent;"><div id="exist-drop-18" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>Applicant Profile</h3>
</div>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-13" style="border: 2px dashed transparent;"><div id="exist-drop-19" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-18" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">1. Have you been an RCC before?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-19" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">2. Have you previously applied for the RCC position?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-20" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">3. Select your status for the next academic year (not the current year):</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-21" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">4. CS196 is a requirement for the Undergraduate RCC position and attendance on the first day of class is required. A waiver request is also available on the first day of class. Please describe your CS196 status:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-22" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">5.Quarter and year you took or will take CS196:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-23" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">6. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-24" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">7. What are your hobbies and interests?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-25" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">8. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment as ResComp RCC?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-26" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">9. Do you acknowledge that you will be available on campus for training and opening begining early September 2014?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-27" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">10. Do you plan to be abroad during the hiring process? (Being abroad does not effect your eligibility, but useful for us to know for scheduling purposes).</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-28" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">11. How did you hear about the position (check all that apply):</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-29" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>FOR ALL APPLICANTS</h3>
</div>
        </div><div id="exist-sort-30" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">12. What personal qualities do you have that would be particularly helpful as a member of house staff/team?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-31" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">13. Give examples of how you've worked well in a team.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-32" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">14. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-33" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">15. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-34" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">16. Who is someone you look up to and explain why he/she is an exemplar for you.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-14" style="border: 2px dashed transparent;"><div id="exist-drop-20" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-35" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">17. Please explain your process for troubleshooting problems you've never seen before.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-36" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">18. Please tell us why we should hire you. Be creative.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-37" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>FOR NEW RCC APPLICANTS OR FORMER RCCS REAPPLYING ONLY</h3>
</div>
        </div><div id="exist-sort-38" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">19. List any tutoring, teaching, or consulting experience that you have had during your academic career.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-39" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">20. Please tell us about a time you taught someone something and what about it made you proud.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-40" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">21. Please describe your experience that you feel qualifies you for the RCC position.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-41" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>FOR CURRENT RCCS REAPPLYING ONLY</h3>
</div>
        </div><div id="exist-sort-42" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">22. Please share what you have accomplished as an RCC this year so far.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-43" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">23. What have you contributed to the greater RCC and ResComp community this year? What do you hope to contribute next year?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-44" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">24. Please provide a reference:</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div><div id="exist-sort-45" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Name:</label>
          <input type="text">
        </div><div id="exist-sort-46" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Title:</label>
          <input type="text">
        </div><div id="exist-sort-47" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Relationship:</label>
          <input type="text">
        </div><div id="exist-sort-48" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Phone:</label>
          <input type="text">
        </div><div id="exist-sort-49" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="simple">Email:</label>
          <input type="text">
        </div><div id="exist-sort-50" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;">
          <div class="description">
<h3>&nbsp;</h3>
<p><strong>In the event that I am not matched with a residence after preferences have been submitted, please keep my application on file for the following type of residences. You may select as many as you like.</strong></p>
<h3>&nbsp;</h3>
</div>
        </div><div id="exist-sort-51" class="sort-item ui-sortable-handle" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Checkbox button</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>All freshman residences in the dorms</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Four class residences in the dorms</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Upper class residences in the dorms</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Upper class residences on the Row</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Apartment style residences in the dorms</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Any self-op</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Any co-op</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Any Stanford residence</span></label></div></div></div></div>
EOF

default_application_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003ePersonal Information\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":1,\"column\":0,\"description\":\"Name:\",\"type\":\"text\",\"ps\":false},{\"row\":2,\"column\":0,\"description\":\"Preferred Name:\",\"type\":\"text\",\"ps\":false},{\"row\":2,\"column\":1,\"description\":\"SUID:\",\"type\":\"text\",\"ps\":false},{\"row\":3,\"column\":0,\"description\":\"Gender:\",\"type\":\"text\",\"ps\":false},{\"row\":3,\"column\":1,\"description\":\"Ethnicity:\",\"type\":\"text\",\"ps\":false},{\"row\":4,\"column\":0,\"description\":\"Email:\",\"type\":\"text\",\"ps\":false},{\"row\":4,\"column\":1,\"description\":\"Cell Phone (if any):\",\"type\":\"text\",\"ps\":false},{\"row\":5,\"column\":0,\"description\":\"Citizenship/Visa Status:\",\"type\":\"text\",\"ps\":false},{\"row\":6,\"column\":0,\"description\":\"Campus residence:\",\"type\":\"text\",\"ps\":false},{\"row\":6,\"column\":1,\"description\":\"Room:\",\"type\":\"text\",\"ps\":false},{\"row\":7,\"column\":0,\"description\":\"Campus Phone:\",\"type\":\"text\",\"ps\":false},{\"row\":7,\"column\":1,\"description\":\"Department/Academic Major(s):\",\"type\":\"text\",\"ps\":false},{\"row\":8,\"column\":0,\"description\":\"Current Mailing Address:\",\"type\":\"text\",\"ps\":false},{\"row\":9,\"column\":0,\"description\":\"Year in school:\",\"type\":\"text\",\"ps\":false},{\"row\":10,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003ctable border=\\\"0\\\" width=\\\"100%\\\" cellspacing=\\\"5\\\" cellpadding=\\\"5\\\"\\u003e\\n\\u003ctbody\\u003e\\n\\u003ctr\\u003e\\n\\u003ctd colspan=\\\"4\\\" valign=\\\"top\\\"\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003eOPTIONAL: Completing this application process begins a conditional candidate status in the selection process. Your conditional status becomes official once we have consulted with the following offices: Residential Education, Office of the Registrar, University Housing, Undergraduate Advising and Research, and the Office of Community Standards. These offices will share information (e.g. year.s of guaranteed housing, university transcripts, academic status) that is pertinent to you moving forward as an official candidate. If you believe that there might be information of concern from any of these offices please include a note below, or reach out to us via selection@lists.stanfordtest.edu and someone will contact you as soon as possible.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003c/td\\u003e\\n\\u003c/tr\\u003e\\n\\u003ctr\\u003e\\n\\u003ctd colspan=\\\"4\\\" valign=\\\"top\\\"\\u003e\\u0026nbsp;\\u003c/td\\u003e\\n\\u003c/tr\\u003e\\n\\u003c/tbody\\u003e\\n\\u003c/table\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\",\"type\":\"description\"},{\"row\":11,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003ePhoto (COMPLETELY OPTIONAL)\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003ePlease provide a photo of yourself. If you choose to provide one, please insure that the photo be\\u0026nbsp;\\u003cspan style=\\\"text-decoration: underline;\\\"\\u003e250 pixels by 250 pixels\\u003c/span\\u003e\\u0026nbsp;and a clear headshot of yourself. It should look similar to a passport photo.\\u003c/strong\\u003e\\u0026nbsp;(please limit the file size to less than 1 MB and do not include any spaces, apostrophes, quotation marks, or other special characters in the filename.)\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cdiv id=\\\"photo\\\"\\u003e\\u0026nbsp;\\u003c/div\\u003e\",\"type\":\"description\"},{\"row\":12,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eApplicant Profile\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":13,\"column\":0,\"description\":\"1. Have you been an RCC before?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"2. Have you previously applied for the RCC position?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"3. Select your status for the next academic year (not the current year):\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"4. CS196 is a requirement for the Undergraduate RCC position and attendance on the first day of class is required. A waiver request is also available on the first day of class. Please describe your CS196 status:\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"5.Quarter and year you took or will take CS196:\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"6. Will you be a registered student and remain in on-campus housing for all three quarters during the 2014-2015 academic year?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"7. What are your hobbies and interests?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"8. Do you acknowledge that the ResComp RCC Orientation, held in early Spring Quarter, is a mandatory event and condition of employment as ResComp RCC?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"9. Do you acknowledge that you will be available on campus for training and opening begining early September 2014?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"10. Do you plan to be abroad during the hiring process? (Being abroad does not effect your eligibility, but useful for us to know for scheduling purposes).\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"11. How did you hear about the position (check all that apply):\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eFOR ALL APPLICANTS\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":13,\"column\":0,\"description\":\"12. What personal qualities do you have that would be particularly helpful as a member of house staff/team?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"13. Give examples of how you've worked well in a team.\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"14. List your academic commitments for the next year. Include number of units, incompletes, honors, research, etc.\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"15. What do you hope to accomplish as an RCC next year? How do you plan to achieve your goals?\",\"type\":\"textarea\",\"ps\":false},{\"row\":13,\"column\":0,\"description\":\"16. Who is someone you look up to and explain why he/she is an exemplar for you.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"17. Please explain your process for troubleshooting problems you've never seen before.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"18. Please tell us why we should hire you. Be creative.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eFOR NEW RCC APPLICANTS OR FORMER RCCS REAPPLYING ONLY\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"19. List any tutoring, teaching, or consulting experience that you have had during your academic career.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"20. Please tell us about a time you taught someone something and what about it made you proud.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"21. Please describe your experience that you feel qualifies you for the RCC position.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003eFOR CURRENT RCCS REAPPLYING ONLY\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"22. Please share what you have accomplished as an RCC this year so far.\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"23. What have you contributed to the greater RCC and ResComp community this year? What do you hope to contribute next year?\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"24. Please provide a reference:\",\"type\":\"textarea\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"Name:\",\"type\":\"text\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"Title:\",\"type\":\"text\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"Relationship:\",\"type\":\"text\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"Phone:\",\"type\":\"text\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"Email:\",\"type\":\"text\",\"ps\":false},{\"row\":14,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch3\\u003e\\u0026nbsp;\\u003c/h3\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003eIn the event that I am not matched with a residence after preferences have been submitted, please keep my application on file for the following type of residences. You may select as many as you like.\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003ch3\\u003e\\u0026nbsp;\\u003c/h3\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":14,\"column\":0,\"description\":\"Checkbox button\",\"type\":\"checkbox\",\"options\":[\"All freshman residences in the dorms\",\"\\u003cbr /\\u003e\",\"Four class residences in the dorms\",\"\\u003cbr /\\u003e\",\"Upper class residences in the dorms\",\"\\u003cbr /\\u003e\",\"Upper class residences on the Row\",\"\\u003cbr /\\u003e\",\"Apartment style residences in the dorms\",\"\\u003cbr /\\u003e\",\"Any self-op\",\"\\u003cbr /\\u003e\",\"Any co-op\",\"\\u003cbr /\\u003e\",\"Any Stanford residence\"]}]"

default_recommendation_form_1 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">How well do you know the applicant you are recommending?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Very Well</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option1-0"><span>Pretty Well</span></label></div><div class="normal-height"><label class="radio"><input type="radio" value="option2-0"><span>Not Well</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Respect For Others</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option8-0"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option9-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">In no more than 250 words, please comment on the applicant's personal qualities in relation to the RA's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

default_recommendation_form_schema_1 = "[{\"row\":0,\"column\":0,\"description\":\"How well do you know the applicant you are recommending?\",\"type\":\"radio\",\"options\":[\"Very Well\",\"\\u003cbr /\\u003e\",\"Pretty Well\",\"\\u003cbr /\\u003e\",\"Not Well\"]},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"\\u003cbr /\\u003e\",\"Respect For Others\",\"\\u003cbr /\\u003e\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"]},{\"row\":2,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"]},{\"row\":3,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":4,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to the RA's responsibilities in the residences. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.\",\"type\":\"textarea\"}]"
default_recommendation_form_2 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label><label class="checkbox"><input type="checkbox" value="option6-1"><span>Respect For Others</span></label><label class="checkbox"><input type="checkbox" value="option6-2"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rate the candidate's position performance in the following areas:</p>
        </div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Promoting intellectual life, including programming</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Counseling/Advising (dealing with difficult situations)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-11" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Community Building (including promoting cross-cultural interaction and understanding)</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-12" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Availability and approachability</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div><div id="exist-sort-13" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Working with others in the house and on the staff team</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Needs significant improvement</span></label><label class="radio"><input type="radio" value="option0-1"><span>Below Average</span></label><label class="radio"><input type="radio" value="option0-2"><span>Meets standards</span></label><label class="radio"><input type="radio" value="option0-3"><span>Above Average</span></label><label class="radio"><input type="radio" value="option0-4"><span>Very Strong (Top 5%)</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-4" style="border: 2px dashed transparent;"><div id="exist-drop-4" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-14" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">What noteworthy contributions has the candidate made to the house?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-5" style="border: 2px dashed transparent;"><div id="exist-drop-5" class="drop-block ui-droppable ui-sortable col-lg-12" style="border: 2px dashed transparent;"><div id="exist-sort-15" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Indicate any areas of position performance that needed improvement during the year. How did the candidate respond to constructive criticism? What changes resulted?</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div><div class="col-lg-12 row-in-form" id="exist-row-6" style="border: 2px dashed transparent;"><div id="exist-drop-6" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-16" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Would you support another decision to rehire this candidate?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Yes</span></label><label class="radio"><input type="radio" value="option0-1"><span>No</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-7" style="border: 2px dashed transparent;"><div id="exist-drop-7" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-17" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">Please explain your response. What reservations, if any, would you have about rehiring this candidate? If you would like to comment on your responses to questions 1 through 4, please do so here.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

default_recommendation_form_schema_2 =  "[{\"row\":0,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"Respect For Others\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"]},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"]},{\"row\":2,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"Please rate the candidate's position performance in the following areas:\",\"type\":\"description\"},{\"row\":3,\"column\":0,\"description\":\"Promoting intellectual life, including programming\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"]},{\"row\":3,\"column\":0,\"description\":\"Counseling/Advising (dealing with difficult situations)\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"]},{\"row\":3,\"column\":0,\"description\":\"Community Building (including promoting cross-cultural interaction and understanding)\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"]},{\"row\":3,\"column\":0,\"description\":\"Availability and approachability\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top5%)\"]},{\"row\":3,\"column\":0,\"description\":\"Working with others in the house and on the staff team\",\"type\":\"radio\",\"options\":[\"Needs significant improvement\",\"Below Average\",\"Meets standards\",\"Above Average\",\"Very Strong (Top 5%)\"]},{\"row\":4,\"column\":0,\"description\":\"What noteworthy contributions has the candidate made to the house?\",\"type\":\"textarea\"},{\"row\":5,\"column\":0,\"description\":\"Indicate any areas of position performance that needed improvement during the year. How did the candidate respond to constructive criticism? What changes resulted?\",\"type\":\"textarea\"},{\"row\":6,\"column\":0,\"description\":\"Would you support another decision to rehire this candidate?\",\"type\":\"radio\",\"options\":[\"Yes\",\"No\"]},{\"row\":7,\"column\":0,\"description\":\"Please explain your response. What reservations, if any, would you have about rehiring this candidate? If you would like to comment on your responses to questions 1 through 4, please do so here.\",\"type\":\"textarea\"}]"

default_recommendation_form_3 = <<-EOF
<div class="col-lg-12 row-in-form" id="exist-row-0" style="border: 2px dashed transparent;"><div id="exist-drop-0" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-0" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Relationship to the applicant (please check one):</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Co-staff Member</span></label><label class="radio"><input type="radio" value="option0-1"><span>Resident</span></label></div></div><div id="exist-sort-1" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">How well do you know the applicant?</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>Very well</span></label><label class="radio"><input type="radio" value="option0-1"><span>Pretty well</span></label><label class="radio"><input type="radio" value="option0-2"><span>Not well</span></label></div></div><div id="exist-sort-2" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select no more than five of the candidate's top strengths.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Teamwork</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Intellectual Vitality</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Trustworthiness</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Self-Motivation</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Decision-Making Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Facilitating Interactions</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Responsibility</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Organizational Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Approachability</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Leadership</span></label><label class="checkbox"><input type="checkbox" value="option3-2"><span>Planning Ahead</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option4-0"><span>Counseling Skills</span></label><label class="checkbox"><input type="checkbox" value="option4-1"><span>Common Sense</span></label><label class="checkbox"><input type="checkbox" value="option4-2"><span>Analytical Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option5-0"><span>Sense of Humor</span></label><label class="checkbox"><input type="checkbox" value="option5-1"><span>Flexibility</span></label><label class="checkbox"><input type="checkbox" value="option5-2"><span>Creativity</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option6-0"><span>Tactfulness</span></label><label class="checkbox"><input type="checkbox" value="option6-1"><span>Respect For Others</span></label><label class="checkbox"><input type="checkbox" value="option6-2"><span>Involvement in Dorm</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option7-0"><span>Motivating Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-1" style="border: 2px dashed transparent;"><div id="exist-drop-1" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-3" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Using the list below, please select at least one of the candidate's areas for improvement.</label><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option0-0"><span>Time Management Skills</span></label><label class="checkbox"><input type="checkbox" value="option0-1"><span>Appropriate Behavior</span></label><label class="checkbox"><input type="checkbox" value="option0-2"><span>Dealing with Stress</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option1-0"><span>Confronting Others</span></label><label class="checkbox"><input type="checkbox" value="option1-1"><span>Maturity</span></label><label class="checkbox"><input type="checkbox" value="option1-2"><span>Organization Skills</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option2-0"><span>Compromising</span></label><label class="checkbox"><input type="checkbox" value="option2-1"><span>Following Through</span></label><label class="checkbox"><input type="checkbox" value="option2-2"><span>Setting Boundaries</span></label></div><div class="normal-height"><label class="checkbox"><input type="checkbox" value="option3-0"><span>Using Good Judgment</span></label><label class="checkbox"><input type="checkbox" value="option3-1"><span>Supporting Others</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-2" style="border: 2px dashed transparent;"><div id="exist-drop-2" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-4" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <p class="description">Please rank the candidate on the following scales:</p>
        </div><div id="exist-sort-5" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Detail-Oriented -- Big Picture</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-6" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Idea Producer -- Idea Implementer</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-7" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Calm -- Enthusiastic</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-8" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Takes the Lead -- Provides Support</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div><div id="exist-sort-9" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;"><label class="multiple">Instinctive -- Analytical</label><div class="normal-height"><label class="radio"><input type="radio" value="option0-0"><span>1</span></label><label class="radio"><input type="radio" value="option0-1"><span>2</span></label><label class="radio"><input type="radio" value="option0-2"><span>3</span></label><label class="radio"><input type="radio" value="option0-3"><span>4</span></label><label class="radio"><input type="radio" value="option0-4"><span>5</span></label></div></div></div></div><div class="col-lg-12 row-in-form" id="exist-row-3" style="border: 2px dashed transparent;"><div id="exist-drop-3" class="drop-block col-lg-12 ui-droppable ui-sortable" style="border: 2px dashed transparent;"><div id="exist-sort-10" class="sort-item" data-toggle="modal" style="border: 2px dashed transparent;">
          <label class="text-area">In no more than 250 words, please comment on the applicant's personal qualities in relation to a student staff member's responsibilities in the residences. Please include references to their performance as a student staff member during the year. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.</label>
          <textarea style="width: 100%; min-height: 200px; resize: none;"></textarea>
        </div></div></div>
EOF

default_recommendation_form_schema_3 = "[{\"row\":0,\"column\":0,\"description\":\"Relationship to the applicant (please check one):\",\"type\":\"radio\",\"options\":[\"Co-staff Member\",\"Resident\"]},{\"row\":0,\"column\":0,\"description\":\"How well do you know the applicant?\",\"type\":\"radio\",\"options\":[\"Very well\",\"Pretty well\",\"Not well\"]},{\"row\":0,\"column\":0,\"description\":\"Using the list below, please select no more than five of the candidate's top strengths.\",\"type\":\"checkbox\",\"options\":[\"Teamwork\",\"Maturity\",\"Intellectual Vitality\",\"\\u003cbr /\\u003e\",\"Trustworthiness\",\"Self-Motivation\",\"Decision-Making Skills\",\"\\u003cbr /\\u003e\",\"Facilitating Interactions\",\"Responsibility\",\"Organizational Skills\",\"\\u003cbr /\\u003e\",\"Approachability\",\"Leadership\",\"Planning Ahead\",\"\\u003cbr /\\u003e\",\"Counseling Skills\",\"Common Sense\",\"Analytical Skills\",\"\\u003cbr /\\u003e\",\"Sense of Humor\",\"Flexibility\",\"Creativity\",\"\\u003cbr /\\u003e\",\"Tactfulness\",\"Respect For Others\",\"Involvement in Dorm\",\"\\u003cbr /\\u003e\",\"Motivating Others\"]},{\"row\":1,\"column\":0,\"description\":\"Using the list below, please select at least one of the candidate's areas for improvement.\",\"type\":\"checkbox\",\"options\":[\"Time Management Skills\",\"Appropriate Behavior\",\"Dealing with Stress\",\"\\u003cbr /\\u003e\",\"Confronting Others\",\"Maturity\",\"Organization Skills\",\"\\u003cbr /\\u003e\",\"Compromising\",\"Following Through\",\"Setting Boundaries\",\"\\u003cbr /\\u003e\",\"Using Good Judgment\",\"Supporting Others\"]},{\"row\":2,\"column\":0,\"description\":\"Please rank the candidate on the following scales:\",\"type\":\"description\"},{\"row\":2,\"column\":0,\"description\":\"Detail-Oriented -- Big Picture\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Idea Producer -- Idea Implementer\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Calm -- Enthusiastic\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Takes the Lead -- Provides Support\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":2,\"column\":0,\"description\":\"Instinctive -- Analytical\",\"type\":\"radio\",\"options\":[\"1\",\"2\",\"3\",\"4\",\"5\"]},{\"row\":3,\"column\":0,\"description\":\"In no more than 250 words, please comment on the applicant's personal qualities in relation to a student staff member's responsibilities in the residences. Please include references to their performance as a student staff member during the year. Recommendations which best serve the candidate include specific examples and describe the person in realistic terms. You may want to explain the reasoning for your answers in the previous three questions. Please explain what makes this applicant special and/or explain any reservations you may have about the applicant.\",\"type\":\"textarea\"}]"

interview_form1_schema = "[{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: center;\\\"\\u003e\\u003cstrong\\u003eInterview Review Form for \\u003cspan style=\\\"color: #ff6600;\\\"\\u003eRCC\\u003c/span\\u003e\\u003c/strong\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u003cspan style=\\\"color: #000000;\\\"\\u003e\\u003cstrong\\u003eRECOMMENDATION:\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"},{\"row\":0,\"column\":0,\"description\":\"Row:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"]},{\"row\":0,\"column\":0,\"description\":\"Upperclass:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"]},{\"row\":0,\"column\":0,\"description\":\"Four Class:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"]},{\"row\":0,\"column\":0,\"description\":\"Freshmen:\",\"type\":\"radio\",\"options\":[\"Strongly recommend\",\"Recommend\",\"Recommend with reservations\",\"Do not recommend\",\"N/A\"]},{\"row\":1,\"column\":0,\"description\":\"Describe the applicant's understanding of the RCC's role and responsibilities.\",\"type\":\"textarea\"},{\"row\":1,\"column\":0,\"description\":\"Assess the applicant's ability as an RCC, including technical knowledge, teaching and resident interactions.\",\"type\":\"textarea\"},{\"row\":1,\"column\":0,\"description\":\"Additional comments, including any potential conflicts with the position.\",\"type\":\"textarea\"},{\"row\":1,\"column\":0,\"description\":\"\\n\\n\\n\\n\\n\\u003ch2 style=\\\"text-align: left;\\\"\\u003e\\u003cspan style=\\\"color: #ff0000;\\\"\\u003e\\u003cstrong\\u003eCONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL\\u003c/strong\\u003e\\u003c/span\\u003e\\u003c/h2\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\u003cp\\u003e\\u003cstrong\\u003e\\u0026nbsp;\\u003c/strong\\u003e\\u003c/p\\u003e\\n\\u003cp\\u003e\\u0026nbsp;\\u003c/p\\u003e\\n\\n\",\"type\":\"description\"}]"

interview_form1_html = "<div class=\"col-lg-12 row-in-form\" id=\"exist-row-0\" style=\"border: 2px dashed transparent;\"><div id=\"exist-drop-0\" class=\"drop-block col-lg-12 ui-droppable ui-sortable\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-0\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <div class=\"description\">\n\n\n\n\n<h2 style=\"text-align: center;\"><strong>Interview Review Form for <span style=\"color: #ff6600;\">RCC</span></strong></h2>\n<p>&nbsp;</p>\n\n</div>\n        </div><div id=\"exist-sort-1\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <div class=\"description\">\n\n\n\n\n<h2 style=\"text-align: left;\"><span style=\"color: #ff0000;\"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2>\n<p><span style=\"color: #000000;\"><strong>RECOMMENDATION:</strong></span></p>\n\n</div>\n        </div><div id=\"exist-sort-2\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\"><label class=\"multiple\">Row:</label><div class=\"normal-height\"><label class=\"radio\"><input type=\"radio\" value=\"option0-0\"><span>Strongly recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-1\"><span>Recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-2\"><span>Recommend with reservations</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-3\"><span>Do not recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-4\"><span>N/A</span></label></div></div><div id=\"exist-sort-3\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\"><label class=\"multiple\">Upperclass:</label><div class=\"normal-height\"><label class=\"radio\"><input type=\"radio\" value=\"option0-0\"><span>Strongly recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-1\"><span>Recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-2\"><span>Recommend with reservations</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-3\"><span>Do not recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-4\"><span>N/A</span></label></div></div><div id=\"exist-sort-4\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\"><label class=\"multiple\">Four Class:</label><div class=\"normal-height\"><label class=\"radio\"><input type=\"radio\" value=\"option0-0\"><span>Strongly recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-1\"><span>Recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-2\"><span>Recommend with reservations</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-3\"><span>Do not recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-4\"><span>N/A</span></label></div></div><div id=\"exist-sort-5\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\"><label class=\"multiple\">Freshmen:</label><div class=\"normal-height\"><label class=\"radio\"><input type=\"radio\" value=\"option0-0\"><span>Strongly recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-1\"><span>Recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-2\"><span>Recommend with reservations</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-3\"><span>Do not recommend</span></label><label class=\"radio\"><input type=\"radio\" value=\"option0-4\"><span>N/A</span></label></div></div></div></div><div class=\"col-lg-12 row-in-form\" id=\"exist-row-1\" style=\"border: 2px dashed transparent;\"><div id=\"exist-drop-1\" class=\"drop-block col-lg-12 ui-droppable ui-sortable\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-6\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <label class=\"text-area\">Describe the applicant's understanding of the RCC's role and responsibilities.</label>\n          <textarea style=\"width: 100%; min-height: 200px; resize: none;\"></textarea>\n        </div><div id=\"exist-sort-7\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <label class=\"text-area\">Assess the applicant's ability as an RCC, including technical knowledge, teaching and resident interactions.</label>\n          <textarea style=\"width: 100%; min-height: 200px; resize: none;\"></textarea>\n        </div><div id=\"exist-sort-8\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <label class=\"text-area\">Additional comments, including any potential conflicts with the position.</label>\n          <textarea style=\"width: 100%; min-height: 200px; resize: none;\"></textarea>\n        </div><div id=\"exist-sort-9\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n\n          <div class=\"description\">\n\n\n\n\n<h2 style=\"text-align: left;\"><span style=\"color: #ff0000;\"><strong>CONFIDENTIAL - NOT TO BE SHARED - CONFIDENTIAL</strong></span></h2></div>\n        </div></div></div>\n"

peoplesoft_form_html = "<div class=\"col-lg-12 row-in-form\" id=\"exist-row-0\" style=\"border: 2px dashed transparent;\"><div id=\"exist-drop-0\" class=\"drop-block ui-droppable ui-sortable col-lg-4\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-0\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">First Name</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div></div><div id=\"exist-drop-1\" class=\"drop-block ui-droppable ui-sortable col-lg-4\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-1\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Middle Name</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div></div><div id=\"exist-drop-2\" class=\"drop-block col-lg-4 ui-droppable ui-sortable\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-2\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Last Name</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div></div></div><div class=\"col-lg-12 row-in-form\" id=\"exist-row-1\" style=\"border: 2px dashed transparent;\"><div id=\"exist-drop-3\" class=\"drop-block col-lg-12 ui-droppable ui-sortable\" style=\"border: 2px dashed transparent;\"><div id=\"exist-sort-3\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">SUNetID</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-4\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Email</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-5\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Phone</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-6\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Address</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-7\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Gender</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-8\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Type</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-9\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Plan</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-10\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Status</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-11\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Years of Guaranteed Housing Remaining</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-12\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">GPA</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-13\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Term</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div><div id=\"exist-sort-14\" class=\"sort-item ui-sortable-handle\" data-toggle=\"modal\" style=\"border: 2px dashed transparent;\">\n          \n          <label class=\"simple\" ps=\"yes\" rq=\"no\">Career</label>\n          <input type=\"text\" style=\"width: 100%;\">\n        </div></div></div>"

peoplesoft_form_schema = "[{\"row\":0,\"column\":0,\"description\":\"First Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":0,\"column\":1,\"description\":\"Middle Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":0,\"column\":2,\"description\":\"Last Name\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"SUNetID\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Email\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Phone\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Address\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Gender\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Type\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Plan\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Status\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Years of Guaranteed Housing Remaining\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"GPA\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Term\",\"type\":\"text\",\"ps\":true,\"rq\":false},{\"row\":1,\"column\":0,\"description\":\"Career\",\"type\":\"text\",\"ps\":true,\"rq\":false}]"

default_forms = [
  {
    "form_name"=> "Interview Form",
    "display"=> 0,
    "type"=> "Interview",
    "form"=> interview_form1_html,
    "schema"=> interview_form1_schema
  },
  {
    "form_name"=> "Application Form",
    "display"=> 0,
    "type"=> "System",
    "form"=> default_application_form,
    "schema"=> default_application_form_schema
  },
  {
    "form_name"=> "New Applicant Recommendation Form",
    "display"=> 0,
    "type"=> "Recommender",
    "form"=> default_recommendation_form_1,
    "schema"=> default_recommendation_form_schema_1
  },
  {
    "form_name"=> "Re-applicant Recommendation Form #1",
    "display"=> 0,
    "type"=> "Recommender",
    "form"=> default_recommendation_form_2,
    "schema"=> default_recommendation_form_schema_2
  },
  {
    "form_name"=> "Re-applicant Recommendation Form #2",
    "display"=> 0,
    "type"=> "Recommender",
    "form"=> default_recommendation_form_3,
    "schema"=> default_recommendation_form_schema_3
  },
]

forms = [
  {
    "process_id"=> 2,
    "form_name"=> "Application Form",
    "display"=> 1,
    "type"=> "System",
    "form"=> ca_system_form,
    "schema"=> ca_system_form_schema
  },
  {
    "process_id"=> 2,
    "form_name"=> "Interview Form",
    "display"=> 1,
    "type"=> "Interview",
    "form"=> ca_interview_form,
    "schema"=> ca_interview_form_schema
  },
  {
    "process_id"=> 3,
    "form_name"=> "Application Form",
    "display"=> 1,
    "type"=> "System",
    "form"=> rcc_system_form,
    "schema"=> rcc_system_form_schema
  },
  {
    "process_id"=> 3,
    "form_name"=> "Recommendation Form",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> rcc_recommendation_form,
    "schema"=> rcc_recommendation_form_schema
  },
  {
    "process_id"=> 3,
    "form_name"=> "Interview Form",
    "display"=> 1,
    "type"=> "Interview",
    "form"=> rcc_interview_form,
    "schema"=> rcc_interview_form_schema
  },
  {
    "process_id"=> 5,
    "form_name"=> "Application Form",
    "display"=> 1,
    "type"=> "System",
    "form"=> pa_system_form,
    "schema"=> pa_system_form_schema
  },
  {
    "process_id"=> 5,
    "form_name"=> "Interview Form",
    "display"=> 1,
    "type"=> "Interview",
    "form"=> pa_interview_form,
    "schema"=> pa_interview_form_schema
  },
  {
    "process_id"=> 5,
    "form_name"=> "Branner House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Branner",
    "form"=> pa_form_1,
    "schema"=> pa_form_schema_1
  },
  {
    "process_id"=> 5,
    "form_name"=> "Casa Italiana House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Casa Italiana",
    "form"=> pa_form_2,
    "schema"=> pa_form_schema_2
  },
  {
    "process_id"=> 5,
    "form_name"=> "576 Alvarado House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "576 Alvarado",
    "form"=> pa_form_3,
    "schema"=> pa_form_schema_3
  },
  {
    "process_id"=> 5,
    "form_name"=> "Columbae House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Columbae",
    "form"=> pa_form_4,
    "schema"=> pa_form_schema_4
  },
  {
    "process_id"=> 5,
    "form_name"=> "Crothers House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Crothers",
    "form"=> pa_form_5,
    "schema"=> pa_form_schema_5
  },
  {
    "process_id"=> 5,
    "form_name"=> "East House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "East",
    "form"=> pa_form_6,
    "schema"=> pa_form_schema_6
  },
  {
    "process_id"=> 5,
    "form_name"=> "EBF House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "EBF",
    "form"=> pa_form_7,
    "schema"=> pa_form_schema_7
  },
  {
    "process_id"=> 5,
    "form_name"=> "FroSoCo House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "FroSoCo",
    "form"=> pa_form_8,
    "schema"=> pa_form_schema_8
  },
  {
    "process_id"=> 5,
    "form_name"=> "Hammarskjold House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Hammarskjold",
    "form"=> pa_form_9,
    "schema"=> pa_form_schema_9
  },
  {
    "process_id"=> 5,
    "form_name"=> "Haus Mitterleuropa House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Haus Mitterleuropa",
    "form"=> pa_form_10,
    "schema"=> pa_form_schema_10
  },
  {
    "process_id"=> 5,
    "form_name"=> "Kairos House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Kairos",
    "form"=> pa_form_11,
    "schema"=> pa_form_schema_11
  },
  {
    "process_id"=> 5,
    "form_name"=> "Kimball House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Kimball",
    "form"=> pa_form_12,
    "schema"=> pa_form_schema_12
  },
  {
    "process_id"=> 5,
    "form_name"=> "La Maison Francaise House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "La Maison Francaise",
    "form"=> pa_form_13,
    "schema"=> pa_form_schema_13
  },
  {
    "process_id"=> 5,
    "form_name"=> "Muwekma House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Muwekma",
    "form"=> pa_form_14,
    "schema"=> pa_form_schema_14
  },
  {
    "process_id"=> 5,
    "form_name"=> "Okada House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Okada",
    "form"=> pa_form_15,
    "schema"=> pa_form_schema_15
  },
  {
    "process_id"=> 5,
    "form_name"=> "Slav Dom House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Slav Dom",
    "form"=> pa_form_16,
    "schema"=> pa_form_schema_16
  },
  {
    "process_id"=> 5,
    "form_name"=> "Storey House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Storey",
    "form"=> pa_form_17,
    "schema"=> pa_form_schema_17
  },
  {
    "process_id"=> 5,
    "form_name"=> "Castano House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Castano",
    "form"=> pa_form_18,
    "schema"=> pa_form_schema_18
  },
  {
    "process_id"=> 5,
    "form_name"=> "Substance Free House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Substance-Free",
    "form"=> pa_form_19,
    "schema"=> pa_form_schema_19
  },
  {
    "process_id"=> 5,
    "form_name"=> "Synergy House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Synergy",
    "form"=> pa_form_20,
    "schema"=> pa_form_schema_20
  },
  {
    "process_id"=> 5,
    "form_name"=> "Terra House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Terra",
    "form"=> pa_form_21,
    "schema"=> pa_form_schema_21
  },
  {
    "process_id"=> 5,
    "form_name"=> "Ujamaa House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Ujamaa",
    "form"=> pa_form_22,
    "schema"=> pa_form_schema_22
  },
  {
    "process_id"=> 5,
    "form_name"=> "Casa Zapata House Supplemental Questions",
    "display"=> 1,
    "type"=> "Application",
    "location_tag_name"=> "Casa Zapata",
    "form"=> pa_form_23,
    "schema"=> pa_form_schema_23
  },
  {
    "process_id"=> 7,
    "form_name"=> "Application Form",
    "display"=> 1,
    "type"=> "System",
    "form"=> hss_system_form,
    "schema"=> hss_system_form_schema
  },
  {
    "process_id"=> 7,
    "form_name"=> "Interview Form",
    "display"=> 1,
    "type"=> "Interview",
    "form"=> hss_interview_form,
    "schema"=> hss_interview_form_schema
  },
  {
    "process_id"=> 7,
    "form_name"=> "New Applicant Recommendation Form",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> hss_recommendation_form_1,
    "schema"=> hss_recommendation_form_schema_1
  },
  {
    "process_id"=> 7,
    "form_name"=> "Re-applicant Recommendation Form #1",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> hss_recommendation_form_2,
    "schema"=> hss_recommendation_form_schema_2
  },
  {
    "process_id"=> 7,
    "form_name"=> "Re-applicant Recommendation Form #2",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> hss_recommendation_form_3,
    "schema"=> hss_recommendation_form_schema_3
  },
  {
    "process_id"=> 7,
    "form_name"=> "PHE Recommendation Form",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> hss_recommendation_form_4,
    "schema"=> hss_recommendation_form_schema_4
  },
  {
    "process_id"=> 7,
    "form_name"=> "RCC Recommendation Form",
    "display"=> 1,
    "type"=> "Recommender",
    "form"=> hss_recommendation_form_5,
    "schema"=> hss_recommendation_form_schema_5
  }
];

form_translations = [
  { "translate_key" => "Email", "match_column" => "email", "description" => "E-mail" },
  { "translate_key" => "SUNetID", "match_column" => "sunet_id", "description" => "SUNetID" },
  { "translate_key" => "Suid", "match_column" => "suid", "description" => "Suid" },
  { "translate_key" => "First Name", "match_column" => "first_name", "description" => "First Name" },
  { "translate_key" => "Last Name", "match_column" => "last_name", "description" => "Last Name" },
  { "translate_key" => "Middle Name", "match_column" => "middle_name", "description" => "Middle Name" },
  { "translate_key" => "Gender", "match_column" => "gender", "description" => "Gender" },
  { "translate_key" => "Address", "match_column" => "address", "description" => "Address" },
  { "translate_key" => "Phone", "match_column" => "phone", "description" => "Phone" },
  { "translate_key" => "Years of Guaranteed Housing Remaining", "match_column" => "academic_year_remaining", "description" => "Years of Guaranteed Housing Remaining" },
  { "translate_key" => "GPA", "match_column" => "academics_gpa", "description" => "GPA" },
  { "translate_key" => "Status", "match_column" => "academics_status", "description" => "Status" },
  { "translate_key" => "Type", "match_column" => "academics_type", "description" => "Type" },
  { "translate_key" => "Plan", "match_column" => "academics_plan", "description" => "Plan" },
  { "translate_key" => "Career", "match_column" => "academics_career", "description" => "Career" },
  { "translate_key" => "Term", "match_column" => "academics_term", "description" => "Term" },
  { "translate_key" => "Academic Standing", "match_column" => "academic_standing", "description" => "Academic Standing" },
]

ra_positions = {
  ["680 Lomita", "CM"] => true,
  ["680 Lomita", "FM"] => true,
  ["680 Lomita", "KM"] => true,
  ["680 Lomita", "RA"] => true,
  ["717 Dolores", "CM"] => true,
  ["717 Dolores", "FM"] => true,
  ["717 Dolores", "KM"] => true,
  ["717 Dolores", "RA"] => true,
  ["Arroyo", "RA"] => true,
  ["BOB", "CM"] => true,
  ["BOB", "FM"] => true,
  ["BOB", "KM"] => true,
  ["BOB", "RA"] => true,
  ["Branner", "RA"] => true,
  ["Branner", "TA"] => true,
  ["Burbank", "RA"] => true,
  ["Casa Zapata", "ETA"] => true,
  ["Casa Zapata", "RA"] => true,
  ["Castano", "RA"] => true,
  ["Cedro", "RA"] => true,
  ["Chi Theta Chi", "CM"] => true,
  ["Chi Theta Chi", "Coop MGR"] => true,
  ["Chi Theta Chi", "Fix MGR"] => true,
  ["Chi Theta Chi", "FM"] => true,
  ["Chi Theta Chi", "KM"] => true,
  ["Chi Theta Chi", "RA"] => true,
  ["Columbae", "CM"] => true,
  ["Columbae", "Coop MGR"] => true,
  ["Columbae", "FM"] => true,
  ["Columbae", "KM"] => true,
  ["Columbae", "RA"] => true,
  ["Crothers", "ATA"] => true,
  ["Crothers", "RA"] => true,
  ["Delta Delta Delta", "CM"] => true,
  ["Delta Delta Delta", "FM"] => true,
  ["Delta Delta Delta", "KM"] => true,
  ["Delta Delta Delta", "RA"] => true,
  ["Donner", "RA"] => true,
  ["Durand", "CM"] => true,
  ["Durand", "FM"] => true,
  ["Durand", "KM"] => true,
  ["Durand", "RA"] => true,
  ["EBF", "CM"] => true,
  ["EBF", "Coop MGR"] => true,
  ["EBF", "FM"] => true,
  ["EBF", "KM"] => true,
  ["EBF", "RA"] => true,
  ["East House", "ATA"] => true,
  ["East House", "RA"] => true,
  ["Escondido Village", "RA"] => true,
  ["Florence Moore East (Alondra/Cardenal/Faisan)", "RA"] => true,
  ["Florence Moore West (Gavilan/Loro/Mirlo/Paloma)", "RA"] => true,
  ["Freshman Sophomore College", "RA"] => true,
  ["Grove Mayfield", "CM"] => true,
  ["Grove Mayfield", "FM"] => true,
  ["Grove Mayfield", "KM"] => true,
  ["Grove Mayfield", "RA"] => true,
  ["Hammarskjold", "CM"] => true,
  ["Hammarskjold", "Coop MGR"] => true,
  ["Hammarskjold", "FM"] => true,
  ["Hammarskjold", "KM"] => true,
  ["Hammarskjold", "RA"] => true,
  ["Haus Mitteleuropa", "CM"] => true,
  ["Haus Mitteleuropa", "FM"] => true,
  ["Haus Mitteleuropa", "KM"] => true,
  ["Haus Mitteleuropa", "LCATA"] => true,
  ["Haus Mitteleuropa", "RA"] => true,
  ["Jerry", "CM"] => true,
  ["Jerry", "FM"] => true,
  ["Jerry", "KM"] => true,
  ["Jerry", "RA"] => true,
  ["Junipero", "RA"] => true,
  ["Kairos", "CM"] => true,
  ["Kairos", "Coop MGR"] => true,
  ["Kairos", "FM"] => true,
  ["Kairos", "KM"] => true,
  ["Kairos", "RA"] => true,
  ["Kappa Alpha", "CM"] => true,
  ["Kappa Alpha", "FM"] => true,
  ["Kappa Alpha", "KM"] => true,
  ["Kappa Alpha", "RA"] => true,
  ["Kappa Alpha Theta", "CM"] => true,
  ["Kappa Alpha Theta", "FM"] => true,
  ["Kappa Alpha Theta", "KM"] => true,
  ["Kappa Alpha Theta", "RA"] => true,
  ["Kappa Sigma", "CM"] => true,
  ["Kappa Sigma", "FM"] => true,
  ["Kappa Sigma", "KM"] => true,
  ["Kappa Sigma", "RA"] => true,
  ["Kimball", "ATA"] => true,
  ["Kimball", "RA"] => true,
  ["La Casa Italiana", "CM"] => true,
  ["La Casa Italiana", "FM"] => true,
  ["La Casa Italiana", "KM"] => true,
  ["La Casa Italiana", "LCATA"] => true,
  ["La Casa Italiana", "RA"] => true,
  ["La Maison Francaise", "CM"] => true,
  ["La Maison Francaise", "FM"] => true,
  ["La Maison Francaise", "KM"] => true,
  ["La Maison Francaise", "LCATA"] => true,
  ["La Maison Francaise", "RA"] => true,
  ["Lantana", "RA"] => true,
  ["Larkin", "RA"] => true,
  ["Mars", "CM"] => true,
  ["Mars", "KM"] => true,
  ["Mars", "RA"] => true,
  ["Mirrielees", "RA"] => true,
  ["Mirrielees Substance Free", "RA"] => true,
  ["Murray", "RA"] => true,
  ["Muwekma-tah-ruk", "CM"] => true,
  ["Muwekma-tah-ruk", "ETA"] => true,
  ["Muwekma-tah-ruk", "FM"] => true,
  ["Muwekma-tah-ruk", "KM"] => true,
  ["Muwekma-tah-ruk", "RA"] => true,
  ["Naranja", "RA"] => true,
  ["Narnia", "CM"] => true,
  ["Narnia", "FM"] => true,
  ["Narnia", "KM"] => true,
  ["Narnia", "RA"] => true,
  ["Oak Creek", "RA"] => true,
  ["Okada", "ETA"] => true,
  ["Okada", "RA"] => true,
  ["Otero", "RA"] => true,
  ["Phi Kappa Psi", "CM"] => true,
  ["Phi Kappa Psi", "FM"] => true,
  ["Phi Kappa Psi", "KM"] => true,
  ["Phi Kappa Psi", "RA"] => true,
  ["Phi Sig", "CM"] => true,
  ["Phi Sig", "FM"] => true,
  ["Phi Sig", "KM"] => true,
  ["Phi Sig", "RA"] => true,
  ["Pi Beta Phi", "CM"] => true,
  ["Pi Beta Phi", "FM"] => true,
  ["Pi Beta Phi", "KM"] => true,
  ["Pi Beta Phi", "RA"] => true,
  ["Potter", "RA"] => true,
  ["Rains", "RA"] => true,
  ["Rinconada", "RA"] => true,
  ["Robinson", "RA"] => true,
  ["Roble", "RA"] => true,
  ["Roth", "CM"] => true,
  ["Roth", "FM"] => true,
  ["Roth", "KM"] => true,
  ["Roth", "RA"] => true,
  ["Serra", "RA"] => true,
  ["Sigma Alpha Epsilon", "CM"] => true,
  ["Sigma Alpha Epsilon", "FM"] => true,
  ["Sigma Alpha Epsilon", "KM"] => true,
  ["Sigma Alpha Epsilon", "RA"] => true,
  ["Sigma Chi", "CM"] => true,
  ["Sigma Chi", "FM"] => true,
  ["Sigma Chi", "KM"] => true,
  ["Sigma Chi", "RA"] => true,
  ["Sigma Nu", "CM"] => true,
  ["Sigma Nu", "FM"] => true,
  ["Sigma Nu", "KM"] => true,
  ["Sigma Nu", "RA"] => true,
  ["Slavianskii Dom", "CM"] => true,
  ["Slavianskii Dom", "FM"] => true,
  ["Slavianskii Dom", "KM"] => true,
  ["Slavianskii Dom", "LCATA"] => true,
  ["Slavianskii Dom", "RA"] => true,
  ["Soto", "RA"] => true,
  ["Storey", "ATA"] => true,
  ["Storey", "CM"] => true,
  ["Storey", "FM"] => true,
  ["Storey", "KM"] => true,
  ["Storey", "RA"] => true,
  ["Suites", "RA"] => true,
  ["Synergy", "CM"] => true,
  ["Synergy", "Coop MGR"] => true,
  ["Synergy", "FM"] => true,
  ["Synergy", "KM"] => true,
  ["Synergy", "RA"] => true,
  ["Terra", "CM"] => true,
  ["Terra", "Coop MGR"] => true,
  ["Terra", "FM"] => true,
  ["Terra", "KM"] => true,
  ["Terra", "RA"] => true,
  ["Theta Delta Chi", "CM"] => true,
  ["Theta Delta Chi", "FM"] => true,
  ["Theta Delta Chi", "KM"] => true,
  ["Theta Delta Chi", "RA"] => true,
  ["Toyon", "RA"] => true,
  ["Trancos", "RA"] => true,
  ["Twain", "RA"] => true,
  ["Ujamaa", "ETA"] => true,
  ["Ujamaa", "RA"] => true,
  ["West Lagunita (Adelfa/Eucalipto/Granada)", "RA"] => true,
  ["Xanadu", "CM"] => true,
  ["Xanadu", "FM"] => true,
  ["Xanadu", "KM"] => true,
  ["Xanadu", "RA"] => true,
  ["Yost", "RA"] => true,
  ["ZAP", "CM"] => true,
  ["ZAP", "FM"] => true,
  ["ZAP", "KM"] => true,
  ["ZAP", "RA"] => true
}

hss_positions = {
  ["576 Alvarado", "CM"] => ["Community Manager", "4"],
  ["576 Alvarado", "FM"] => ["Financial Manager", "1"],
  ["576 Alvarado", "KM"] => ["Kitchen Manager", "3"],
  ["576 Alvarado", "RA"] => ["Resident Assistant", "2"],
  ["576 Alvarado", "RCC"] => ["Resident Computer Consultant", "1"],
  ["680 Lomita", "CM"] => ["Community Manager", "1"],
  ["680 Lomita", "FM"] => ["Financial Manager", "1"],
  ["680 Lomita", "KM"] => ["Kitchen Manager", "1"],
  ["680 Lomita", "RA"] => ["Resident Assistant", "1"],
  ["680 Lomita", "RCC"] => ["Resident Computer Consultant", "1"],
  ["717 Dolores", "CM"] => ["Community Manager", "1"],
  ["717 Dolores", "FM"] => ["Financial Manager", "1"],
  ["717 Dolores", "KM"] => ["Kitchen Manager", "1"],
  ["717 Dolores", "RA"] => ["Resident Assistant", "1"],
  ["717 Dolores", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Arroyo", "PHE"] => ["Peer Health Educator", "1"],
  ["Arroyo", "RA"] => ["Resident Assistant", "4"],
  ["Arroyo", "RCC"] => ["Resident Computer Consultant", "1"],
  ["BOB", "CM"] => ["Community Manager", "1"],
  ["BOB", "FM"] => ["Financial Manager", "1"],
  ["BOB", "KM"] => ["Kitchen Manager", "1"],
  ["BOB", "RA"] => ["Resident Assistant", "1"],
  ["BOB", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Branner", "ATA"] => ["Academic Theme Associate", "4"],
  ["Branner", "RA"] => ["Resident Assistant", "4"],
  ["Branner", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Burbank", "RA"] => ["Resident Assistant", "5"],
  ["Burbank", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Casa Zapata", "ETA"] => ["Ethnic Theme Associate", "3"],
  ["Casa Zapata", "PHE"] => ["Peer Health Educator", "1"],
  ["Casa Zapata", "RA"] => ["Resident Assistant", "4"],
  ["Casa Zapata", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Castano", "PHE"] => ["Peer Health Educator", "1"],
  ["Castano", "RA"] => ["Resident Assistant", "3"],
  ["Castano", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Cedro", "PHE"] => ["Peer Health Educator", "1"],
  ["Cedro", "RA"] => ["Resident Assistant", "4"],
  ["Cedro", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Columbae", "CM"] => ["Community Manager", "2"],
  ["Columbae", "FM"] => ["Financial Manager", "1"],
  ["Columbae", "KM"] => ["Kitchen Manager", "2"],
  ["Columbae", "RA"] => ["Resident Assistant", "1"],
  ["Columbae", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Crothers", "ATA"] => ["Academic Theme Associate", "4"],
  ["Crothers", "RA"] => ["Resident Assistant", "13"],
  ["Crothers", "RCC"] => ["Resident Computer Consultant", "4"],
  ["Delta Delta Delta", "CM"] => ["Community Manager", "1"],
  ["Delta Delta Delta", "FM"] => ["Financial Manager", "1"],
  ["Delta Delta Delta", "KM"] => ["Kitchen Manager", "1"],
  ["Delta Delta Delta", "PHE"] => ["Peer Health Educator", "1"],
  ["Delta Delta Delta", "RA"] => ["Resident Assistant", "1"],
  ["Delta Delta Delta", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Donner", "PHE"] => ["Peer Health Educator", "1"],
  ["Donner", "RA"] => ["Resident Assistant", "4"],
  ["Donner", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Durand", "CM"] => ["Community Manager", "1"],
  ["Durand", "FM"] => ["Financial Manager", "1"],
  ["Durand", "KM"] => ["Kitchen Manager", "1"],
  ["Durand", "RA"] => ["Resident Assistant", "1"],
  ["Durand", "RCC"] => ["Resident Computer Consultant", "1"],
  ["EAST", "ATA"] => ["Academic Theme Associate", "3"],
  ["EAST", "DM"] => ["Dining Manager", "1"],
  ["EAST", "RA"] => ["Resident Assistant", "2"],
  ["EAST", "RCC"] => ["Resident Computer Consultant", "1"],
  ["East FloMo", "PHE"] => ["Peer Health Educator", "1"],
  ["East FloMo", "RA"] => ["Resident Assistant", "9"],
  ["East FloMo", "RCC"] => ["Resident Computer Consultant", "3"],
  ["EBF", "CM"] => ["Community Manager", "2"],
  ["EBF", "FM"] => ["Financial Manager", "1"],
  ["EBF", "KM"] => ["Kitchen Manager", "3"],
  ["EBF", "RA"] => ["Resident Assistant", "1"],
  ["EBF", "RCC"] => ["Resident Computer Consultant", "1"],
  ["FroSoCo", "OCT"] => ["Oral Communications Tutor", "1"],
  ["FroSoCo", "PHE"] => ["Peer Health Educator", "1"],
  ["FroSoCo", "RA"] => ["Resident Assistant", "8"],
  ["FroSoCo", "RCC"] => ["Resident Computer Consultant", "2"],
  ["FroSoCo", "RMC"] => ["Resident Multimedia Consultant", "1"],
  ["Grove", "CM"] => ["Community Manager", "1"],
  ["Grove", "FM"] => ["Financial Manager", "1"],
  ["Grove", "KM"] => ["Kitchen Manager", "1"],
  ["Grove", "RA"] => ["Resident Assistant", "1"],
  ["Grove", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Hammarskjold", "CM"] => ["Community Manager", "2"],
  ["Hammarskjold", "FM"] => ["Financial Manager", "1"],
  ["Hammarskjold", "KM"] => ["Kitchen Manager", "2"],
  ["Hammarskjold", "RA"] => ["Resident Assistant", "1"],
  ["Hammarskjold", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Haus Mitteleuropa", "ATA"] => ["Academic Theme Associate", "2"],
  ["Haus Mitteleuropa", "CM"] => ["Community Manager", "1"],
  ["Haus Mitteleuropa", "FM"] => ["Financial Manager", "1"],
  ["Haus Mitteleuropa", "KM"] => ["Kitchen Manager", "1"],
  ["Haus Mitteleuropa", "RA"] => ["Resident Assistant", "1"],
  ["Haus Mitteleuropa", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Jerry", "CM"] => ["Community Manager", "1"],
  ["Jerry", "FM"] => ["Financial Manager", "1"],
  ["Jerry", "KM"] => ["Kitchen Manager", "1"],
  ["Jerry", "RA"] => ["Resident Assistant", "1"],
  ["Jerry", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Junipero", "PHE"] => ["Peer Health Educator", "1"],
  ["Junipero", "RA"] => ["Resident Assistant", "4"],
  ["Junipero", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Kairos", "CM"] => ["Community Manager", "2"],
  ["Kairos", "FM"] => ["Financial Manager", "1"],
  ["Kairos", "KM"] => ["Kitchen Manager", "2"],
  ["Kairos", "RA"] => ["Resident Assistant", "1"],
  ["Kairos", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Kappa Alpha", "CM"] => ["Community Manager", "1"],
  ["Kappa Alpha", "KM"] => ["Kitchen Manager", "1"],
  ["Kappa Alpha", "RA"] => ["Resident Assistant", "1"],
  ["Kappa Alpha", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Kappa Alpha Theta", "CM"] => ["Community Manager", "1"],
  ["Kappa Alpha Theta", "KM"] => ["Kitchen Manager", "1"],
  ["Kappa Alpha Theta", "PHE"] => ["Peer Health Educator", "1"],
  ["Kappa Alpha Theta", "RA"] => ["Resident Assistant", "1"],
  ["Kappa Alpha Theta", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Kappa Sigma", "CM"] => ["Community Manager", "1"],
  ["Kappa Sigma", "FM"] => ["Financial Manager", "1"],
  ["Kappa Sigma", "KM"] => ["Kitchen Manager", "1"],
  ["Kappa Sigma", "RA"] => ["Resident Assistant", "1"],
  ["Kappa Sigma", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Kimball", "ATA"] => ["Academic Theme Associate", "6"],
  ["Kimball", "PHE"] => ["Peer Health Educator", "1"],
  ["Kimball", "RA"] => ["Resident Assistant", "6"],
  ["Kimball", "RCC"] => ["Resident Computer Consultant", "2"],
  ["La Casa Italiana", "ATA"] => ["Academic Theme Associate", "2"],
  ["La Casa Italiana", "CM"] => ["Community Manager", "1"],
  ["La Casa Italiana", "FM"] => ["Financial Manager", "1"],
  ["La Casa Italiana", "KM"] => ["Kitchen Manager", "1"],
  ["La Casa Italiana", "RA"] => ["Resident Assistant", "1"],
  ["La Casa Italiana", "RCC"] => ["Resident Computer Consultant", "1"],
  ["La Maison Francaise", "ATA"] => ["Academic Theme Associate", "2"],
  ["La Maison Francaise", "CM"] => ["Community Manager", "1"],
  ["La Maison Francaise", "FM"] => ["Financial Manager", "1"],
  ["La Maison Francaise", "KM"] => ["Kitchen Manager", "1"],
  ["La Maison Francaise", "RA"] => ["Resident Assistant", "1"],
  ["La Maison Francaise", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Lantana", "PHE"] => ["Peer Health Educator", "1"],
  ["Lantana", "RA"] => ["Resident Assistant", "3"],
  ["Lantana", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Larkin", "PHE"] => ["Peer Health Educator", "1"],
  ["Larkin", "RA"] => ["Resident Assistant", "5"],
  ["Larkin", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Mars", "CM"] => ["Community Manager", "1"],
  ["Mars", "FM"] => ["Financial Manager", "1"],
  ["Mars", "KM"] => ["Kitchen Manager", "1"],
  ["Mars", "RA"] => ["Resident Assistant", "1"],
  ["Mars", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Mirrielees", "PHE"] => ["Peer Health Educator", "1"],
  ["Mirrielees", "RA"] => ["Resident Assistant", "7"],
  ["Mirrielees", "RCC"] => ["Resident Computer Consultant", "3"],
  ["Murray", "DM"] => ["Dining Manager", "2"],
  ["Murray", "PHE"] => ["Peer Health Educator", "1"],
  ["Murray", "RA"] => ["Resident Assistant", "2"],
  ["Murray", "RAy"] => ["#N/A", "6"],
  ["Murray", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Muwekma-Tah-Ruk", "ETA"] => ["Ethnic Theme Associate", "1"],
  ["Muwekma-Tah-Ruk", "FM"] => ["Financial Manager", "1"],
  ["Muwekma-Tah-Ruk", "KM"] => ["Kitchen Manager", "1"],
  ["Muwekma-Tah-Ruk", "PHE"] => ["Peer Health Educator", "1"],
  ["Muwekma-Tah-Ruk", "RA"] => ["Resident Assistant", "2"],
  ["Muwekma-Tah-Ruk", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Naranja", "RA"] => ["Resident Assistant", "2"],
  ["Naranja", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Narnia", "CM"] => ["Community Manager", "1"],
  ["Narnia", "FM"] => ["Financial Manager", "1"],
  ["Narnia", "KM"] => ["Kitchen Manager", "1"],
  ["Narnia", "RA"] => ["Resident Assistant", "1"],
  ["Narnia", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Oak Creek", "RA"] => ["Resident Assistant", "4"],
  ["Okada", "ETA"] => ["Ethnic Theme Associate", "3"],
  ["Okada", "PHE"] => ["Peer Health Educator", "1"],
  ["Okada", "RA"] => ["Resident Assistant", "3"],
  ["Okada", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Otero", "PHE"] => ["Peer Health Educator", "1"],
  ["Otero", "RA"] => ["Resident Assistant", "4"],
  ["Otero", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Phi Kappa Psi", "CM"] => ["Community Manager", "1"],
  ["Phi Kappa Psi", "FM"] => ["Financial Manager", "1"],
  ["Phi Kappa Psi", "KM"] => ["Kitchen Manager", "1"],
  ["Phi Kappa Psi", "RA"] => ["Resident Assistant", "1"],
  ["Phi Kappa Psi", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Phi Sig", "CM"] => ["Community Manager", "1"],
  ["Phi Sig", "FM"] => ["Financial Manager", "1"],
  ["Phi Sig", "KM"] => ["Kitchen Manager", "1"],
  ["Phi Sig", "RA"] => ["Resident Assistant", "1"],
  ["Phi Sig", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Pi Beta Phi", "CM"] => ["Community Manager", "1"],
  ["Pi Beta Phi", "FM"] => ["Financial Manager", "1"],
  ["Pi Beta Phi", "KM"] => ["Kitchen Manager", "1"],
  ["Pi Beta Phi", "PHE"] => ["Peer Health Educator", "1"],
  ["Pi Beta Phi", "RA"] => ["Resident Assistant", "1"],
  ["Pi Beta Phi", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Potter", "RA"] => ["Resident Assistant", "3"],
  ["Potter", "RA"] => ["Resident Assistant", "2"],
  ["Potter", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Rains", "RA"] => ["Resident Assistant", "2"],
  ["Rinconada", "PHE"] => ["Peer Health Educator", "1"],
  ["Rinconada", "RA"] => ["Resident Assistant", "4"],
  ["Rinconada", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Robinson", "RA"] => ["Resident Assistant", "3"],
  ["Robinson", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Roble", "PHE"] => ["Peer Health Educator", "1"],
  ["Roble", "RA"] => ["Resident Assistant", "11"],
  ["Roble", "RCC"] => ["Resident Computer Consultant", "3"],
  ["Roth", "CM"] => ["Community Manager", "1"],
  ["Roth", "FM"] => ["Financial Manager", "1"],
  ["Roth", "KM"] => ["Kitchen Manager", "1"],
  ["Roth", "RA"] => ["Resident Assistant", "2"],
  ["Roth", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Serra", "PHE"] => ["Peer Health Educator", "1"],
  ["Serra", "RA"] => ["Resident Assistant", "4"],
  ["Serra", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Sigma Alpha Epsilon", "CM"] => ["Community Manager", "1"],
  ["Sigma Alpha Epsilon", "FM"] => ["Financial Manager", "1"],
  ["Sigma Alpha Epsilon", "KM"] => ["Kitchen Manager", "1"],
  ["Sigma Alpha Epsilon", "RA"] => ["Resident Assistant", "1"],
  ["Sigma Alpha Epsilon", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Sigma Chi", "CM"] => ["Community Manager", "1"],
  ["Sigma Chi", "RA"] => ["Resident Assistant", "1"],
  ["Sigma Chi", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Sigma Nu", "CM"] => ["Community Manager", "1"],
  ["Sigma Nu", "FM"] => ["Financial Manager", "1"],
  ["Sigma Nu", "KM"] => ["Kitchen Manager", "1"],
  ["Sigma Nu", "RA"] => ["Resident Assistant", "1"],
  ["Sigma Nu", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Slavianskii Dom", "ATA"] => ["Academic Theme Associate", "2"],
  ["Slavianskii Dom", "CM"] => ["Community Manager", "1"],
  ["Slavianskii Dom", "FM"] => ["Financial Manager", "1"],
  ["Slavianskii Dom", "KM"] => ["Kitchen Manager", "1"],
  ["Slavianskii Dom", "RA"] => ["Resident Assistant", "1"],
  ["Slavianskii Dom", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Soto", "PHE"] => ["Peer Health Educator", "1"],
  ["Soto", "RA"] => ["Resident Assistant", "4"],
  ["Soto", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Storey", "ATA"] => ["Academic Theme Associate", "2"],
  ["Storey", "CM"] => ["Community Manager", "1"],
  ["Storey", "FM"] => ["Financial Manager", "1"],
  ["Storey", "RA"] => ["Resident Assistant", "1"],
  ["Storey", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Suites", "DSM"] => ["Dining Services Manager", "5"],
  ["Suites", "RA"] => ["Resident Assistant", "8"],
  ["Suites", "RCC"] => ["Resident Computer Consultant", "2"],
  ["Synergy", "CM"] => ["Community Manager", "2"],
  ["Synergy", "FM"] => ["Financial Manager", "1"],
  ["Synergy", "KM"] => ["Kitchen Manager", "2"],
  ["Synergy", "RA"] => ["Resident Assistant", "1"],
  ["Synergy", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Terra", "CM"] => ["Community Manager", "2"],
  ["Terra", "FM"] => ["Financial Manager", "1"],
  ["Terra", "KM"] => ["Kitchen Manager", "3"],
  ["Terra", "RA"] => ["Resident Assistant", "8"],
  ["Terra", "RA"] => ["Resident Assistant", "1"],
  ["Terra", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Theta Delta Chi", "CM"] => ["Community Manager", "1"],
  ["Theta Delta Chi", "FM"] => ["Financial Manager", "1"],
  ["Theta Delta Chi", "KM"] => ["Kitchen Manager", "1"],
  ["Theta Delta Chi", "RA"] => ["Resident Assistant", "1"],
  ["Theta Delta Chi", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Toyon", "PHE"] => ["Peer Health Educator", "1"],
  ["Toyon", "RA"] => ["Resident Assistant", "6"],
  ["Toyon", "RCC"] => ["Resident Computer Consultant", "2"],
  ["Trancos", "PHE"] => ["Peer Health Educator", "1"],
  ["Trancos", "RA"] => ["Resident Assistant", "3"],
  ["Trancos", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Twain", "PHE"] => ["Peer Health Educator", "1"],
  ["Twain", "RA"] => ["Resident Assistant", "5"],
  ["Twain", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Ujamaa", "ETA"] => ["Ethnic Theme Associate", "3"],
  ["Ujamaa", "PHE"] => ["Peer Health Educator", "1"],
  ["Ujamaa", "RA"] => ["Resident Assistant", "4"],
  ["Ujamaa", "RCC"] => ["Resident Computer Consultant", "1"],
  ["West FloMo", "PHE"] => ["Peer Health Educator", "1"],
  ["West FloMo", "RA"] => ["Resident Assistant", "11"],
  ["West FloMo", "RCC"] => ["Resident Computer Consultant", "2"],
  ["West Lag", "PHE"] => ["Peer Health Educator", "1"],
  ["West Lag", "RA"] => ["Resident Assistant", "6"],
  ["West Lag", "RCC"] => ["Resident Computer Consultant", "2"],
  ["Xanadu", "CM"] => ["Community Manager", "1"],
  ["Xanadu", "FM"] => ["Financial Manager", "1"],
  ["Xanadu", "KM"] => ["Kitchen Manager", "1"],
  ["Xanadu", "RA"] => ["Resident Assistant", "1"],
  ["Xanadu", "RCC"] => ["Resident Computer Consultant", "1"],
  ["Yost", "RA"] => ["Resident Assistant", "2"],
  ["Yost", "RCC"] => ["Resident Computer Consultant", "1"],
  ["ZAP", "CM"] => ["Community Manager", "1"],
  ["ZAP", "FM"] => ["Financial Manager", "1"],
  ["ZAP", "KM"] => ["Kitchen Manager", "1"],
  ["ZAP", "RA"] => ["Resident Assistant", "1"],
  ["ZAP", "RCC"] => ["Resident Computer Consultant", "1"]
}
default_email_templates = [
  # The five emails about recommendation.
  { #1
    "title" => "[[ApplicantName]] requests your recommendation for positions in [[ProcessName]]",
    "email_type" => "invite_recommender",
    "content"=> <<-EOF
<p><strong>Dear </strong>[[RecommenderName]],</p>
<p>&nbsp;</p>
<p><strong>[[ApplicantName]]</strong> is seeking the following position(s) on the Stanford staff as follows.</p>
<p>&nbsp;</p>
<p>Process: [[ProcessName]].</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p>If you have questions regarding this position or recommendation, please direct responses to the applicant directly at [[ApplicantEmail]].</p>
<p><strong>Please submit this recommendation </strong>[[RecommendationEndDate]]. To see if your recommendation was successfully received, you may check the applicant, who can view their application status at any time. We suggest that you keep a copy of this recommendation on your computer in case of a submission problem.</p>
<p>&nbsp;</p>
<p><strong>Recommender Information</strong></p>
<p>The following information was provided by the applicant:</p>
<p><strong>Name</strong>: [[RecommenderName]]</p>
<p><strong>Title</strong>: [[RecommenderTitle]]</p>
<p><strong>Relationship</strong>: [[RecommenderRelationship]]</p>
<p><strong>Email</strong>: [[RecommenderEmail]]</p>
<p><strong>Request Date</strong>: [[RecommendationRequestDate]]</p>
<p><strong>IMPORTANT:</strong></p>
<p><strong>Please click this URL if you agree to recommend the applicant</strong></p>
<p>[[RecommendationFormURL]]</p>
EOF
  },
  { #2
    "title" => "[[ApplicantName]] requests your recommendation for positions in [[ProcessName]]",
    "email_type" => "remind_recommender",
    "content" => <<-EOF
<p><strong>Dear </strong>[[RecommenderName]],</p>
<p>&nbsp;</p>
<p><strong>[[ApplicantName]]</strong> is seeking the following position(s) on the Stanford staff as follows.</p>
<p>&nbsp;</p>
<p>Process: [[ProcessName]].</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p>If you have questions regarding this position or recommendation, please direct responses to the applicant directly at [[ApplicantEmail]].</p>
<p><strong>Please submit this recommendation </strong>[[RecommendationEndDate]]. To see if your recommendation was successfully received, you may check the applicant, who can view their application status at any time. We suggest that you keep a copy of this recommendation on your computer in case of a submission problem.</p>
<p>&nbsp;</p>
<p><strong>Recommender Information</strong></p>
<p>The following information was provided by the applicant:</p>
<p><strong>Name</strong>: [[RecommenderName]]</p>
<p><strong>Title</strong>: [[RecommenderTitle]]</p>
<p><strong>Relationship</strong>: [[RecommenderRelationship]]</p>
<p><strong>Email</strong>: [[RecommenderEmail]]</p>
<p><strong>Request Date</strong>: [[RecommendationRequestDate]]</p>
<p><strong>IMPORTANT:</strong></p>
<p><strong>Please click this URL if you agree to recommend the applicant</strong></p>
<p>[[RecommendationFormURL]]</p>
EOF
  },
  { #3
    "title" => "Regarding your request for recommendation to [[RecommenderName]]",
    "email_type" => "notice_applicant_send",
    "content" => <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>Thank you for requesting the recommendation as follows. &nbsp;The recommendation deadline is <strong>&nbsp;</strong>[[RecommendationEndDate]].</p>
<p>&nbsp;</p>
<p>The recommender may check with you for the recommendation status.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p><strong>Recommender Information</strong></p>
<p>The following information was provided by the applicant:</p>
<p><strong>Name</strong>: [[RecommenderName]]</p>
<p><strong>Title</strong>: [[RecommenderTitle]]</p>
<p><strong>Relationship</strong>: [[RecommenderRelationship]]</p>
<p><strong>Email</strong>: [[RecommenderEmail]]</p>
<p><strong>Request Date</strong>: [[RecommendationRequestDate]]</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #4
    "title" => "Thank you for your recommendation for [[ApplicantName]]",
    "email_type" => "notice_recommender_submit",
    "content" => <<-EOF
<p><strong>Dear [[RecommenderName]],</strong></p>
<p>&nbsp;</p>
<p>Thank you for your recommendation for [[ApplicantName]]. &nbsp;</p>
<p>&nbsp;</p>
<p>You may check with [[ApplicantName]] at [[ApplicantEmail]] for the recommendation status.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p><strong>Recommender Information</strong></p>
<p>The following information was provided by the applicant:</p>
<p><strong>Name</strong>: [[RecommenderName]]</p>
<p><strong>Title</strong>: [[RecommenderTitle]]</p>
<p><strong>Relationship</strong>: [[RecommenderRelationship]]</p>
<p><strong>Email</strong>: [[RecommenderEmail]]</p>
<p><strong>Request Date</strong>: [[RecommendationRequestDate]]</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #5
    "title" => "Recommender  [[RecommenderName]] has submitted the recommendation for you!",
    "email_type" => "notice_applicant_get",
    "content" => <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>Your recommender &nbsp;[[RecommenderName]] has submitted the recommendation form. <strong>&nbsp;</strong></p>
<p>&nbsp;</p>
<p>The recommender may check with you for the recommendation status.</p>
<p>&nbsp;</p>
<p><strong>Recommender Information</strong></p>
<p>The following information was provided by the applicant:</p>
<p><strong>Name</strong>: [[RecommenderName]]</p>
<p><strong>Title</strong>: [[RecommenderTitle]]</p>
<p><strong>Relationship</strong>: [[RecommenderRelationship]]</p>
<p><strong>Email</strong>: [[RecommenderEmail]]</p>
<p><strong>Request Date</strong>: [[RecommendationRequestDate]]</p>
<p>&nbsp;</p>
<p>You can check the recommendation status of your application.</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  # The two emails about submitting application.
  { #1
    "title" => "Thank you for the submission of your application",
    "email_type" => "submission_application",
    "content" => <<-EOF
Dear [[FirstName]],<br>
<br>
Thanks for the submission of your application for the following position(s).<br>
<br>
[[Positions]]<br>
<br>
We will notify you for the interview if you are qualified for the position(s).<br>
<br>
Sincerely Yours,<br>
<br>
Hiring Manager<br>
[[HiringManagerName]]<br>
Stanford University<br>
EOF
  },
  { #2
    "title" => "Withdrawal of your application",
    "email_type" => "withdraw_application",
    "content" => <<-EOF
Dear [[FirstName]],<br>
<br>
You have withdrawn your application for the following position(s).<br>
<br>
[[Positions]]<br>
<br>
You can re-submit your application before the application deadline.<br>
<br>
Sincerely Yours,<br>
<br>
Hiring Manager<br>
[[HiringManagerName]]<br>
EOF
  },
  # The one email about offer.
  { #1
    "title" => "Offer Email",
    "email_type" => "offer_email",
    "content"=> <<-EOF
<p><strong>Dear </strong><strong><span style="color: #ff0000;">[[ApplicantName]]</span>,</strong> <br /> <br /> Congratulations! You have been selected to serve in the following position(s).<br /> <span style="color: #ff0000;"><strong>Process:</strong> [[ProcessName]].</span></p>
<p><span style="color: #ff0000;"><strong>Position(s): </strong>[[Positions]]</span></p>
<p><br /> You will be sent an email with your assignment and training requirements.</p>
<p>You'll be sent a link, which will confirm that you accept the assignment and must be completed no later than <span style="color: #ff0000;">[[Due Date]]</span>.<br /> </p>
<p>Welcome to the <span style="color: #ff0000;">[[ProcessName]]</span> Program. We're very excited to have you join our team, and look forward to be working with you .</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p><span style="color: #ff0000;">[[HiringManagerName]]</span></p>
<p>Stanford University</p>
EOF
  },
  # This is new interviews email
  { #1
    "title" => "Interview Invitation",
    "email_type" => "interview_mgr_select_applicant",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>You are invited to sign up for the following interview.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p>[[SignUpInterviewURL]] &nbsp;(Go to sign up interviews)</p>
<p><br /><br /></p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #2
    "title" => "Interview Invitation Cancellation",
    "email_type" => "interview_mgr_cancel_select_applicant",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>You have been cancelled to sign up the following interview.<br /><br /></p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>&nbsp;</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p><em><br /></em>Please send any questions to: [[HiringManagerEmail]]</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #3
    "title" => "Interview Notice",
    "email_type" => "interview_mgr_schedule_applicant",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>Congratulations! <em><br /></em>You have been scheduled for the following interview.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p>&nbsp;</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p>&nbsp;</p>
<p>Please plan on arriving 5 mins, before your assigned time so that we can keep to our tight schedule. <br /><br /></p>
<p>We look forward to meeting with you soon.</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #4
    "title" => "Interview Cancellation",
    "email_type" => "interview_mgr_cancel_schedule_applicant",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>You have been cancelled to attend the following interview.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]<br /><br /></p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p><em><br /></em>Please send any questions to: [[HiringManagerEmail]]</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #5
    "title" => "Interview Invitation for Interviewers",
    "email_type" => "interview_mgr_select_interviewer",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]],</strong></p>
<p>We'd like to invite you to be our Interviewer. Please sign up for the following interview.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>[[SignUpInterviewURL]] &nbsp;(Go to sign up interviews)</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #6
    "title" => "Interview Invitation Cancellation for Interviewers",
    "email_type" => "interview_mgr_cancel_select_interviewer",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]],</strong></p>
<p>You have been cancelled to sign up the following interview as an Interviewer.</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p>&nbsp;</p>
<p>Please send any questions to: [[HiringManagerEmail]]</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #7
    "title" => "Interview Notice for Interviewers",
    "email_type" => "interview_mgr_schedule_interviewer",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]],</strong></p>
<p>&nbsp;</p>
<p>You have been scheduled for the following interview as an Interviewer.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p>&nbsp;</p>
<p>We look forward to meeting with you soon.</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #8
    "title" => "Interview Cancellation for Interviewers",
    "email_type" => "interview_mgr_cancel_schedule_interviewer",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]],</strong></p>
<p>You have been cancelled to attend the following interview as an Interviewer.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p><br /><br /></p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p>&nbsp;</p>
<p>Please send any questions to: [[HiringManagerEmail]]</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #9
    "title" => "Interview confirmation",
    "email_type" => "interview_applicant_schedule_to_self",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>You have signed up for the following interview.</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p>&nbsp;</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p><br /><br /></p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #10
    "title" => "Interview Cancellation by Applicants",
    "email_type" => "interview_applicant_cancel_schedule_to_self",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]],</strong></p>
<p>&nbsp;</p>
<p>You have cancelled to attend the following interview.</p>
<p>&nbsp;</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]<br /><br /></p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p><em><br /></em>Please send any questions to: [[HiringManagerEmail]]</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>&nbsp;</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #11
    "title" => "Interview confirmation for Interviewers",
    "email_type" => "interview_interviewer_schedule_to_self",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]], </strong></p>
<p>&nbsp;</p>
<p>You have signed up for the following interview.</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { #12
    "title" => "Interview Cancellation by Interviewers",
    "email_type" => "interview_interviewer_cancel_schedule_to_self",
    "content"=> <<-EOF
<p><strong>Dear [[InterviewerName]], </strong></p>
<p>&nbsp;</p>
<p>You have cancelled to attend the following interview.</p>
<p><strong>Process: </strong>[[ProcessName]]</p>
<p><strong>Round</strong>: [[Round]]</p>
<p><strong>Interview</strong>: [[Interview]]</p>
<p><strong>Position(s): </strong>[[Positions]]</p>
<p><strong>Time</strong>: [[InterviewTime]]</p>
<p><br /><br /></p>
<p>[[ViewInterviewURL]] (Go to view interviews)</p>
<p><em><br /></em>Please send any questions to: [[HiringManagerEmail]]</p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p>[[HiringManagerName]]</p>
<p>Stanford University</p>
EOF
  },
  { # Post Match
    #1
    "title" => "Post Match Invitation for Applying [[Positions]]",
    "email_type" => "post_match_invitation",
    "content"=> <<-EOF
<p><strong>Dear [[ApplicantName]]</strong>,</p>
<p>&nbsp;</p>
<p>You are invited for applying the following position after the first round of match or post match.</p>
<p>&nbsp;</p>
<p><strong>Process:</strong> [[ProcessName]]</p>
<p><strong>Interview:</strong> [[Interview]]</p>
<p><strong>Position(s):</strong> [[Positions]]</p>
<p>&nbsp;</p>
<p>You may still sign up the interviews for the following position(s) you have selected before.</p>
<p><strong>Position(s):</strong> [[AlreadySelectedPositions]]</p>
<p>&nbsp;</p>
<p>You may need to fill more forms for the new positions</p>
<p>Please click the following link to check your post match application status.</p>
<p><strong>[[PostMatchURL]]</strong></p>
<p>&nbsp;</p>
<p>Sincerely Yours,</p>
<p>Hiring Manager</p>
<p><strong>[[HiringManagerName]]</strong></p>
<p>Stanford University</p>
EOF
  },
]

# help landings
help_landings = [
  {
    :doings => "Resident Assistant (RA)",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Peer Tutor, including Resident Tutor (RT)",
    :department => "Center for Teaching and Learning",
    :contact => "CTL Peer Tutor Selection tutoringhelp@stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Peer Health Educator (PHE)",
    :department => "Vaden Health Services",
    :contact => "Colin Campbell cwgc5@stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Graduate Community Associate (CA)",
    :department => "Graduate Life Office",
    :contact => "Marcela Chaverri chaverri@stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Resident Computer Consultant (RCC), including Row, Dorm and Graduate RCCs",
    :department => "Residential Computing",
    :contact => "Sherwin Smith rcc-hiring@acomp.stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Writing Tutor, including Resident Writing Tutor (RWT)",
    :department => "Hume Writing Center",
    :contact => "Clyde Moneyhun writingcenter@stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Summer RA",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Row Student Managers",
    :department => "Row Office",
    :contact => "Zac Sargeant zacs@stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Ethnic Theme Associate (ETA)/Academic Theme Associate (ATA)/Focus Assistant (FA)",
    :department => "Residential Education",
    :contact => "ResEd Theme Team resedthemeteam@lists.stanfordtest.edu",
    :procedure_id => 2
  },
  {
    :doings => "Resident Assistant (RA)",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Peer Tutor, including Resident Tutor (RT)",
    :department => "Center for Teaching and Learning",
    :contact => "CTL Peer Tutor Selection tutoringhelp@stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "chaverri@stanfordtest.edu  Peer Health Educator (PHE)",
    :department => "Vaden Health Services",
    :contact => "Colin Campbell cwgc5@stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Graduate Community Associate (CA)",
    :department => "Graduate Life Office",
    :contact => "Marcela Chaverri chaverri@stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Ethnic Theme Associate (ETA)/Academic Theme Associate (ATA)/Focus Assistant (FA)",
    :department => "Residential Education",
    :contact => "ResEd Theme Team resedthemeteam@lists.stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Writing Tutor, including Resident Writing Tutor (RWT)",
    :department => "Hume Writing Center",
    :contact => "Clyde Moneyhun writingcenter@stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Resident Computer Consultant (RCC), including Row, Dorm and Graduate RCCs",
    :department => "Residential Computing",
    :contact => "Sherwin Smith rcc-hiring@acomp.stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Summer RA",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "Row Student Managers",
    :department => "Row Office",
    :contact => "Zac Sargeant zacs@stanfordtest.edu",
    :procedure_id => 3
  },
  {
    :doings => "chaverri@stanfordtest.edu  Peer Health Educator (PHE)",
    :department => "Vaden Health Services",
    :contact => "Colin Campbell cwgc5@stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Ethnic Theme Associate (ETA)/Academic Theme Associate (ATA)/Focus Assistant (FA)",
    :department => "Residential Education",
    :contact => "ResEd Theme Team resedthemeteam@lists.stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Graduate Community Associate (CA)",
    :department => "Graduate Life Office",
    :contact => "Marcela Chaverri chaverri@stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Writing Tutor, including Resident Writing Tutor (RWT)",
    :department => "Hume Writing Center",
    :contact => "Clyde Moneyhun writingcenter@stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Summer RA",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Row Student Managers",
    :department => "Row Office",
    :contact => "Zac Sargeant zacs@stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Resident Computer Consultant (RCC), including Row, Dorm and Graduate RCCs",
    :department => "Residential Computing",
    :contact => "Sherwin Smith rcc-hiring@acomp.stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Resident Assistant (RA)",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Peer Tutor, including Resident Tutor (RT)",
    :department => "Center for Teaching and Learning",
    :contact => "CTL Peer Tutor Selection tutoringhelp@stanfordtest.edu",
    :procedure_id => 5
  },
  {
    :doings => "Ethnic Theme Associate (ETA)/Academic Theme Associate (ATA)/Focus Assistant (FA)",
    :department => "Residential Education",
    :contact => "ResEd Theme Team resedthemeteam@lists.stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Graduate Community Associate (CA)",
    :department => "Graduate Life Office",
    :contact => "Marcela Chaverri chaverri@stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Summer RA",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Row Student Managers",
    :department => "Row Office",
    :contact => "Zac Sargeant zacs@stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Writing Tutor, including Resident Writing Tutor (RWT)",
    :department => "Hume Writing Center",
    :contact => "Clyde Moneyhun writingcenter@stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Resident Assistant (RA)",
    :department => "Residential Education",
    :contact => "RA Selection raselection@lists.stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Peer Tutor, including Resident Tutor (RT)",
    :department => "Center for Teaching and Learning",
    :contact => "CTL Peer Tutor Selection tutoringhelp@stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Peer Health Educator (PHE)",
    :department => "Vaden Health Services",
    :contact => "Colin Campbell cwgc5@stanfordtest.edu",
    :procedure_id => 7
  },
  {
    :doings => "Resident Computer Consultant (RCC), including Row, Dorm and Graduate RCCs",
    :department => "Residential Computing",
    :contact => "Sherwin Smith rcc-hiring@acomp.stanfordtest.edu",
    :procedure_id => 7
  }
];


system_messages = [
  {:name => "One year up", :identify_name => "one_year_up", :message =>  "<p>You have to have more than one year of</p>\n<p>guaranteed housing remaining in order to select this job.</p>\n<p>If you have further question, please contact the hiring manager</p>\n<p>has_hiring@stanfordtest.edu.</p>"}
]
###########################################################################################
###########################################################################################
LocationMgr.delete_all
Location.delete_all
Interviewee.delete_all
Interview.delete_all
RoleMgr.delete_all
Role.delete_all
Position.delete_all
Application.delete_all
ProcedureMgr.delete_all
RdMgr.delete_all
ProcedureStep.delete_all
ProcedureSubStep.delete_all
ProcedureLanding.delete_all
ProcedureHelpLanding.delete_all
Procedure.delete_all
RecommendationRecord.delete_all
RecommendationSetting.delete_all
User.delete_all
Form.delete_all
FormTranslation.delete_all
UserForm.delete_all
EmailTemplate.delete_all
Applicant.delete_all
PeoplesoftDetail.delete_all
UploadFile.delete_all
Round.delete_all
PositionsInInterview.delete_all
Invite.delete_all
Interviewer.delete_all
TimeSlot.delete_all
TimeSlotInterviewer.delete_all
InterviewEvaluateForm.delete_all
InterviewEvaluate.delete_all
Year.delete_all
Transcript.delete_all
FormTag.delete_all
SystemMessage.delete_all
FormInput.delete_all

Year.create(:id => 1, :name => "2014-2015", :is_current_year => true)

(users_data + standford_users).each do |user|
  user = User.create(user)
  PeoplesoftDetail.create(
   :user_id => user.id,
   :academics => '[{"cumGPA":"3.544","status":"AC","academicPlanType":"IntDisHon","academicPlan":"Ethics in Society (IHn)","academicCareer":"UG","admitTerm":"2011-2012 Autumn","academicLevel":"Senior"},{"cumGPA":"3.544","status":"AC","academicPlanType":"Major","academicPlan":"Science, Tech, \u0026 Soc (BS)","academicCareer":"UG","admitTerm":"2011-2012 Autumn","academicLevel":"Senior"}]',
   :addresses => '[{"address":"7 Old Mill Road, Westport, CT, USA, 06880","type":"HOME"}]',
   :phones => '[{"phoneNumber":"203-246-3587","type":"CELL"}]',
   :academic_standings => '[]'
  )
end

people_soft_users.each do |people_soft_user|
   user = User.create(:year_id => 1, :first_name => ("People_" + people_soft_user["firstName"].to_s), :middle_name => people_soft_user["middleName"], :last_name => people_soft_user["lastName"], :status => "Student", :suid => people_soft_user["suid"], :email => (people_soft_user["email"].to_s + ".fake"), :sunet_id => people_soft_user["sunetId"], :gender => people_soft_user["gender"], :is_get_people_soft => true)
   PeoplesoftDetail.create(:user_id => user.id, :academics => people_soft_user["academics"].to_json, :addresses => people_soft_user["addresses"].to_json, :phones => people_soft_user["phones"].to_json, :academic_standings => people_soft_user["academicStandings"].to_json)
end

applicant_names = ["kimi_applicant", "dev_role_applicant", "dev_location_applicant"]
applicant_names.each_with_index do |name, i|
  id = i + 2000;
  suid = "%08d" % id;
  user = User.create(:id => id, :year_id => 1, :first_name => name, :last_name => "applicant", :suid => suid, :sunet_id => name + id.to_s)
  if ('kimi_applicant' == user.first_name)
    user.email = "kimi@trillioninnovations.com"
  else
    user.email = user.name.gsub(" ", "_") + "@applicant.standford.edu"
  end

  user.save
  Applicant.create(:user_id => user.id, :procedure_id => 1, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 2, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 3, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 4, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 5, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 6, :application_submit_at => Time.now);
  Applicant.create(:user_id => user.id, :procedure_id => 7, :application_submit_at => Time.now);
end

#process 0 default
rank = 0
process_step.each_with_index do |o, i|
  rank += 1
  main_step = ProcedureStep.create(
    :procedure_id => 0, :rank => rank, :name => o["name"], :t_start => o["start"], :t_end => o["end"], :enabled => o["enabled"], :user_view => o["userView"], :url_acronym => o["name"].parameterize
  )
  o["sub_step"].each_with_index do |sub_step, j|
    ProcedureSubStep.create(
      :procedure_step_id => main_step.id, :rank => j + 1, :name => sub_step["name"], :identify_name => sub_step["identify_name"], :t_start => sub_step["start"],
      :t_end => sub_step["end"], :enabled => sub_step["enabled"], :user_view => sub_step["userView"], :url_acronym => sub_step["name"].parameterize
    )
  end
end
default_email_templates.each do |email_template|
  EmailTemplate.create(:title => email_template["title"], :content => email_template["content"], :procedure_id => 0, :email_type => email_template["email_type"], :is_active => true)
end

#default_system_message
system_messages.each do |system_message|
  system_message[:procedure_id] = 0
  SystemMessage.create(system_message)
end


processes_data.each do |process|
  select_position_limit = process["id"].to_i == 5 ? 1 : 0
  procedure = Procedure.create(:id => process["id"], :year_id => 1, :name => process["name"], :status => process["status"], :rank => process["display_order"], :link => process["link"], :acronym => process["acronym"], :select_position_limit => select_position_limit)
  rank = 0
  process_step.each_with_index do |o, i|
    rank += 1
    main_step = ProcedureStep.create(
      :procedure_id => procedure.id, :rank => rank, :name => o["name"], :t_start => o["start"], :t_end => o["end"], :enabled => o["enabled"], :user_view => o["userView"], :url_acronym => o["name"].parameterize
    )
    if o["name"] == "Process"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["process_landing"])
    elsif o["name"] == "Application"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["application_landing"])
    elsif o["name"] == "Interview"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["interview_landing"])
    elsif o["name"] == "Ranking"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["ranking_landing"])
    elsif o["name"] == "Offer"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["offer_landing"])
    elsif o["name"] == "Post Match"
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"], :landing => process["postmatch_landing"])
    else
      ProcedureLanding.create(:procedure_id => procedure.id, :step_name => o["name"])
    end

    o["sub_step"].each_with_index do |sub_step, j|
      ProcedureSubStep.create(
        :procedure_step_id => main_step.id, :rank => j + 1, :name => sub_step["name"], :identify_name => sub_step["identify_name"], :t_start => sub_step["start"],
        :t_end => sub_step["end"], :enabled => sub_step["enabled"], :user_view => sub_step["userView"], :url_acronym => sub_step["name"].parameterize
      )
    end
  end

  ProcedureSubStep.rebuild_post_interview(procedure.id);
=begin
  Round.create_round("First Week of Interviews", Time.now - 7.days, Time.now + 7.days, procedure[:id]);
=end
  default_email_templates.each do |email_template|
    EmailTemplate.create(:title => email_template["title"], :content => email_template["content"], :procedure_id => procedure.id, :email_type => email_template["email_type"], :is_active => true)
  end

  system_messages.each do |system_message|
    system_message[:procedure_id] = procedure.id
    SystemMessage.create(system_message)
  end
  RecommendationSetting.create(:procedure_id => procedure.id, :number => process["recommendations_data"]["number"], :show_recommendation => process["recommendations_data"]["show_recommendation"], :requirement => process["recommendations_data"]["requirement"]) if process.has_key?("recommendations_data")
end

# Help landings
help_landings.each do |help_landing|
  ProcedureHelpLanding.create(:doings => help_landing[:doings], :department => help_landing[:department], :contact => help_landing[:contact], :procedure_id => help_landing[:procedure_id])
end

tags = *("AA".."ZZ")
Procedure.all.select(:id).each do |procedure|
  locations = []
  roles = []
  role_name_to_full_name = {"CM" => "Community Manager", "FM" => "Financial Manager", "KM" => "Kitchen Manager", "RA" => "Resident Assistant", "RCC" => "Resident Computer Consultant", "PHE" => "Peer Health Educator", "ATA" => "Academic Theme Associate", "ETA" => "Ethnic Theme Associate", "DM" => "Dining Manager", "OCT" => "Oral Communications Tutor", "RMC" => "Resident Multimedia Consultant", "RAy" => "#N/A", "DSM" => "Dining Services Manager"}
  case procedure.id
  when 1 #"Dorm and Row Process (RCC)*"
    locations = ["680 Lomita", "717 Dolores", "Arroyo", "BOB", "Branner", "Burbank", "Casa Zapata", "Castano", "Cedro", "Chi Theta Chi", "Columbae", "Crothers", "Delta Delta Delta", "Donner", "Durand", "EBF", "East House", "Florence Moore East (Alondra/Cardenal/Faisan)", "Florence Moore West (Gavilan/Loro/Mirlo/Paloma)", "Freshman Sophomore College", "Grove Mayfield", "Hammarskjold", "Haus Mitteleuropa", "Jerry", "Junipero", "Kairos", "Kappa Alpha", "Kappa Alpha Theta", "Kappa Sigma", "Kimball", "La Casa Italiana", "La Maison Francaise", "Lantana", "Larkin", "Mars", "Mirrelees", "Murray", "Muwekma-tah-ruk", "Naranja", "Narnia", "Okada", "Otero", "Phi Kappa Psi", "Phi Sig", "Pi Beta Phi", "Potter", "Rinconada", "Robinson", "Roble", "Roth", "Serra", "Sigma Alpha Epsilon", "Sigma Chi", "Sigma Nu", "Slavianskii Dom", "Soto", "Storey", "Suites", "Synergy", "Terra", "Theta Delta Chi", "Toyon", "Trancos", "Twain", "Ujamaa", "West Lagunita (Adelfa/Eucalipto/Granada)", "Xanadu", "Yost", "ZAP"]
    roles = ["RCC"]
  when 2 #"Graduate Community Associate (CA)*"
    locations = ["Rains (Single)", "Lyman (Single)", "Munger (Single)", "Escondido Village (Single)", "Munger (Couples)", "Escondido Village (Couples)", "Families"]
    roles = ["CA"]
  when 3 #"Graduate Resident Computer Consultant (RCC)*"
    locations = ["Munger_Studio_Solo", "Munger_Studio_Roommate", "Munger_Studio_Couple", "Munger_1Bed_Solo", "Munger_1Bed_Roommate", "Munger_1Bed_Couples", "Munger_2Bed_Solo", "Munger_2Bed_Roommate", "Munger_2Bed_Couple", "Munger_4Bed_Solo", "Munger_4Bed_Roommate", "Munger_4Bed_Couple", "Schwab_2Bed_Roommate", "Lyman_2Bed_Roommate", "Rains_2Bed_Roommate Rains_4Bed_Roommate", "Escondido Village (studio)_Studio_Solo", "Escondido Village (studio)_Studio_Roommate", "Escondido Village (studio)_Studio_Couples", "Escondido Village (studio)_Studio_Family", "Escondido Village (highrise)_1Bed_Solo", "Escondido Village (highrise)_1Bed_Roommate", "Escondido Village (highrise)_1Bed_Couples", "Escondido Village (highrise)_1Bed_Family", "Escondido Village (lowrise)_2Bed_Solo", "Escondido Village (lowrise)_2Bed_Roommate", "Escondido Village (lowrise)_2Bed_Couples", "Escondido Village (lowrise)_2Bed_Family", "Escondido Village (lowrise)_3Bed_Solo", "Escondido Village (lowrise)_3Bed_Roommate", "Escondido Village (lowrise)_3Bed_Couples", "Escondido Village (lowrise)_3Bed_Family"]
    roles = ["RCC"]
  when 4 #"Peer Health Educator (PHE)*"
    locations = ["Arroyo", "Casa Zapata", "Castano", "Cedro", "Delta Delta Delta", "Donner", "Florence Moore East (Alondra/Cardenal/Faisan)", "Florence Moore West (Gavilan/Loro/Mirlo/Paloma)", "Freshman Sophomore College", "Junipero", "Kappa Alpha Theta", "Kimball", "Lantana", "Larkin", "Mirrelees", "Murray", "Muwekma-tah-ruk", "Okada", "Otero", "Pi Beta Phi", "Rinconada", "Roble", "Serra", "Soto", "Toyon", "Trancos", "Twain", "Ujamaa", "West Lagunita (Adelfa/Eucalipto/Granada)"]
    roles = ["PHE"]
  when 5 #"Pre-Assignment*"
    locations = ["Branner", "Casa Italiana", "Casatano", "576 Alvarado", "Columbae", "Crothers", "East", "EBF", "FroSoCo", "Hammarskjold", "Haus Mitterleuropa", "Kairos", "Kimball", "La Maison Francaise", "Muwekma", "Okada", "Slav Dom", "Storey", "Substance-Free", "Synergy", "Terra", "Ujamaa", "Casa Zapata", "Arroyo", "Castano", "Cedro", "Delta Delta Delta", "Donner", "Florence Moore East (Alondra/Cardenal/Faisan)", "Florence Moore West (Gavilan/Loro/Mirlo/Paloma)", "Freshman Sophomore College", "Junipero", "Kappa Alpha Theta", "Lantana", "Larkin", "Mirrelees", "Murray", "Muwekma-tah-ruk", "Otero", "Pi Beta Phi", "Rinconada", "Roble", "Serra", "Soto", "Toyon", "Trancos", "Twain", "West Lagunita (Adelfa/Eucalipto/Granada)"]
    roles = ["PHE"]
  when 6 #"RA/Manager/Theme and Focus Assistant*"
    locations = ["680 Lomita", "717 Dolores", "Arroyo", "BOB", "Branner", "Burbank", "Casa Zapata", "Castano", "Cedro", "Chi Theta Chi", "Columbae", "Crothers", "Delta Delta Delta", "Donner", "Durand", "EBF", "East House", "Escondido Village", "Florence Moore East (Alondra/Cardenal/Faisan)", "Florence Moore West (Gavilan/Loro/Mirlo/Paloma)", "Freshman Sophomore College", "Grove Mayfield", "Hammarskjold", "Haus Mitteleuropa", "Jerry", "Junipero", "Kairos", "Kappa Alpha", "Kappa Alpha Theta", "Kappa Sigma", "Kimball", "La Casa Italiana", "La Maison Francaise", "Lantana", "Larkin", "Mars", "Mirrielees", "Mirrielees Substance Free", "Murray", "Muwekma-tah-ruk", "Naranja", "Narnia", "Oak Creek", "Okada", "Otero", "Phi Kappa Psi", "Phi Sig", "Pi Beta Phi", "Potter", "Rains", "Rinconada", "Robinson", "Roble", "Roth", "Serra", "Sigma Alpha Epsilon", "Sigma Chi", "Sigma Nu", "Slavianskii Dom", "Soto", "Storey", "Suites", "Synergy", "Terra", "Theta Delta Chi", "Toyon", "Trancos", "Twain", "Ujamaa", "West Lagunita (Adelfa/Eucalipto/Granada)", "Xanadu", "Yost", "ZAP"]
    roles = ["CM", "FM", "KM", "RA", "TA", "ETA", "Coop MGR", "Fix MGR", "ATA", "LCATA"]
  when 7 #House Staff Selection
    locations = ["576 Alvarado", "680 Lomita", "717 Dolores", "Arroyo", "BOB", "Branner", "Burbank", "Casa Zapata", "Castano", "Cedro", "Columbae", "Crothers", "Delta Delta Delta", "Donner", "Durand", "EAST", "East FloMo", "EBF", "FroSoCo", "Grove", "Hammarskjold", "Haus Mitteleuropa", "Jerry", "Junipero", "Kairos", "Kappa Alpha", "Kappa Alpha Theta", "Kappa Sigma", "Kimball", "La Casa Italiana", "La Maison Francaise", "Lantana", "Larkin", "Mars", "Mirrielees", "Murray", "Muwekma-Tah-Ruk", "Naranja", "Narnia", "Oak Creek", "Okada", "Otero", "Phi Kappa Psi", "Phi Sig", "Pi Beta Phi", "Potter", "Rains", "Rinconada", "Robinson", "Roble", "Roth", "Serra", "Sigma Alpha Epsilon", "Sigma Chi", "Sigma Nu", "Slavianskii Dom", "Soto", "Storey", "Suites", "Synergy", "Terra", "Theta Delta Chi", "Toyon", "Trancos", "Twain", "Ujamaa", "West FloMo", "West Lag", "Xanadu", "Yost", "ZAP"]
    roles = ["CM", "FM", "KM", "RA", "RCC", "PHE", "ATA", "ETA", "DM", "OCT", "RMC", "RAy", "DSM"]
  end

  locations.each do |location|
    Location.create(:procedure_id => procedure.id, :name => location, :tag => tags.sample)
  end
  roles.each do |role|
    description = procedure.id == 7 ? role_name_to_full_name[role] : nil
    Role.create(:procedure_id => procedure.id, :name => role, :tag => tags.sample, :description => description)
  end

  if procedure.id == 6 #"RA/Manager/Theme and Focus Assistant*"
    Location.where(:procedure_id => procedure.id).each do |location|
      Role.where(:procedure_id => procedure.id).each do |role|
        next if !ra_positions[[location.name, role.name]]
        Position.create(:role_id => role.id, :procedure_id => procedure.id, :location_id => location.id, :vacancy => (rand(3) + 1), :tag => tags.sample)
      end
    end
  elsif procedure.id == 7 #House Staff Selection
    Location.where(:procedure_id => procedure.id).each do |location|
      Role.where(:procedure_id => procedure.id).each do |role|
        next if !hss_positions[[location.name, role.name]]
        Position.create(:role_id => role.id, :procedure_id => procedure.id, :location_id => location.id, :vacancy => hss_positions[[location.name, role.name]][1], :tag => tags.sample)
      end
    end
  else
    role = Role.where(:procedure_id => procedure.id).first
    Location.where(:procedure_id => procedure.id).each do |location|
      Position.create(:procedure_id => procedure.id, :role_id => role.id, :location_id => location.id, :vacancy => (rand(3) + 1), :tag => tags.sample)
    end
  end
end

forms.each do |o|
  creating_form = Form.create(:procedure_id => o["process_id"], :form_name => o["form_name"], :display => o["display"], :html => o["form"], :schema => o["schema"], :form_type => o["type"])
  if o["type"] == "Application"
    if o["location_tag_name"]
      location_tag_id = Location.where(:procedure_id => o["process_id"], :name => o["location_tag_name"]).pluck(:id).first
      FormTag.create(:form_id => creating_form.id, :role_id => nil, :location_id => location_tag_id, :position_id => nil)
    else
      FormTag.create(:form_id => creating_form.id, :role_id => nil, :location_id => nil, :position_id => nil)
    end
  end
end

default_forms.each_with_index do |o, index|
  Form.create(:procedure_id => 0, :form_name => o["form_name"], :display => o["display"], :html => o["form"], :schema => o["schema"], :form_type => o["type"])
  if o["type"] == "Application"
    FormTag.create(:form_id => creating_form.id, :role_id => nil, :location_id => nil, :position_id => nil)
  end
end

form_translations.each do |o|
  FormTranslation.create(:translate_key => o["translate_key"], :match_column => o["match_column"], :description => o["description"])
end

=begin
users = User.where("id >= 2000")#applicant

Position.where(:procedure_id => 2).each do |position|
  users.each do |user|
    begin
      if (2000 == user.id)
        begin
          Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait")
          applicant = Applicant.where(:user_id => user.id, :procedure_id => position.procedure_id)
          Applicant.create(:user_id => user.id, :procedure_id => position.procedure_id) if applicant.blank?
        end
      #elsif (2001 == user.id || 2002 == user.id)
        # other function
      #elsif (2002 < user.id && 2015 > user.id)
      #  Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait") if [true,false].sample
      else
        begin
          Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait") if [true,false].sample
          applicant = Applicant.where(:user_id => user.id, :procedure_id => position.procedure_id)
          Applicant.create(:user_id => user.id, :procedure_id => position.procedure_id) if applicant.blank?
        end
      end
    end
  end
end

if STANFORD68
  Position.where(:procedure_id => 7).each do |position|
    users.each do |user|
      begin
        if (2000 <= user.id && 2002 > user.id)
          begin
            Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait")
            applicant = Applicant.where(:user_id => user.id, :procedure_id => position.procedure_id)
            Applicant.create(:user_id => user.id, :procedure_id => position.procedure_id) if applicant.blank?
          end
        #elsif (2001 == user.id || 2002 == user.id)
          # other function
        #elsif (2002 < user.id && 2005 > user.id)
        #  Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait") if [true,false].sample
        else
          begin
            Application.create(:user_id => user.id, :position_id => position.id, :offered => "wait") if [true,false].sample
            applicant = Applicant.where(:user_id => user.id, :procedure_id => position.procedure_id)
            Applicant.create(:user_id => user.id, :procedure_id => position.procedure_id) if applicant.blank?
          end
        end
      end
    end
  end
end

=end


mgrs = User.where("id < 2000")

#{'id'=>7, 'first_name'=>'dev_mgr_role', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_role', 'suid'=>'00000003', 'email'=>'dev_mgr_role@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>8, 'first_name'=>'dev_mgr_location', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_location', 'suid'=>'00000004', 'email'=>'dev_mgr_location@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>9, 'first_name'=>'dev_mgr_hiring', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_mgr_hiring', 'suid'=>'00000005', 'email'=>'dev_mgr_hiring@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>10, 'first_name'=>'dev_some_mgr_role', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_some_mgr_role', 'suid'=>'00000006', 'email'=>'dev_some_mgr_role@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>11, 'first_name'=>'dev_some_mgr_location', 'last_name'=>'', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'dev_some_mgr_location', 'suid'=>'00000007', 'email'=>'dev_some_mgr_location@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>12, 'first_name'=>'Douglas', 'last_name'=>'Calhoun', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'douglasc', 'suid'=>'douglasc', 'email'=>'douglasc@stanfordtest.edu', 'year_id'=>'1'},
#{'id'=>13, 'first_name'=>'Spencer', 'last_name'=>'Atkinson', 'status'=>'Staff', 'is_admin'=> false, 'sunet_id' => 'satkinso', 'suid'=>'satkinso', 'email'=>'satkinso@stanfordtest.edu', 'year_id'=>'1'},

Role.all.each do |role|
  RoleMgr.create(:role_id => role.id, :user_id => 11);
  UserProcedure.create(:user_id => 11, :procedure_id => role.procedure_id)
end

Location.all.each do |location|
  LocationMgr.create(:location_id => location.id, :user_id => 12);
  UserProcedure.create(:user_id => 12, :procedure_id => location.procedure_id)
end

Procedure.all.each do |procedure|
  [13].each do |user_id|
    ProcedureMgr.create(:procedure_id => procedure.id, :user_id => user_id)
    UserProcedure.create(:user_id => user_id, :procedure_id => procedure.id)
  end
end



#  {"id"=>10, "first_name"=>"dev_some_mgr_role", "last_name"=>"", "status"=>"Staff", "system"=> false, "sunet_id" => "dev_some_mgr_role"},
#  {"id"=>11, "first_name"=>"dev_some_mgr_location", "last_name"=>"", "status"=>"Staff", "system"=> false, "sunet_id" => "dev_some_mgr_location"}

dev_procedure = Procedure.create(:year_id => 1, :name => "Development", :acronym => "DEV")
dev_procedure.clone_procedure(2)
Round.create(:id => 1, :title => 'Development', :procedure_id => dev_procedure.id, :t_start => Time.now - 3.days, :t_end => Time.now + 3.days)

Applicant.create(:user_id => 2000, :procedure_id => dev_procedure.id, :application_submit_at => Time.now);

Procedure.all.select(:id).each do |procedure|
  max_limit = 3;

  dev_role = Role.create(:procedure_id => procedure.id, :name => "dev_role", :tag => "dev", :description => "dev_description");
  dev_location = Location.create(:procedure_id => procedure.id, :name => "dev_location", :tag => "dev");

  role_mgr = RoleMgr.create(:role_id => dev_role.id, :user_id => 14);
  UserProcedure.create(:user_id => 14, :procedure_id => procedure.id)
  location_mgr = LocationMgr.create(:location_id => dev_location.id, :user_id => 15);
  UserProcedure.create(:user_id => 15, :procedure_id => procedure.id)


  procedure_roles = Role.where(:procedure_id => procedure.id).limit(max_limit);
  procedure_locations = Location.where(:procedure_id => procedure.id).limit(max_limit);

  procedure_roles.each do |role|
    position = Position.create(:procedure_id => procedure.id, :role_id => role.id, :location_id => dev_location.id, :vacancy => (rand(3) + 1), :tag => "dev")
    if position.present?
      begin
        Application.create(:user_id => 2000, :position_id => position.id, :offered => "wait");
        applicant = Applicant.where(:user_id => 2000, :procedure_id => procedure.id)
        Applicant.create(:user_id => 2000, :procedure_id => procedure.id) if applicant.blank?
      end
      begin
        Application.create(:user_id => 2001, :position_id => position.id, :offered => "wait");
        applicant = Applicant.where(:user_id => 2001, :procedure_id => procedure.id)
        Applicant.create(:user_id => 2001, :procedure_id => procedure.id) if applicant.blank?
      end
    end
  end

  procedure_locations.each do |location|
    position = Position.create(:procedure_id => procedure.id, :role_id => dev_role.id, :location_id => location.id, :vacancy => (rand(3) + 1), :tag => "dev")
    if position.present?
      begin
        aa = Application.where(:user_id => 2000, :position_id => position.id).first;
        if (aa.blank?)
          Application.create(:user_id => 2000, :position_id => position.id, :offered => "wait");
          applicant = Applicant.where(:user_id => 2000, :procedure_id => procedure.id)
          Applicant.create(:user_id => 2000, :procedure_id => procedure.id) if applicant.blank?
        end
      end
      begin
        aa = Application.where(:user_id => 2001, :position_id => position.id).first;
        if (aa.blank?)
          Application.create(:user_id => 2001, :position_id => position.id, :offered => "wait");
          applicant = Applicant.where(:user_id => 2001, :procedure_id => procedure.id)
          Applicant.create(:user_id => 2001, :procedure_id => procedure.id) if applicant.blank?
        end
      end
    end
  end
end

# Let's back up the interview in Pre
alina_back_up_interview = Round.create(:title => "Interview One", :procedure_id => 5, :erasable => 1, :t_start => Time.now, :t_end => Time.now + 3.days)
the_step_id_alina_back_up_interview = ProcedureStep.where(:procedure_id => alina_back_up_interview.procedure_id, :name => "Interview").pluck(:id).first
ProcedureSubStep.create(
  :procedure_step_id => the_step_id_alina_back_up_interview,
  :rank => 2,
  :enabled => true,
  :name => alina_back_up_interview.title,
  :identify_name => "interview" + alina_back_up_interview.id.to_s,
  :t_start => alina_back_up_interview.t_start,
  :t_end => alina_back_up_interview.t_end,
  :url_acronym => alina_back_up_interview.title.parameterize
)
alina_create_name_in_interview = [
  "Branner",
  "Casa Italiana",
  "Castano",
  "Columbae",
  "Crothers",
  "East",
  "Synergy",
  "Terra",
  "Ujamaa",
  "Zapata",
  "EBF",
  "FroSoCo",
  "Hammarskjold",
  "Haus Mitterleuropa",
  "Kairos",
  "Kimball",
  "La Maison Francaise",
  "Muwekma",
  "Okada",
  "Slav Dom",
  "Storey",
  "Substance-Free",
  "576 Alvarado"
]
alina_create_name_in_interview.each do |name|
  Interview.create(
    :vacancy => 1,
    :round_id => alina_back_up_interview.id,
    :one_time_slot_per_applicant => true,
    :interviewer_can_edit => true,
    :interviewer_can_schedule => true,
    :interviewer_vacancy => 1,
    :max_time_slot_per_interviewer => 1,
    :name => name
  )
end







