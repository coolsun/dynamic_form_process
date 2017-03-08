require 'pp'
require 'mathn'
load 'ext/match_gs/custom_log.rb'
load 'ext/match_gs/m_choose_n_lexical.rb'

class GSMatcher

  attr_accessor :students
  attr_accessor :houses
  attr_accessor :positions
  attr_accessor :position_valid_selection_depth
  attr_accessor :position_student_ranking
  attr_accessor :student_hash
  attr_accessor :current_student
  attr_accessor :max_position_student_rank
  attr_accessor :positions_orig

  def initialize(houses, positions, students)
    @houses = houses.present? ? houses : [];
    @positions = positions.present? ? positions : [];
    @students = students.present? ? students : {};

    # use lexical for the first valid selection in the house
    # use m_choose_n_iterator.rb for multiple vacancies and constraints


    # find only the frist valid selection
    @position_valid_selection_depth=1;

    # {:name=>"Nicholas",
    #  :rank=>3,
    #  :status=>:not_selected,
    #  :student_index=>40,
    #  :position_index=>18},
    @position_student_ranking=[];

    @student_hash = {};

    @current_student = [];

    @max_position_student_rank = 0;

    @positions_orig = nil;
  end
end



class MatchGsPosNoGv
  # rowhouse will be matched first.
  # all rowhouse and non-rowhouse will be matched alphabetically
  def self.movePositionsInRowHousesFirst(matcher)

    rowHousePositions = []
    nonRowPositions = []
    matcher.positions.each_with_index { |position, index|
      house = matcher.houses.detect { |e| e[:name] == position[:house] }
      next if house.nil?
      if house[:rowHouse]
        rowHousePositions << position
      else
        nonRowPositions << position
      end
    }
    matcher.positions = rowHousePositions + nonRowPositions
  end

  # output CSV file for the selected students
  def self.outputCSV(matcher, positionStudentRanking)

    for i in 0..matcher.max_position_student_rank-1
      positionStudentRanking.each_with_index { |position, index|
        if !position[i].nil?
          print "#{position[i][:name]},#{position[i][:sex]},#{position[i][:rank]},#{position[i][:status]},"
        else
          print ",,,,"
        end
      }
      print "\n"
    end

  end

  #Output selected students
  def self.outputSeletedStudents(matcher, positionStudentRanking)
    result = [];
    positionStudentRanking.sort_by { |k| matcher.positions[k[0][:position_index]][:name] }

    positionStudentRanking.each_with_index { |psr, index|
      match_position = {};
      match_position["position_id"] = matcher.positions[psr[0][:position_index]][:name];
      match_position["user_ids"] = [];


      psr.each_with_index { |student, si|
        print "#{matcher.positions[student[:position_index]][:name]}:" if si==0
        print ", " if si != 0
        orig_student_index = nil
        position = matcher.positions_orig[student[:position_index]]
        for i in 0..position[:size]-1
          if !position[i].nil? && position[i][0] == student[:name]
            orig_student_index = i
            break;
          end
        end
        print "(#{student[:name]}, #{orig_student_index})"

        match_position["user_ids"] << student[:name];
      }
      print "\n"

      result << match_position;
    }

    return result;
  end

  # if the student does not select the position, remove the student
  def self.removeStudentNotSelectThePositionInPositions(matcher)
    matcher.positions.each_with_index { |position, index|
      for i in 0..position[:size]-1
        if matcher.students[position[i][0]].nil?
          logInfo "Data Error: position has selected student that can not be found!"
          exit
        else
          student = matcher.students[position[i][0]]
          if student[position[:name]].nil?
            matcher.positions[index][i]=nil
          end
        end
      end
    }
    matcher.positions.each_with_index { |position, index|
      consolidatedPosition = position.clone
      currentIndex = 0
      for i in 0..position[:size]-1
        if !position[i].nil?
          if currentIndex != i
            consolidatedPosition[currentIndex]=position[i].clone
            consolidatedPosition[i]=nil
          end
        else
          next
        end
        currentIndex += 1;
      end
      consolidatedPosition[:size]=currentIndex
      matcher.positions[index] = consolidatedPosition
    }
  end

  # check the constraint by checking the current selection
  def self.checkConstraint(position, currentArray)
    if (position[:rule].nil? || position[:rule]=="")
      return true
    end
    nMale = 0;
    nFemale = 0;
    nOther = 0;
    currentArray.each { |student|
      nMale += 1 if position[student][1] == "Male";
      nFemale += 1 if position[student][1] == "Female";
      nOther += 1 if position[student][1] == "Other";
    }

    ruleResult = position[:rule].sub("m", nMale.to_s).sub("f", nFemale.to_s).sub("o", nOther.to_s)

    return eval(ruleResult);

  end


  # A quick factorial function
  def self.factorial(n=0)
    return 1 if n==0
    (1..n).inject(:*)
  end

  # A quick n Choose k function
  def self.n_choose_k(n, k)
    return 0 if n < k
    factorial(n) / (factorial(k) * factorial(n - k))
  end


  # get the first valid selection for each position
  def self.findFirstValidSelectionForAllPositions(matcher)
    matcher.positions.each_with_index { |position, index|
      findFirstValidSelectionForPosition(matcher, position, index)
    }
  end

  # get the first valid selection for each position
  # return the level to keep track the highest level
  def self.findFirstValidSelectionForPosition(matcher, position, index)
    currentArray = nil
    n = position[:size]
    iValid = 0
    validSelection = []
    k = position[:vacancies]
    nck = n_choose_k(n, k)
    for i in 1..nck
      logDebug "position[:name]=#{position[:name]}, i=#{i}"
      stop, currentArray = nexksb n, k, currentArray
      currentArray_no_last_h = currentArray[0..-2].map{|x| x-1 }
      isValid = checkConstraint(position, currentArray_no_last_h)
      if isValid
        iValid += 1
        validSelection << currentArray_no_last_h
        logDebug "position[:name]=#{position[:name]}, currentArray_no_last_h=#{currentArray_no_last_h}"
      end
      break if stop || iValid == matcher.position_valid_selection_depth
    end
    matcher.positions[index]["validSelection"]=validSelection;
    matcher.positions[index]["validSelectionSize"]=validSelection.size();
  end

  # reset valid selection for each position
  # move the conflict spot downward until a new one is found
  def self.resetSelectionForPosition(matcher, position, index, student_index)

    # size of student in the position will be impacted by :rejected flag
    # currentArray

    nextArray = position["currentSelection"].clone
    n = position[:size]
    validSelection = []
    k = position[:vacancies].to_i
    nck = n - student_index - 1
    levelFound = nil
    nextArray.delete(student_index)
    for i in 1..nck
      logDebug "position[:name]=#{position[:name]}, i=#{i}"
      nextArray << student_index + i
      nextArray.uniq!
      next if nextArray.size != position["currentSelectionSize"]
      isValid = checkConstraint(position, nextArray)
      if isValid
        matcher.positions[index]["currentSelection"]=nextArray
        matcher.positions[index]["currentSelectionSize"]=nextArray.size;
        nextArray.each_with_index { |s, index_s|
          matcher.position_student_ranking[index][s][:status] = :selected;
        }
        logDebug "position[:name]=#{position[:name]}, nextArray=#{nextArray}"
        levelFound = student_index + i
        break;
      else
        nextArray.delete(student_index+i)
      end
    end
    return levelFound
  end

  # use studentHash to track duplicate student
  # studentHash = {}
  # {:name=>"Nicholas",
  #  :rank=>nil,
  #  :status=>:not_selected,
  #  :student_index=>40,
  #  :position_index=>18},
  def self.checkConflict(matcher, level)
    nextLevel = level+1;
    logDebug "checkConflict::level=#{level}, nextLevel=#{nextLevel} <<"
    matcher.positions.each_with_index { |position, index|
      position = matcher.positions[index]
      student = matcher.position_student_ranking[index][level]
      next if student.nil? || student[:status] != :selected
      student_name = student[:name]
      selected_student = matcher.student_hash[student_name]

      # handle selecte_student is nil
      if selected_student.nil?
        matcher.student_hash[student_name] = student
        next
      end

      if selected_student[:position_index]==student[:position_index]
        next
      end

      logInfo "#{student_name}: #{position[:name]}##{student[:rank]} vs #{matcher.positions[selected_student[:position_index]][:name]}##{selected_student[:rank]}"

      # both selected_student and student are not nil

      if (selected_student[:rank] < student[:rank])
        logInfo "reject: #{student_name}@#{position[:name]}-"
        matcher.position_student_ranking[index][level][:status] = :rejected
        # reset selected position
        resetSelectionForPosition(matcher, position, index, level);
        next;
      else
        logInfo "reject: #{student_name}@#{matcher.positions[selected_student[:position_index]][:name]}"
        matcher.student_hash[student_name] = student
        matcher.position_student_ranking[selected_student[:position_index]][selected_student[:student_index]][:status] = :rejected
        # reset selected position for selected_student
        resetLevel = resetSelectionForPosition(matcher, matcher.positions[selected_student[:position_index]], selected_student[:position_index], selected_student[:student_index]);
        logDebug "resetLevel=#{resetLevel}, nextLevel=#{nextLevel}"
        # resetLevel if going up(lower), then move the nextLevel to the resetLevel
        if resetLevel < nextLevel
          nextLevel = resetLevel
        end
        next;
      end
    }
    logDebug "checkConflict::level=#{level}, nextLevel=#{nextLevel} >>"
    return nextLevel;
  end

  # set up position_student_ranking as follows for quick comparison
  # {:name=>"Nicholas",
  #  :rank=>3,
  #  :status=>:not_selected,
  #  :student_index=>40,
  #  :position_index=>18}
  # :name => student name
  # :rank => student's rank for the position
  # :status => :selected, :not_selected, :rejected
  # :student_index => student's index(order) in the position
  # :position_index => position's index in all the matcher.positions
  def self.setUpPositionStudentRanking(matcher)

    matcher.positions.each_with_index { |position, index|
      matcher.current_student << position["validSelection"][0];
      matcher.positions[index]["currentSelection"] = position["validSelection"][0].clone;
      matcher.positions[index]["currentSelectionSize"] = position["validSelection"][0].size;
    }

    matcher.positions.each_with_index { |position, index|
      for i in 0..position[:size]-1
        if !position[i].nil? && position[i][0] != ""
          student = position[i][0]
          matcher.position_student_ranking[index] = [] if matcher.position_student_ranking[index].nil?
          # matcher.position_student_ranking with :name => student_name, :rank=>position_ranking_by_the_student,
          # :status=>(:not_selected, :selected, :rejected), :student_index, :position_index => number
          matcher.position_student_ranking[index][i]={:name=>student, :rank=>matcher.students[student][position[:name]],
            :sex=>matcher.students[student][:sex],:status=>:not_selected, :student_index=>i, :position_index=> index}
        end
      end
    }


    matcher.current_student.each_with_index { |student, index|
      student.each_with_index { |s, i|
        matcher.position_student_ranking[index][s][:status] = :selected;
      } if !student.nil?
    }

  end

  # get max number of matcher.students ranked in the all matcher.positions
  # This is for looping through all matcher.students
  def self.setMaxPositionStudentRank(matcher)
    matcher.positions.each { |position|
      matcher.max_position_student_rank = position[:size] if !position[:size].nil? && position[:size] > matcher.max_position_student_rank
    }
    logDebug "$max_position_student_rank=#{$max_position_student_rank}"
  end

  # if all currentSelection is less than the level, then it is complete
  def self.checkComplete(matcher, level)
    matcher.positions.each_with_index { |position, index|
      return false if position["currentSelection"].max > level
    }
    return true;
  end

  # deleted all students that are not :selected (ie :rejected or :not_selected)
  def self.filterStudent(matcher)
    selected_students = matcher.position_student_ranking
    selected_students.each {|x| x.delete_if {|y| y[:status]!=:selected}}
    selected_students
  end


  def self.findByGS(matcher)

      matcher.student_hash = {}
      level = 0
      while level < matcher.max_position_student_rank
        # returns the highest conflict level
        nextLevel = checkConflict(matcher, level)
        if nextLevel < level
          #go up the nextLevel again if the nextLevel is higher
          level = nextLevel
          next
        else
          level = nextLevel
        end

        #check complete only when the nextLevel == level
        if checkComplete(matcher, level)
          logDebug "Completed!  found Solution!!"
          break;
        end
      end
  end

  # This is to copy the whole object tree
  # unlike clone or dup, deepCopy will copy all reference inside the object tree
  def self.deepCopy(obj)
    Marshal.load(Marshal.dump(obj))
  end


  def self.do_match(locations, positions, students)
    Rails.logger.info("@@@");
    Rails.logger.info("@@@ locations");
    Rails.logger.info(locations);
    Rails.logger.info("@@@ positions");
    Rails.logger.info(positions);
    Rails.logger.info("@@@ students");
    Rails.logger.info(students);
    Rails.logger.info("@@@");


    matcher = GSMatcher.new(locations, positions, students);

    logDebug matcher.students, $USE_PP;
    logDebug "matcher.students.size=#{matcher.students.size}", $USE_PP;

    # row house will select matcher.students first
    movePositionsInRowHousesFirst(matcher);

    # keep a copy of matcher.positions to find the original student index
    matcher.positions_orig = deepCopy(matcher.positions)

    # if the student does not select the position, then remove the student.
    removeStudentNotSelectThePositionInPositions(matcher);

    # find the first valid selection
    findFirstValidSelectionForAllPositions(matcher);


    fail_positions = [];
    b_ValidSelection = nil;
    matcher.positions.each do |position|
      if (0 == position["validSelectionSize"])
        fail_positions << position;
        b_ValidSelection = false;
      end
    end

    if (false == b_ValidSelection)
      return ({
        b_ValidSelection:  b_ValidSelection,
        fail_positions: fail_positions
      });
    end

    logDebug matcher.houses, $USE_PP;

    logDebug matcher.positions, $USE_PP;
    logDebug "matcher.positions.size=#{matcher.positions.size}", $USE_PP;

    # set up position student ranking
    setUpPositionStudentRanking(matcher)

    # get the max student rank for going through max level
    setMaxPositionStudentRank(matcher);

    #outputCSV($position_student_ranking)

    # find by Gale-Shaply algorithm
    findByGS(matcher);

    # keep only selected students
    filterStudent(matcher)

    #outputCSV(matcher, matcher.position_student_ranking)
    #pp matcher.position_student_ranking
    result = outputSeletedStudents(matcher, matcher.position_student_ranking)

    return ({
      done: true,
      data: result
    });
  end
end

