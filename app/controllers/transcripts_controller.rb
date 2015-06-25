class TranscriptsController < ApplicationController

  def create123
    ts = [
      "2014-2015 Autumn,UG,MS&E,193,Technology and National Security,,3,Y,Y",
      "2014-2015 Autumn,UG,ME,115A,Introduction to Human Values in Design,,3,Y,Y",
      "2013-2014 Summer,UG,DANCE,15AX,Scene in Action: Dance Fashion and Visual Art as Performance,,2,Y,N",
      "2013-2014 Spring,UG,BIOS,222,Authentic Courage for Constructive Change: Skills and Practice for Leadership,S,1,Y,N",
      "2013-2014 Spring,UG,POLISCI,110Y,War and Peace in American Foreign Policy,B-,5,Y,Y",
      "2013-2014 Spring,UG,MS&E,152,Introduction to Decision Analysis,C-,3,Y,Y",
      "2013-2014 Spring,UG,HISTORY,44,History of Women and Gender in Science Medicine and  Engineering,A,3,Y,Y",
      "2013-2014 Winter,UG,MS&E,197,Ethics Technology and Public Policy,C,5,Y,Y",
      "2013-2014 Winter,UG,DANCE,31,Chocolate Head-Space: Crowd-Sourced Performance Experience,S,2,Y,N",
      "2013-2014 Winter,UG,ETHICSOC,170,Ethical Theory,B,4,Y,Y",
      "2013-2014 Winter,UG,ME,368,d.Leadership: Design Leadership in Context,A,3,Y,Y",
      "2013-2014 Winter,UG,CLASSART,113,Ten Things: An Archaeology of Design,A-,3,Y,Y",
      "2013-2014 Winter,UG,ETHICSOC,190,Ethics in Society Honors Seminar,B-,3,Y,Y",
      "2013-2014 Autumn,UG,ME,101,Visual Thinking,A,4,Y,Y",
      "2013-2014 Autumn,UG,SOC,114,Economic Sociology,A-,4,Y,Y",
      "2013-2014 Autumn,UG,ENGR,140C,Leadership of Technology Ventures,A,2,Y,Y",
      "2013-2014 Autumn,UG,HUMBIO,82B,Advanced Data Analysis in Qualitative Research,A-,3,Y,Y",
      "2013-2014 Autumn,UG,DANCE,30,Chocolate Heads Movement Band Performance Workshop,S,2,Y,N",
      "2013-2014 Autumn,UG,GSBGEN,555,Designing Empathy-Based Organizations,+,1,Y,N",
      "2013-2014 Autumn,UG,HISTORY,299S,Undergraduate Directed Research and Writing,CR,1,Y,N",
      "2012-2013 Spring,UG,MS&E,472,Entrepreneurial Thought Leaders' Seminar,S,1,Y,N",
      "2012-2013 Spring,UG,MATH,51,Linear Algebra and Differential Calculus of Several Variables,CR,5,Y,N",
      "2012-2013 Spring,UG,ENGR,140A,Leadership of Technology Ventures,A,4,Y,Y",
      "2012-2013 Spring,UG,PWR,2AO,Writing & Rhetoric 2:  Rhetoric and Global Leadership,A,4,Y,Y",
      "2012-2013 Spring,UG,URBANST,110,Utopia and Reality: Introduction to Urban Studies,A-,4,Y,Y",
      "2012-2013 Winter,UG,ECON,1A,Introductory Economics A,B,5,Y,Y",
      "2012-2013 Winter,UG,MS&E,271,Global Entrepreneurial Marketing,A,4,Y,Y",
      "2012-2013 Winter,UG,HUMBIO,82A,Qualitative Research Methodology,A-,3,Y,Y",
      "2012-2013 Winter,UG,STRAMGT,368,Strategic Management of Nonprofit Organizations and Social Ventures,H,4,Y,Y",
      "2012-2013 Autumn,UG,POLISCI,51K,Election 2012,S,1,Y,N",
      "2012-2013 Autumn,UG,URBANST,123,Approaching Research and the Community,A+,3,Y,Y",
      "2012-2013 Autumn,UG,CS,106A,Programming Methodology,B-,5,Y,Y",
      "2012-2013 Autumn,UG,MS&E,189,Social Networks - Theory Methods and Applications,A,3,Y,Y",
      "2012-2013 Autumn,UG,PUBLPOL,183,Philanthropy and Social Innovation,A,4,Y,Y",
      "2011-2012 Spring,UG,PWR,1GMU,\"Writing & Rhetoric 1:  \"\"Get Up Stand Up\"\": The Rhetoric of Human Rights and Humanitarianism\",A,4,Y,Y",
      "2011-2012 Spring,UG,MS&E,472,Entrepreneurial Thought Leaders' Seminar,S,1,Y,N",
      "2011-2012 Spring,UG,MS&E,178,The Spirit of Entrepreneurship,A,3,Y,Y",
      "2011-2012 Spring,UG,CSRE,15A,IDA Integrative Seminar: Occupy Art - Immigration Nation and the Art of Occupation,CR,1,Y,N",
      "2011-2012 Spring,UG,PUBLPOL,144,Giving 2.0: Philanthropy by Design,A,2,Y,Y",
      "2011-2012 Spring,UG,FRENLANG,60B,Intermediate French Conversation,S,1,Y,N",
      "2011-2012 Spring,UG,IHUM,73B,Ultimate Meanings: Decoding Religious Stories from around the World,A-,4,Y,Y",
      "2011-2012 Winter,UG,IPS, 271,Sanela Diana Jenkins International Human Rights Colloquium,S,1,Y,N",
      "2011-2012 Winter,UG,IHUM,  73A,Ultimate Meanings: Decoding Religious Stories from around the World,B+,4,Y,Y",
      "2011-2012 Winter,UG,ATHLETIC,  30,Cycling: Indoor,S,1,Y,N",
      "2011-2012 Winter,UG,DRAMA,  11N,Dramatic Tensions: Theater and the Marketplace,A,4,Y,Y",
      "2011-2012 Winter,UG,PORTLANG,   2A,Accelerated First-Year Portuguese Part 2,B,5,Y,Y",
      "2011-2012 Winter,UG,HUMBIO,  96Q,Injustice Advocacy and Courage: The Path of Everyday Heroes,A-,3,Y,Y",
      "2011-2012 Autumn,UG,DANCE, 152,Dance and the Visual Arts: A New Public Dialogue,S,1,Y,N",
      "2011-2012 Autumn,UG,IHUM,  51,Transformations: The Intersection of High Art and Contemporary Culture,A,4,Y,Y",
      "2011-2012 Autumn,UG,ATHLETIC,  23,Core Training,S,1,Y,N",
      "2011-2012 Autumn,UG,PORTLANG,   1A,Accelerated First-Year Portuguese Part 1,A-,5,Y,Y",
      "2011-2012 Autumn,UG,DRAMA,  13N,Law and Drama,A,4,Y,Y",
    ]

    user_ids = User.all.pluck(:id)
    ts.each do |t|
      arr = t.split(",")
      transcripts = Transcript.new
      transcripts.user_id = user_ids[Random.rand(user_ids.length)]
      transcripts.term    = arr[0]
      transcripts.level   = arr[1]
      transcripts.subject = arr[2]
      transcripts.no      = arr[3].gsub(" ", "")
      transcripts.title   = arr[4]
      transcripts.grade   = arr[5]
      transcripts.unit    = arr[6]
      transcripts.credit  = arr[7]
      transcripts.gpa     = arr[8]
      transcripts.save
    end
    render :nothing => true
  end

  def applicant_transcripts
    user = User.find_by_id(params[:user_id])
    if user and User.find_by_id(session[:user_id]).is_staff
      transcript = Transcript.applicant_transcripts(user.id)
      render :json => {:success => true, :grades => transcript}
    else
      render :json => {:success => false}
    end
  end

end
