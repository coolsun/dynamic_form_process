require 'pp' 
require 'mathn'
load './custom_log.rb'
load './m_choose_n_lexical.rb' 
load './students.rb' 
load './houses.rb' 

# use lexical for the first valid selection in the house
# use m_choose_n_iterator.rb for multiple vacancies and constraints


# find only the frist valid selection
$house_valid_selection_depth=1;

# {:name=>"Nicholas",
#  :rank=>3,
#  :status=>:not_selected,
#  :student_index=>40,
#  :house_index=>18},
$house_student_ranking=[]

$student_hash = {}

$current_student = []

$max_house_student_rank = 0;

$houses_orig = nil;

# rowhouse will be matched first.
# all rowhouse and non-rowhouse will be matched alphabetically
def moveRowHouseFirst
  
  rowHouse = []
  nonRowHouse = []
  $houses.each_with_index { |house, index|
    if house[:rowHouse] == true
      rowHouse << house
    else
      nonRowHouse << house
    end
  }
  $houses = rowHouse + nonRowHouse
end

# output CSV file for the selected students
def outputCSV(houseStudentRanking)
  
  for i in 0..$max_house_student_rank-1
    houseStudentRanking.each_with_index { |house, index|
      if !house[i].nil?
        print "#{house[i][:name]},#{house[i][:sex]},#{house[i][:rank]},#{house[i][:status]},"  
      else
        print ",,,,"
      end
    }
    print "\n"
  end
  
end

#Output selected students
def outputSeletedStudents(houseStudentRanking)
  
  houseStudentRanking.sort_by { |k| $houses[k[0][:house_index]][:name] }
    
  houseStudentRanking.each_with_index { |students, index|
    students.each_with_index { |student, si| 
      print "#{$houses[student[:house_index]][:name]}:" if si==0
      print ", " if si != 0
      orig_student_index = nil
      house = $houses_orig[student[:house_index]]
      for i in 0..house[:size]-1
        if !house[i].nil? && house[i][0] == student[:name]
          orig_student_index = i
          break;
        end
      end
      print "(#{student[:name]}, #{orig_student_index})"
    }
    print "\n"
  }
  
end

# if the student does not select the house, remove the student
def removeStudentNotSelectTheHouseInHouse
  $houses.each_with_index { |house, index|
    for i in 0..house[:size]-1
      if $students[house[i][0]].nil?
        logInfo "Data Error: House has selected student that can not be found!"
        exit
      else
        student = $students[house[i][0]]
        if student[house[:name]].nil?
          $houses[index][i]=nil
        end
      end
    end
  }
  $houses.each_with_index { |house, index|
    consolidatedHouse = house.clone
    currentIndex = 0
    for i in 0..house[:size]-1
      if !house[i].nil? 
        if currentIndex != i
          consolidatedHouse[currentIndex]=house[i].clone
          consolidatedHouse[i]=nil
        end
      else
        next
      end
      currentIndex += 1;
    end
    consolidatedHouse[:size]=currentIndex
    $houses[index] = consolidatedHouse
  }
end

# check the constraint by checking the current selection
def checkConstraint(position, currentArray)
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
  
  return ruleResult;
  
end


# A quick factorial function
def factorial(n=0)
  return 1 if n==0
  (1..n).inject(:*)
end

# A quick n Choose k function
def n_choose_k(n, k)
  factorial(n) / (factorial(k) * factorial(n - k))
end


# get the first valid selection for each house
def findFirstValidSelectionForAllHouses
  $houses.each_with_index { |house, index|
    findFirstValidSelectionForHouse(house, index)
  }
end

# get the first valid selection for each house
# return the level to keep track the highest level
def findFirstValidSelectionForHouse(house, index)
  currentArray = nil
  n = house[:size]
  iValid = 0
  validSelection = []
  k = house[:vacancies]
  nck = n_choose_k(n, k)
  for i in 1..nck
    logDebug "house[:name]=#{house[:name]}, i=#{i}"
    stop, currentArray = nexksb n, k, currentArray
    currentArray_no_last_h = currentArray[0..-2].map{|x| x-1 }
    isValid = checkConstraint(house, currentArray_no_last_h)  
    if isValid  
      iValid += 1
      validSelection << currentArray_no_last_h
      logDebug "house[:name]=#{house[:name]}, currentArray_no_last_h=#{currentArray_no_last_h}"
    end
    break if stop || iValid == $house_valid_selection_depth
  end
  $houses[index]["validSelection"]=validSelection;
  $houses[index]["validSelectionSize"]=validSelection.size();
end

