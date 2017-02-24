class MatchGsPos
require 'pp'
require 'mathn'
#load 'ext/match_gs/custom_log.rb'
#load 'ext/match_gs/m_choose_n_lexical.rb'
#load 'ext/match_gs/students_rank_positions.rb'
#load 'ext/match_gs/houses_and_positions.rb'

# use lexical for the first valid selection in the house
# use m_choose_n_iterator.rb for multiple vacancies and constraints


# find only the frist valid selection
$position_valid_selection_depth=1;

# {:name=>"Nicholas",
#  :rank=>3,
#  :status=>:not_selected,
#  :student_index=>40,
#  :position_index=>18},
$position_student_ranking=[]

$student_hash = {}

$current_student = []

$max_position_student_rank = 0;

$positions_orig = nil;

# rowhouse will be matched first.
# all rowhouse and non-rowhouse will be matched alphabetically
  def self.movePositionsInRowHousesFirst

    rowHousePositions = []
    nonRowPositions = []
    $positions.each_with_index { |position, index|
      house = $houses.detect { |e| e[:name] == position[:house] }
      next if house.nil?
      if house[:rowHouse]
        rowHousePositions << position
      else
        nonRowPositions << position
      end
    }
    $positions = rowHousePositions + nonRowPositions
  end

  # output CSV file for the selected students
  def self.outputCSV(positionStudentRanking)

    for i in 0..$max_position_student_rank-1
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
  def self.outputSeletedStudents(positionStudentRanking)
    result = [];
    positionStudentRanking.sort_by { |k| $positions[k[0][:position_index]][:name] }

    Rails.logger.info(positionStudentRanking);

    positionStudentRanking.each_with_index { |students, index|
      match_position = {};
      match_position["position_id"] = $positions[students[0][:position_index]][:name];
      match_position["user_ids"] = [];

      students.each_with_index { |student, si|
        print "#{$positions[student[:position_index]][:name]}:" if si==0
        print ", " if si != 0
        orig_student_index = nil
        position = $positions_orig[student[:position_index]]
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
  def self.removeStudentNotSelectThePositionInPositions
    $positions.each_with_index { |position, index|
      for i in 0..position[:size]-1
        if $students[position[i][0]].nil?
          logInfo "Data Error: position has selected student that can not be found!"
          exit
        else
          student = $students[position[i][0]]
          if student[position[:name]].nil?
            $positions[index][i]=nil
          end
        end
      end
    }
    $positions.each_with_index { |position, index|
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
      $positions[index] = consolidatedPosition
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
  def self.findFirstValidSelectionForAllPositions
    $positions.each_with_index { |position, index|
      findFirstValidSelectionForPosition(position, index)
    }
  end

  # get the first valid selection for each position
  # return the level to keep track the highest level
  def self.findFirstValidSelectionForPosition(position, index)
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
      break if stop || iValid == $position_valid_selection_depth
    end
    $positions[index]["validSelection"]=validSelection;
    $positions[index]["validSelectionSize"]=validSelection.size();
  end

  # reset valid selection for each position
  # move the conflict spot downward until a new one is found
  def self.resetSelectionForPosition(position, index, student_index)

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
        $positions[index]["currentSelection"]=nextArray
        $positions[index]["currentSelectionSize"]=nextArray.size;
        nextArray.each_with_index { |s, index_s|
          $position_student_ranking[index][s][:status] = :selected;
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
  def self.checkConflict(level)
    nextLevel = level+1;
    logDebug "checkConflict::level=#{level}, nextLevel=#{nextLevel} <<"
    $positions.each_with_index { |position, index|
      position = $positions[index]
      student = $position_student_ranking[index][level]
      next if student.nil? || student[:status] != :selected
      student_name = student[:name]
      selected_student = $student_hash[student_name]

      # handle selecte_student is nil
      if selected_student.nil?
        $student_hash[student_name] = student
        next
      end

      if selected_student[:position_index]==student[:position_index]
        next
      end

      logInfo "#{student_name}: #{position[:name]}##{student[:rank]} vs #{$positions[selected_student[:position_index]][:name]}##{selected_student[:rank]}"

      # both selected_student and student are not nil

      if (selected_student[:rank] < student[:rank])
        logInfo "reject: #{student_name}@#{position[:name]}-"
        $position_student_ranking[index][level][:status] = :rejected
        # reset selected position
        resetSelectionForPosition(position, index, level);
        next;
      else
        logInfo "reject: #{student_name}@#{$positions[selected_student[:position_index]][:name]}"
        $student_hash[student_name] = student
        $position_student_ranking[selected_student[:position_index]][selected_student[:student_index]][:status] = :rejected
        # reset selected position for selected_student
        resetLevel = resetSelectionForPosition($positions[selected_student[:position_index]], selected_student[:position_index], selected_student[:student_index]);
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

  # set up $position_student_ranking as follows for quick comparison
  # {:name=>"Nicholas",
  #  :rank=>3,
  #  :status=>:not_selected,
  #  :student_index=>40,
  #  :position_index=>18}
  # :name => student name
  # :rank => student's rank for the position
  # :status => :selected, :not_selected, :rejected
  # :student_index => student's index(order) in the position
  # :position_index => position's index in all the positions
  def self.setUpPositionStudentRanking
    $positions.each_with_index { |position, index|
      $current_student << position["validSelection"][0];
      $positions[index]["currentSelection"] = position["validSelection"][0].clone;
      $positions[index]["currentSelectionSize"] = position["validSelection"][0].size;
    }

    $positions.each_with_index { |position, index|
      for i in 0..position[:size]-1
        if !position[i].nil? && position[i][0] != ""
          student = position[i][0]
          $position_student_ranking[index] = [] if $position_student_ranking[index].nil?
          # $position_student_ranking with :name => student_name, :rank=>position_ranking_by_the_student,
          # :status=>(:not_selected, :selected, :rejected), :student_index, :position_index => number
          $position_student_ranking[index][i]={:name=>student, :rank=>$students[student][position[:name]],
            :sex=>$students[student][:sex],:status=>:not_selected, :student_index=>i, :position_index=> index}
        end
      end
    }


    $current_student.each_with_index { |student, index|
      student.each_with_index { |s, i|
        $position_student_ranking[index][s][:status] = :selected;
      } if !student.nil?
    }
  end

  # get max number of students ranked in the all positions
  # This is for looping through all students
  def self.setMaxPositionStudentRank
    $positions.each { |position|
      $max_position_student_rank = position[:size] if !position[:size].nil? && position[:size] > $max_position_student_rank
    }
    logDebug "$max_position_student_rank=#{$max_position_student_rank}"
  end

  # if all currentSelection is less than the level, then it is complete
  def self.checkComplete(level)
    $positions.each_with_index { |position, index|
      return false if position["currentSelection"].max > level
    }
    return true;
  end

  # deleted all students that are not :selected (ie :rejected or :not_selected)
  def self.filterStudent
    selected_students = $position_student_ranking
    selected_students.each {|x| x.delete_if {|y| y[:status]!=:selected}}
    selected_students
  end


  def self.findByGS

      $student_hash = {}
      level = 0
      while level < $max_position_student_rank
        # returns the highest conflict level
        nextLevel = checkConflict(level)
        if nextLevel < level
          #go up the nextLevel again if the nextLevel is higher
          level = nextLevel
          next
        else
          level = nextLevel
        end

        #check complete only when the nextLevel == level
        if checkComplete(level)
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

  def self.init_global_variables(houses, positions, students)
    $position_valid_selection_depth=1;

    $position_student_ranking=[]

    $student_hash = {}

    $current_student = []

    $max_position_student_rank = 0;

    $positions_orig = nil;


    $houses = houses.present? ? houses : [];
    $positions = positions.present? ? positions : [];
    $students = students.present? ? students : {};
  end

  def self.do_match(locations, positions, students)
    init_global_variables(locations, positions, students);

    Rails.logger.info("@@@");
    Rails.logger.info("@@@ $houses");
    Rails.logger.info($houses);
    Rails.logger.info("@@@ $positions");
    Rails.logger.info($positions);
    Rails.logger.info("@@@ $students");
    Rails.logger.info($students);
    Rails.logger.info("@@@");


    logSetLevel($LOG_DEBUG_LEVEL)

    logDebug $students, $USE_PP;
    logDebug "$students.size=#{$students.size}", $USE_PP;



    # row house will select students first
    movePositionsInRowHousesFirst();

    # keep a copy of $positions to find the original student index
    $positions_orig = deepCopy($positions)

    # if the student does not select the position, then remove the student.
    removeStudentNotSelectThePositionInPositions();

    # find the first valid selection
    findFirstValidSelectionForAllPositions();


    fail_positions = [];
    b_ValidSelection = nil;
    $positions.each do |position|
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

    logDebug $houses, $USE_PP;

    logDebug $positions, $USE_PP;
    logDebug "$positions.size=#{$positions.size}", $USE_PP;

    # set up position student ranking
    setUpPositionStudentRanking()

    # get the max student rank for going through max level
    setMaxPositionStudentRank();

    #outputCSV($position_student_ranking)

    # find by Gale-Shaply algorithm
    findByGS();

    # keep only selected students
    filterStudent()

    #outputCSV($position_student_ranking)
    #pp $position_student_ranking
    result = outputSeletedStudents($position_student_ranking)

    return ({
      done: true,
      data: result
    });
  end


## m_choose_n_lexical.rb start ##############################################################################################################
# Lexical search for n choose k
# nexksb
# n choose k
# store h at currentArray[k]
# input
#   n: full set of n elements
#   k: subset to be chosen
#   currentArray: nil to start
# return stop, currentArray
# if stop is true, then stop
# if stop is false, then continue
#
#       if currentArray[k-h] < n-h+1
#         h = 1
#       else
#         h = h + 1
#       end
  def self.nexksb n, k, currentArray
    m2 = 0;
    h = 0;
    if (currentArray.nil?)
      currentArray = (1..k+1).to_a
      currentArray[k]=0
      return currentArray[0] == (n-k+1), currentArray
    else
      if currentArray[0] == (n-k+1)
        return currentArray[0] == (n-k+1), currentArray
      else

        h = currentArray[k]
        #puts "n=#{n}, h=#{h}, currentArray[k-h]=#{currentArray[k-h]}, n-h+1=#{n-h+1}"

        if currentArray[k-h] < n-h+1
          h = 1
        else
          h = h + 1
        end
        m2 = currentArray[k-h]
        currentArray[k] = h

        for j in 1..h
          currentArray[k+j-h-1] = m2 + j
        end
        return currentArray[0] == (n-k+1), currentArray
      end
    end
  end
## m_choose_n_lexical.rb end ##############################################################################################################

## custom_log.rb start ##############################################################################################################
# A simple log with levels
# E.g.: logSetLevel($LOG_DEBUG_LEVEL)
#       or
#       logSetLevel($LOG_INFO_LEVEL)
#
#       use pp
#       logDebug "$houses.size=#{$houses.size}", $USE_PP;
#       use puts
#       logInfo "$houses.size=#{$houses.size}", $USE_PUTS;

  $LOG_INFO = 0b0001
  $LOG_USER = 0b0010
  $LOG_SYSTEM = 0b0100
  $LOG_DEBUG = 0b1000
  $LOG_NONE_LEVEL = 0b0000
  $LOG_INFO_LEVEL = 0b0001
  $LOG_USER_LEVEL = 0b0011
  $LOG_SYSTEM_LEVEL = 0b0111
  $LOG_DEBUG_LEVEL = 0b1111
  $USE_PP=true
  $USE_PUTS=false

  # Default: no logging
  $log_level=$LOG_NONE_LEVEL

  def self.logSetLevel(logLevel=$LOG_NONE_LEVEL)
    $log_level = logLevel
  end

  def self.logInfo(s, use_pp=$USE_PP)
    if use_pp
      pp "#{s}" if $LOG_INFO & $log_level
    else
      puts "#{s}" if $LOG_INFO & $log_level
    end
  end

  def self.logUser(s, use_pp=$USE_PP)
    if use_pp
      pp "#{s}" if $LOG_USER & $log_level
    else
      puts "#{s}" if $LOG_USER & $log_level
    end
  end

  def self.logSystem(s, use_pp=$USE_PP)
    if use_pp
      pp "#{s}" if $LOG_SYSTEM & $log_level
    else
      puts "#{s}" if $LOG_SYSTEM & $log_level
    end
  end

  def self.logDebug(s, use_pp=$USE_PP)
    if use_pp
      pp s if $LOG_DEBUG & $log_level
    else
      puts "#{s}" if $LOG_DEBUG & $log_level
    end
  end

## custom_log.rb end ##############################################################################################################

end