# reset valid selection for each house
# move the conflict spot downward until a new one is found
def resetSelectionForHouse(house, index, student_index)
  
  # size of student in the house will be impacted by :rejected flag
  # currentArray
  
  nextArray = house["currentSelection"].clone
  n = house[:size]
  validSelection = []
  k = house[:vacancies].to_i
  nck = n - student_index - 1
  levelFound = nil
  nextArray.delete(student_index)
  for i in 1..nck
    logDebug "house[:name]=#{house[:name]}, i=#{i}"
    nextArray << student_index + i
    nextArray.uniq!
    next if nextArray.size != house["currentSelectionSize"]
    isValid = checkConstraint(house, nextArray)  
    if isValid  
      $houses[index]["currentSelection"]=nextArray
      $houses[index]["currentSelectionSize"]=nextArray.size;
      nextArray.each_with_index { |s, index_s|
        $house_student_ranking[index][s][:status] = :selected;
      }
      logDebug "house[:name]=#{house[:name]}, nextArray=#{nextArray}"
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
#  :house_index=>18},
def checkConflict(level)
  nextLevel = level+1;
  logDebug "checkConflict::level=#{level}, nextLevel=#{nextLevel} <<"
  $houses.each_with_index { |house, index|    
    house = $houses[index]
    student = $house_student_ranking[index][level]
    next if student.nil? || student[:status] != :selected
    student_name = student[:name]
    selected_student = $student_hash[student_name]
    
    # handle selecte_student is nil
    if selected_student.nil?
      $student_hash[student_name] = student
      next
    end
    
    if selected_student[:house_index]==student[:house_index]
      next
    end
    
    logInfo "#{student_name}: #{house[:name]}##{student[:rank]} vs #{$houses[selected_student[:house_index]][:name]}##{selected_student[:rank]}"
    
    # both selected_student and student are not nil
    
    if (selected_student[:rank] < student[:rank])
      logInfo "reject: #{student_name}@#{house[:name]}-"
      $house_student_ranking[index][level][:status] = :rejected
      # reset selected house
      resetSelectionForHouse(house, index, level);
      next;
    else
      logInfo "reject: #{student_name}@#{$houses[selected_student[:house_index]][:name]}"
      $student_hash[student_name] = student
      $house_student_ranking[selected_student[:house_index]][selected_student[:student_index]][:status] = :rejected
      # reset selected house for selected_student
      resetLevel = resetSelectionForHouse($houses[selected_student[:house_index]], selected_student[:house_index], selected_student[:student_index]);
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

# set up $house_student_ranking as follows for quick comparison
# {:name=>"Nicholas",
#  :rank=>3,
#  :status=>:not_selected,
#  :student_index=>40,
#  :house_index=>18}
# :name => student name
# :rank => student's rank for the house
# :status => :selected, :not_selected, :rejected
# :student_index => student's index(order) in the house
# :house_index => house's index in all the houses
def setUpHouseStudentRanking

  $houses.each_with_index { |house, index|
    $current_student << house["validSelection"][0];
    $houses[index]["currentSelection"] = house["validSelection"][0].clone;
    $houses[index]["currentSelectionSize"] = house["validSelection"][0].size;
  }
  
  $houses.each_with_index { |house, index|
    for i in 0..house[:size]-1
      if !house[i].nil? && house[i][0] != ""
        student = house[i][0] 
        $house_student_ranking[index] = [] if $house_student_ranking[index].nil?
        # $house_student_ranking with :name => student_name, :rank=>house_ranking_by_the_student, 
        # :status=>(:not_selected, :selected, :rejected), :student_index, :house_index => number
        $house_student_ranking[index][i]={:name=>student, :rank=>$students[student][house[:name]], 
          :sex=>$students[student][:sex],:status=>:not_selected, :student_index=>i, :house_index=> index}
      end
    end
  }
  
  
  $current_student.each_with_index { |student, index|
    student.each_with_index { |s, i|
      $house_student_ranking[index][s][:status] = :selected;
    } if !student.nil?
  }
  
end

# get max number of students ranked in the all houses 
# This is for looping through all students
def setMaxHouseStudentRank
  $houses.each { |house|
    $max_house_student_rank = house[:size] if !house[:size].nil? && house[:size] > $max_house_student_rank
  }
  logDebug "$max_house_student_rank=#{$max_house_student_rank}"
end

# if all currentSelection is less than the level, then it is complete
def checkComplete(level)
  $houses.each_with_index { |house, index|
    return false if house["currentSelection"].max > level
  }
  return true;
end

# deleted all students that are not :selected (ie :rejected or :not_selected)
def filterStudent
  selected_students = $house_student_ranking
  selected_students.each {|x| x.delete_if {|y| y[:status]!=:selected}}
  selected_students
end


def findByGS
   
    $student_hash = {}
    level = 0
    while level < $max_house_student_rank
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
def deepCopy(obj)
  Marshal.load(Marshal.dump(obj))
end

logSetLevel($LOG_DEBUG_LEVEL)

logDebug $students, $USE_PP;
logDebug "$students.size=#{$students.size}", $USE_PP;



# row house will select students first
moveRowHouseFirst();

# keep a copy of $houses to find the original student index
$houses_orig = deepCopy($houses)

# if the student does not select the house, then remove the student.
removeStudentNotSelectTheHouseInHouse();

# find the first valid selection
findFirstValidSelectionForAllHouses();

logDebug $houses, $USE_PP;
logDebug "$houses.size=#{$houses.size}", $USE_PP;

# set up house student ranking
setUpHouseStudentRanking()

# get the max student rank for going through max level
setMaxHouseStudentRank();

#outputCSV($house_student_ranking)

# find by Gale-Shaply algorithm
findByGS();

# keep only selected students
filterStudent()

#outputCSV($house_student_ranking)
#pp $house_student_ranking
outputSeletedStudents($house_student_ranking)



