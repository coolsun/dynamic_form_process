class OptimizedGs < ActiveRecord::Base
  #----optimized_gs.rb-----------------------------------------------------------------------------------------------------------------------------
  #!/Users/ben/.rvm/rubies/ruby-2.0.0-p0/bin/ruby
  # Optimal Solution of Gale-Shapley stable matching with contraints and applicant weights
  #
  # ball and box problem and soluction
  # input m positions, each position has t applicants ranked from top to bottom
  # input n depth.  the sum of total depth offset is m
  # combination C(m + n - 1, m - 1)
  # m box
  # n ball
  # m-1 separator and n ball
  # References:
  # http://stackoverflow.com/questions/12858734/c-implementation-of-gale-shapley-algorithm
  # http://stackoverflow.com/questions/6508365/list-of-combinations-of-n-balls-in-m-boxes-in-c
  #
  # Weight between employer and applicant
  # Now it is 100% fully weighted on positions(school/employer side) This can be
  # adjusted easily with a joint weight of employer and applicant by sorting the position array
  #
  # applicant_attributes = [{'male'=>'male', 'introvert'=>'introvert'}, {'female'=>'female'}]
  # location.male op quantity
  # location.introvert op quantity
  #
  # constraint
  # constraint will be checked for each stable match
  #
  # constraint weight
  # constraints can be weighted with score
  #
  # a = [1, 2, 3, 4]
  # a.combination(1).to_a  #=> [[1],[2],[3],[4]]
  # a.combination(2).to_a  #=> [[1,2],[1,3],[1,4],[2,3],[2,4],[3,4]]
  #

  # example of 5 positions and 10 applicant with ranks
  require 'pp'
  #load './m_choose_n_iterator.rb'
  #load './applicants.rb'
  #load './constraints.rb'
  #load './ranks.rb'


  #
  # by location
  # do get_next_combination
  # check constraint
  # from top-down
  #

  # <, >, <>, =
  # -1 (-10), +1 (0), -1 (+1), +1 (-10)

  def self.get_combination_size(m, n)
    combination_size = 1
    if !m.nil? && !n.nil? && m >=0 && n >=0
      m = m.to_i
      n = n.to_i
      p = [*(m-n+1)..m].inject(1) { |product, e| product * e.to_f / (m - e + 1)}
      p = p.round
    end
  end


  # populate
  #$selection = {
  #  "total_vacancy" => 0,
  #  "selected_combination_applicants" => [],
  #  "selected_combination_indexes" => [],
  #  "deleted_combination_indexes" => [],
  #
  #  selected_combinations_array_index is used to access the selected_combination by a position index
  #  "selected_combinations_array_index" => nil,
  #
  #  "selected_combinations" => [
  #    {"location"=>"576 Alvarado",
  #     "position"=>"576 Alvarado-CM",
  #     "location_position_index"=>[0, 0],
  #     "selected_applicants"=>["lucy", "iris", "bernard", "justin"],
  #     "nth_combination"=>[1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  #     "nth_combination_by_applicant"=>
  #       ["lucy", "iris", "bernard", "justin", nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
  #     "nth_deleted_combinations" => [0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  #     "applicant_ranks"=> ["lucy", "iris", "bernard", "justin", "tracy", "monica", "danny", "nancy", "mary", "richard",
  #       "tom", "mark", "michael", "john", "tony", "peter", "kathy", "jane", "tim"],
  #     "applicant_with_lower_rank"=>[],
  #     "selection_complete"=>true,
  #     },
  #  ]
  #  "selection_ranks" =>
  #    {
  #    "576 Alvarado" => {
  #      # total number of vacancy in each location.  This equals to the sum of all vacancy in each position
  #      "total_location_vacancy"=> nil,
  #      # number of positions in each location
  #      "total_location_positions"=> nil,
  #      # there must be 1 for each postion, so totoal vacancy combination will be products of (ranks - 1)
  #      "total_location_rank_combination_size"=> nil,
  #      "positions"=>
  #        [
  #          {
  #          "position" => nil,
  #          "vacancy" => nil,
  #          "ranks" => nil,
  #          "rank_size" => nil,
  #          "rank_combination_size" => nil,
  #          },
  #        ]
  #      },
  #    },
  #  ]
  #}

  $debug_info = false
  $debug_true = false
  $debug = false
  $debug_debug = false
  $max_constrained_combinations_per_house = 100
  $selection = {
    "locations" => nil,
      # [
      #  "576 Alvarado",
      #  "680 Lomita",
      #  "717 Dolores"
      #]
    "locations_selected" => {
      # current_selected_location_index: store original combination
      # current location selection like [1,1] or [1,0,1] which is before sum_up_ball_in_the_box
      # [1,0,1] will be [0, 1, 0] after sum_up_ball_in_the_box
      # [0, 1, 0] means first house first constrainted match, second house second constrainted match, third house
      #           first constrainted match.
      #           The match can be found in the "all_selected_location_indexes" below
      "current_selected_location_index" => nil,
      # all_selected_location_indexes: store original combination
      # stored all combination for all locations
      # This store all history data that can be retrieved later
      "all_selected_location_indexes" => nil,
    },
    "total_vacancy" => 0,
    "selected_combination_indexes" => [],
    "selected_combination_applicants" => [],
    "deleted_combination_indexes" => [],
    "selected_combinations_array_index" => nil,
    # selected_combinations is used for access by combination array
    "selected_combinations" => [],
    # selection_ranks is used for access by location hash and positions array
    "selection_ranks" => {},
  }

  # eliminate any applicant in $position_ranks[location]["positions"]["ranks"] if not found in $applicant
  # or applicant has not ranked that position
  def self.eliminate_applicant_not_rank_for_the_position
    $position_ranks.each { |key, value|
      location = key
      location_value = value
      location_value["positions"].each_with_index { |position, index|
        position["ranks"].each_with_index { |applicant, applicant_index|
          # if not found in $applicant for that applicant and position, then delete it
          if $applicants[applicant].nil?
            logger.info "eliminate_applicant_not_rank_for_the_position:no applicant:delete #{applicant} in #{location} position #{position}" if $debug_debug
            $position_ranks[location]["positions"][index]["ranks"][applicant_index] = nil
          end
          logger.info "applicant=#{applicant}"
          if $applicants[applicant].present? && $applicants[applicant]["ranks"].index(position["position"]).nil?
            logger.info "eliminate_applicant_not_rank_for_the_position:no position:delete #{applicant} in #{location} position #{position["position"]}" if $debug_debug
            $position_ranks[location]["positions"][index]["ranks"][applicant_index] = nil
          end
        }
        $position_ranks[location]["positions"][index]["ranks"].delete(nil)
      }
    }
  end

  # initialize_selection
  #
  #   eliminate_applicant_not_rank_for_the_position
  #   set up total_vacancy
  #   set up total_location_positions
  #   set up rank_combination_size
  #   set up total_location_rank_combination_size
  def self.initialize_selection
    logger.info "initialize_selection: <<" if $debug_info
    $selection["locations"] = $position_ranks.keys.sort

    $selection["locations_selected"]["all_selected_location_indexes"] = Array.new($selection["locations"].size, nil)

    $position_ranks.each { |key, value|
      $position_ranks[key] = value.merge($constraints[key]) if $constraints[key]
    }
    pp $position_ranks if $debug_debug

    logger.info "     ===== eliminate_applicant_not_rank_for_the_position:BEGIN" if $debug_info

    eliminate_applicant_not_rank_for_the_position

    logger.info "     ===== eliminate_applicant_not_rank_for_the_position:END" if $debug_info

    # bsun ranks_by_location
    $position_ranks.each { |location, location_value|
      $position_ranks[location]["positions"].each { |p| p["ranks"] = [] }
      location_value_sorted_arr = $position_ranks[location]["ranks_by_location"].sort_by { |_key, v| v }
      location_value_sorted_arr.each_with_index {|rank, rank_number|
        applicant = rank[0][0]
        position = rank[0][1]
        $position_ranks[location]["positions"].each { |p|
          if p["position"] == position
            p["ranks"] << applicant
          end
        }
      }
    }

    pp $position_ranks if $debug

    $position_ranks.each { |key, value|
      location = key
      location_value = value
      logger.info "location=#{location}, location_value=#{location_value}" if $debug
      $selection["selection_ranks"][location]={}

      # bsun ranks_by_location
      $selection["selection_ranks"][location]["ranks_by_location"]=location_value["ranks_by_location"]

      $selection["total_vacancy"] =
        location_value["positions"].inject($selection["total_vacancy"]) {|sum, n| sum + n["vacancy"]}
      $selection["selection_ranks"][location]["total_location_vacancy"] =
        location_value["positions"].inject(0) {|sum, n| sum + n["vacancy"]}

      $selection["selection_ranks"][location]["positions"]=location_value["positions"]
      $selection["selection_ranks"][location]["total_location_positions"] = location_value["positions"].size

      $selection["selection_ranks"][location]["positions"].each_with_index { |h, index|
        h["rank_size"] = h["ranks"].size
        h["rank_combination_size"] = get_combination_size(h["rank_size"], h["vacancy"])
      }

      # I deducts rank_combination_size by one to start from one.
      # This skips the combination where the position has no applicant.
      $selection["selection_ranks"][location]["total_location_rank_combination_size"] =
        location_value["positions"].inject(1) {|product, n| product * (n["rank_combination_size"] - 1)}
    }

    $selection["selected_combinations"]=[]
    $selection["selected_combination_applicants"]=[]
    $selection["locations"].size.times {
      $selection["selected_combination_applicants"] << []
    }
    $selection["selected_combinations_array_index"] = {}
    i = 0
    $selection["selection_ranks"].each { |location, location_value|
      location_value["positions"].each_with_index { |position, position_index|
        $selection["selected_combinations"] << { "location" => location, "position" => position['position'] }
        $selection["selected_combinations_array_index"][position['position']] = i
        i = i + 1
      }
    }

    (print "$selection=";pp $selection) if $debug_debug
    logger.info "initialize_selection: >>" if $debug_info
  end


  # each location could have different combinations that meet constraints
  # so we have to end when there are no more constrainted combinations that can be found
  def self.select_applicants_with_constraints_for_all_locations

    logger.info "select_applicants_with_constraints_for_all_locations<<" if $debug_info
  #  $selection["locations_selected"]["current_selected_location_index"].each_with_index { |location_index, index|
  #    location_index += 1
  #    # if found, just use the value
  #    if $selection["locations_selected"]["all_selected_location_indexes"][index].size < location_index
  #    else
  #    end
  #  }

    m_locations = $selection["locations"].size


    n_max_locations = nil

    # $selection["locations_selected"]["current_selected_location_index"] initial value is nil
    logger.info "$selection['locations_selected']['current_selected_location_index']=#{$selection['locations_selected']['current_selected_location_index']}"
    $selection["locations_selected"]["current_selected_location_index"] =
      get_next_combination_with_max_n(m_locations, n_max_locations, $selection["locations_selected"]["current_selected_location_index"])
    logger.info "$selection['locations_selected']['current_selected_location_index']=#{$selection['locations_selected']['current_selected_location_index']}"
    current_location_combination = sum_up_ball_in_the_box($selection["locations_selected"]["current_selected_location_index"])

    logger.info "current_location_combination=#{current_location_combination}"
    all_found = false
    while !current_location_combination.nil? && !all_found

      # reset  $selection["selected_combination_indexes"]
      $selection["selected_combination_indexes"].each_with_index { |e, i|
        $selection["selected_combination_indexes"][i] = []
        $selection["selected_combination_applicants"][i] = []
      }


      logger.info "while current_location_combination=#{current_location_combination}"
      current_location_combination.each_with_index { |location_index, index|

        current_combination = nil

        # find location_index from $selection["locations_selected"]["all_selected_location_indexes"] where every selected_combination per location is stored
        logger.info "select_applicants_with_constraints_for_all_locations:location_index=#{location_index}, index=#{index}" if $debug_true
        logger.info "select_applicants_with_constraints_for_all_locations:$selection['locations_selected']['all_selected_location_indexes']=#{$selection['locations_selected']['all_selected_location_indexes']}"
        if !$selection["locations_selected"]["all_selected_location_indexes"][index].nil? &&
           !$selection["locations_selected"]["all_selected_location_indexes"][index][location_index].nil?
           $selection["selected_combination_indexes"][index] = $selection["locations_selected"]["all_selected_location_indexes"][index][location_index]
           logger.info "push into $selection['selected_combination_indexes']=#{$selection['selected_combination_indexes']}"
           next
        else
           if !$selection["locations_selected"]["all_selected_location_indexes"][index].nil? &&
              $selection["locations_selected"]["all_selected_location_indexes"][index][location_index].nil?
             # pop out the last one
             # iterate from the last combination
             current_combination = split_ball_in_the_box($selection["locations_selected"]["all_selected_location_indexes"][index][-1])
           end
        end

        # if not, then try to find the next constrainted combination for that location
        location = $selection["locations"][index]
        location_value = $selection["selection_ranks"][location]
        logger.info "location=#{location}, location_value=#{location_value}" if $debug

        # no use
        #[*1..location_value["total_location_positions"]].each {
        #}

        m = location_value["total_location_positions"]
        n = location_value["total_location_vacancy"]
        # combination C(m + n - 1, m - 1)
        # m box
        # n ball

        # run at most 10,000,000 times per location
        i = 1
        found = false
        while !found && i< 10000000 && i < $selection["selection_ranks"][location]["total_location_rank_combination_size"]
          logger.info "select_applicants_with_constraints_for_all_locations:i=#{i}, m=#{m}, current_combination=#{current_combination}" if $debug_info
          while found != true
            current_combination = get_next_combination(m+i-1, m-1, current_combination)
            if current_combination.nil?
               i = i + 1
               break
            end
            combination_for_positions = sum_up_ball_in_the_box(current_combination)
            verified_result = verify_constraints(location, combination_for_positions)
            if verified_result
              # prepare for GS
              $selection["selected_combination_indexes"][index]=combination_for_positions
              #$selection["locations_selected"]["all_selected_location_indexes"]=[[],[],[]]
              logger.info "before set:$selection['locations_selected']['all_selected_location_indexes']=#{$selection['locations_selected']['all_selected_location_indexes']}"
              logger.info "combination_for_positions=#{combination_for_positions}"
              # store verified current_combination to be retrieved later in case the gs failed
              $selection["locations_selected"]["all_selected_location_indexes"][index] = [] if $selection["locations_selected"]["all_selected_location_indexes"][index].nil?
              $selection["locations_selected"]["all_selected_location_indexes"][index][location_index] = combination_for_positions
              logger.info "after set:$selection['locations_selected']['all_selected_location_indexes']=#{$selection["locations_selected"]['all_selected_location_indexes']}"
              found = true
            end
          end
        end

      }

      # need to check if all locations meet found=true condition
      all_found = check_all_found_for_current_location_combination(current_location_combination)

      ##current_location_combination = get_next_combination_with_max_n(m, n_max, current_location_combination)
      #logger.info "$selection["locations_selected"]['current_selected_location_index']=#{$selection["locations_selected"]['current_selected_location_index']}"
      #logger.info "select_applicants_with_constraints_for_all_locations:m=#{$selection["locations"].size},n_max=#{nil}"
      #$selection["locations_selected"]["current_selected_location_index"] =
      #  get_next_combination_with_max_n($selection["locations"].size, nil, $selection["locations_selected"]["current_selected_location_index"])
      #logger.info "$selection["locations_selected"]['current_selected_location_index']=#{$selection["locations_selected"]['current_selected_location_index']}"
      #current_location_combination = sum_up_ball_in_the_box($selection["locations_selected"]["current_selected_location_index"])


    end

    if all_found
      logger.info "select_applicants_with_constraints_for_all_locations:reset $selection['deleted_combination_indexes']" if $debug_info
      # set up deleted_combination_indexes for gs
      $selection["deleted_combination_indexes"] = $selection["selected_combination_indexes"].dup
      $selection["deleted_combination_indexes"] = $selection["deleted_combination_indexes"].collect { |element| element.collect { nil } }
      logger.info "select_applicants_with_constraints_for_all_locations:$selection['deleted_combination_indexes'] ===" if $debug_info
      pp $selection["deleted_combination_indexes"] if $debug_info
    end

    logger.info "select_applicants_with_constraints_for_all_locations:all_found=#{all_found}: >>" if $debug_info
    return all_found

  end

  def self.check_all_found_for_current_location_combination(current_location_combination)
    current_location_combination.each_with_index { |location_index, index|
      return false if $selection["locations_selected"]["all_selected_location_indexes"][index][location_index].nil?
    }
    return true
  end


  # verify the combination of position
  # if verified ok, return nth_combination (index array of the location applicants)
  # input combination_for_positions
  #   e.g.: [1, 1, 1, 1, 14]
  def self.verify_constraints(location, combination_for_positions)
    logger.info "verify_constraints::location=#{location}, combination_for_positions=#{combination_for_positions} <<" if $debug_info
    logger.info "combination_for_positions=" if $debug_info
    pp combination_for_positions if $debug_info
    all_selected_applicants = []
    selected_combination = []
    $selection["selection_ranks"][location]["positions"].each_with_index { |position, index|
      logger.info "position=#{position}, index=#{index}" if $debug_debug

      if (combination_for_positions[index] > position["rank_combination_size"] - 1 || combination_for_positions[index] < 0)
        # throw exception
        logger.info "verify_constraints:ERROR:likely program or data serious error: out of bound index .. >>" if $debug_info
        return nil
      end
      nth_combination = get_nth_combination(position["rank_size"], position["vacancy"], combination_for_positions[index]+1)
      logger.info "nth_combination" if $debug_debug
      pp nth_combination if $debug_debug
      nth_combination_by_applicant = []
      selected_applicants = []
      nth_combination.each_with_index { |combination, index|
        if combination == 0
          nth_combination_by_applicant << nil
        else
          nth_combination_by_applicant << position['ranks'][index]
          selected_applicants << position['ranks'][index]
        end
      }
      #logger.info "#{position['position']} selects #{selected_applicants}"
      selected_combination << {
        "location" => location,
        "position" => position['position'],
        "location_position_index" => [$selection["locations"].index(location), index],
        "selected_applicants" => selected_applicants,
        "nth_combination" => nth_combination,
        "nth_combination_by_applicant" => nth_combination_by_applicant,
        "applicant_ranks" => position['ranks'],
        "applicant_with_lower_rank" => [],
        "selection_complete" => true
      }

      #selected_applicants = []
      #element['ranks'].each_with_index { |rank, index|
      #  selected_applicants << rank if nth_combination[index] == 1
      #}

      all_selected_applicants += selected_applicants
    }
    logger.info "location=#{location}, all_selected_applicants #{all_selected_applicants}" if $debug_debug
    tag_count = {}
    all_selected_applicants.each { |element, index|
      $applicants[element]["tags"].each { |tag, tag_value|
        if tag_count[tag].nil?
          tag_count[tag] = 0
        else
          tag_count[tag] += 1
        end
      }
    }
    logger.info "tag_count<<" if $debug_info
    logger.info "tag_count=#{tag_count}, location=#{location}"
    logger.info "tag_count>>" if $debug_info
    result = check_constraints(location, tag_count)

    if result
      selected_combination.each_with_index { |combination, combination_index|
        $selection["selected_combinations"][get_position_index(combination['position'])] = combination
      }
      logger.info "push or replace selected_combination in $selection['selected_combinations']" if $debug_info
      pp selected_combination if $debug_info
    else
      logger.info "No push or replace selected_combination in $selection['selected_combinations']" if $debug_info
    end

    logger.info "verify_constraints:#{result}:#{location}, #{combination_for_positions} >>" if $debug_info
    return result

  end

  def self.get_position_index(position)
    return $selection["selected_combinations_array_index"][position]
  end

  def self.check_constraints(location, tag_count)
    logger.info "check_constraints #{location}<<" if $debug_info
    location_value = $position_ranks[location]
    constraints = location_value["tag"]
    constraints.each { |tag, operator|
      count = tag_count[tag]
      if count.nil?
        logger.info "check_constraints #{location}: count nil >>" if $debug_info
        return false if count.nil?
      end
      logger.info "constraint tag:#{tag}, count=#{count}, eval #{count} #{operator[0]} #{operator[1]}" if $debug_debug
      result = eval "#{count} #{operator[0]} #{operator[1]}"
      if !result
        logger.info "failed constraint tag:#{tag}, count=#{count}, eval #{count} #{operator[0]} #{operator[1]}" if $debug_debug
        logger.info "check_constraints #{location} >>" if $debug_info if $debug_debug
        return false
      end
    }
    logger.info "check_constraints #{location}: pass constraint #{location}>>" if $debug_info
    return true
  end

  def self.gale_shapley_with_constraints_check_only
    logger.info "gale_shapley_with_constraints_check_only<<" if $debug_info

    logger.info "$selection=" if $debug_info
    pp $selection if $debug_info

    $selection["selected_combinations"].each_with_index { |selected_combination, selected_combination_index|
      logger.info "selected_combination['position']=#{selected_combination['position']}" if $debug_info
      logger.info "selected_combination['selected_applicants']=#{selected_combination['selected_applicants']}" if $debug_info
    }

    $selection["selected_combinations"].each_with_index { |selected_combination, selected_combination_index|
      selected_applicants = selected_combination["selected_applicants"]
      selected_position = selected_combination["position"]
      # go through all selected applicants to compare with the same selected applicant
      # for their rank
      selected_applicants.each_with_index { |selected_applicant, selected_applicant_index|
        $selection["selected_combinations"].each_with_index { |selected_combination_to_compare, selected_combination_to_compare_index|
          found_selected_applicant_index = selected_combination_to_compare["selected_applicants"].index(selected_applicant)
          # if applicant found && not self
          logger.info "selected_combination_index=#{selected_combination_index}, selected_combination_to_compare_index=#{selected_combination_to_compare_index}" if $debug
          logger.info "selected_applicant_index=#{selected_applicant_index}, found_selected_applicant_index=#{found_selected_applicant_index}" if $debug
          if !found_selected_applicant_index.nil? &&
             !(selected_combination_index == selected_combination_to_compare_index &&
               selected_applicant_index == found_selected_applicant_index)
            logger.info "gale_shapley_with_constraints_check_only:duplicate applicant found:false ... >>" if $debug_info
            return false
          end
        }
        $applicants[selected_applicant]["ranks"].each_with_index { |position, position_index|
          break if position == selected_position

          # bsun ranks_by_location: remove .nil? in the following line
          selected_applicant_index = $selection["selected_combinations"][get_position_index(position)]["applicant_ranks"].index(selected_applicant)

          if !selected_applicant_index.nil?
            if $selection["selected_combinations"][get_position_index(position)]["nth_combination"].rindex(1) > selected_applicant_index

              # bsun ranks_by_location
              #puts "gale_shapley_with_constraints_check_only:#{selected_position}:#{selected_applicants}:#{position}:#{nth_combination_by_applicant}" if $debug_info

              logger.info "gale_shapley_with_constraints_check_only:unstable:false ... >>" if $debug_info
              return false
            end
          end
        }
      }
    }

    logger.info "gale_shapley_with_constraints_check_only:true ... >>" if $debug_info

    return true

  end

  def self.gale_shapley_with_constraints
    logger.info "gale_shapley_with_constraints<<" if $debug_info

    logger.info "$selection=" if $debug_info
    pp $selection if $debug_info

    $selection["selected_combinations"].each_with_index { |selected_combination, selected_combination_index|
      logger.info "selected_combination['position']=#{selected_combination['position']}" if $debug_debug
      logger.info "selected_combination['selected_applicants']=#{selected_combination['selected_applicants']}" if $debug_debug
    }

    $selection["selected_combinations"].each_with_index { |selected_combination, selected_combination_index|
      selected_applicants = selected_combination["selected_applicants"]
      position = selected_combination["position"]
      # go through all selected applicants to compare with the same selected applicant
      # for their rank
      selected_applicants.each_with_index { |selected_applicant, selected_applicant_index|
        $selection["selected_combinations"].each_with_index { |selected_combination_to_compare, selected_combination_to_compare_index|
          found_selected_applicant_index = selected_combination_to_compare["selected_applicants"].index(selected_applicant)
          # if applicant found && not self
          logger.info "selected_combination_index=#{selected_combination_index}, selected_combination_to_compare_index=#{selected_combination_to_compare_index}" if $debug
          logger.info "selected_applicant_index=#{selected_applicant_index}, found_selected_applicant_index=#{found_selected_applicant_index}" if $debug

          # bsun ranks_by_location
          # add the if part below
          if !found_selected_applicant_index.nil? &&
             !(selected_combination_index == selected_combination_to_compare_index &&
               selected_applicant_index == found_selected_applicant_index)
            # if on the same location => compare with ranks_by_locations
            if selected_location == found_selected_location
              if ($selection["selection_ranks"][selected_location]["ranks_by_location"][[selected_applicant], position] <
                  $selection["selection_ranks"][selected_location]["ranks_by_location"][[selected_applicant], found_selected_position])
                logger.info "#{$selection['selected_combinations'][selected_combination_to_compare_index]['selected_applicants']}" if $debug_debug
                to_be_deleted_location_index, to_be_deleted_position_index =
                  $selection["selected_combinations"][selected_combination_to_compare_index]["location_position_index"]
                logger.info "to_be_deleted_location_index, to_be_deleted_position_index = #{to_be_deleted_location_index}, #{to_be_deleted_position_index}" if $debug_debug
                $selection["selected_combinations"][selected_combination_to_compare_index]["selected_applicants"].delete(selected_applicant)

                if $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"].nil?
                  $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"] =
                    Array.new(
                      $selection["selected_combinations"][selected_combination_to_compare_index]["nth_combination"].size,
                      nil
                    )
                end
                # Trick: take the value of the selected_combination_indexes as the starting index
                # this way we can search from 0.  It is easier to do m_choose_n.
                logger.info "     ===== $selection['selected_combination_indexes']" if $debug_debug
                pp $selection["selected_combination_indexes"]
                $selection["deleted_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]=
                   $selection["selected_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]
                logger.info "     ===== $selection['deleted_combination_indexes']" if $debug_debug
                pp $selection["deleted_combination_indexes"]

                $selection["selected_combinations"][selected_combination_to_compare_index]["applicant_with_lower_rank"] << selected_applicant
                $selection["selected_combinations"][selected_combination_to_compare_index]["selection_complete"]=false
              else
                logger.info "#{$selection['selected_combinations'][selected_combination_to_compare_index]['selected_applicants']}" if $debug_debug
                to_be_deleted_location_index, to_be_deleted_position_index =
                  $selection["selected_combinations"][selected_combination_index]["location_position_index"]
                logger.info "to_be_deleted_location_index, to_be_deleted_position_index = #{to_be_deleted_location_index}, #{to_be_deleted_position_index}" if $debug_debug
                $selection["selected_combinations"][selected_combination_index]["selected_applicants"].delete(selected_applicant)
                if $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"].nil?
                  $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"] =
                    Array.new(
                      $selection["selected_combinations"][selected_combination_to_compare_index]["nth_combination"].size,
                      nil
                    )
                end
                # Trick: take the value of the selected_combination_indexes as the starting index
                # this way we can search from 0.  It is easier to do m_choose_n.
                logger.info "     ===== $selection['selected_combination_indexes']" if $debug_debug
                pp $selection["selected_combination_indexes"]
                logger.info "     ===== $selection['deleted_combination_indexes']" if $debug_debug
                pp $selection["deleted_combination_indexes"]
                $selection["deleted_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]=
                   $selection["selected_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]

                $selection["selected_combinations"][selected_combination_index]["applicant_with_lower_rank"] << selected_applicant
                $selection["selected_combinations"][selected_combination_index]["selection_complete"]=false
              end
            else
            #   GS comparison
            #   set loser to applicant_with_lower_rank
              compared_position = selected_combination_to_compare["position"]
              logger.info "compare ranks: selected_applicant = #{selected_applicant}, position=#{position}, compared_position=#{compared_position}" if $debug_debug
              selected_applicant_rank = $applicants[selected_applicant]["ranks"].index(position)
              compared_applicant_rank = $applicants[selected_applicant]["ranks"].index(compared_position)
              logger.info "selected_applicant_rank = #{selected_applicant_rank}, compared_applicant_rank = #{compared_applicant_rank}" if $debug_debug
              # both selected_applicant_rank and compared_applicant_rank won't be nil
              # that possibility is deleted in the init state
              if selected_applicant_rank < compared_applicant_rank
                logger.info "#{$selection['selected_combinations'][selected_combination_to_compare_index]['selected_applicants']}" if $debug_debug
                to_be_deleted_location_index, to_be_deleted_position_index =
                  $selection["selected_combinations"][selected_combination_to_compare_index]["location_position_index"]
                logger.info "to_be_deleted_location_index, to_be_deleted_position_index = #{to_be_deleted_location_index}, #{to_be_deleted_position_index}" if $debug_debug
                $selection["selected_combinations"][selected_combination_to_compare_index]["selected_applicants"].delete(selected_applicant)

                if $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"].nil?
                  $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"] =
                    Array.new(
                      $selection["selected_combinations"][selected_combination_to_compare_index]["nth_combination"].size,
                      nil
                    )
                end
                # Trick: take the value of the selected_combination_indexes as the starting index
                # this way we can search from 0.  It is easier to do m_choose_n.
                logger.info "     ===== $selection['selected_combination_indexes']" if $debug_debug
                pp $selection["selected_combination_indexes"]
                $selection["deleted_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]=
                   $selection["selected_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]
                logger.info "     ===== $selection['deleted_combination_indexes']" if $debug_debug
                pp $selection["deleted_combination_indexes"]

                $selection["selected_combinations"][selected_combination_to_compare_index]["applicant_with_lower_rank"] << selected_applicant
                $selection["selected_combinations"][selected_combination_to_compare_index]["selection_complete"]=false
              else
                logger.info "#{$selection['selected_combinations'][selected_combination_to_compare_index]['selected_applicants']}" if $debug_debug
                to_be_deleted_location_index, to_be_deleted_position_index =
                  $selection["selected_combinations"][selected_combination_index]["location_position_index"]
                logger.info "to_be_deleted_location_index, to_be_deleted_position_index = #{to_be_deleted_location_index}, #{to_be_deleted_position_index}" if $debug_debug
                $selection["selected_combinations"][selected_combination_index]["selected_applicants"].delete(selected_applicant)
                if $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"].nil?
                  $selection["selected_combinations"][selected_combination_to_compare_index]["nth_deleted_combination"] =
                    Array.new(
                      $selection["selected_combinations"][selected_combination_to_compare_index]["nth_combination"].size,
                      nil
                    )
                end
                # Trick: take the value of the selected_combination_indexes as the starting index
                # this way we can search from 0.  It is easier to do m_choose_n.
                logger.info "     ===== $selection['selected_combination_indexes']" if $debug_debug
                pp $selection["selected_combination_indexes"]
                logger.info "     ===== $selection['deleted_combination_indexes']" if $debug_debug
                pp $selection["deleted_combination_indexes"]
                $selection["deleted_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]=
                   $selection["selected_combination_indexes"][to_be_deleted_location_index][to_be_deleted_position_index]

                $selection["selected_combinations"][selected_combination_index]["applicant_with_lower_rank"] << selected_applicant
                $selection["selected_combinations"][selected_combination_index]["selection_complete"]=false
              end
            end
          end
        }
      }
    }

    #
    # check if all selection_complete is true
    is_all_selection_complete_true = true;
    $selection["selected_combinations"].each_with_index { |selected_combination, selected_combination_index|
      is_all_selection_complete_true = false if selected_combination["selection_complete"] == false
    }
    #
    # if not, continue to select applicants with constraints
    logger.info "gale_shapley_with_constraints:#{is_all_selection_complete_true}>>" if $debug_info
    return is_all_selection_complete_true
    #

  end

  def self.replace_applicants_rejected_by_gs
    logger.info "replace_applicants_rejected_by_gs:<<" if $debug_info

    logger.info "$selection['selected_combination_indexes']=#{$selection['selected_combination_indexes']}"
    logger.info "$selection['deleted_combination_indexes']=#{$selection['deleted_combination_indexes']}"

    applicants_replaced = false
    $selection["deleted_combination_indexes"].each_with_index { |deleted_combination, dci_index|
      location = $selection["locations"][dci_index]
      logger.info "replace_applicants_rejected_by_gs:location=#{location}, deleted_combination=#{deleted_combination}" if $debug_info

      combination_for_positions = $selection["selected_combination_indexes"][dci_index]
      logger.info "replace_applicants_rejected_by_gs:location=#{location}, combination_for_positions=#{combination_for_positions}" if $debug_info

      if combination_for_positions.nil?
        # abort
        logger.info "replace_applicants_rejected_by_gs:combination_for_positions is nil:abort >>" if $debug_info
        # need to make some change for the 'exit' when moving into ROR
        exit
        break
      end

      # start from [0, 0, 0 ..] on top of $selection["dci_indexes"]
      # n_max = vacancy of deleted combination - $selection["dci_indexes"]
      m = 0
      n_max = 0
      deleted_combination_found = false
      deleted_combination.each_with_index { |combination_index, dc_index|
        if !combination_index.nil?
          deleted_combination_found = true
          m = m + 1
          # Note: "combination_index +  1" below since the combination_index starts from 0
          n_max = n_max + $selection["selection_ranks"][location]["positions"][dc_index]["rank_combination_size"] - (combination_index + 1)
        end
      }

      if !deleted_combination_found
        logger.info "replace_applicants_rejected_by_gs:skip dci_index=#{dci_index}" if $debug_info
        next
      end

      logger.info "replace_applicants_rejected_by_gs:location=#{location}, m=#{m}, n_max=#{n_max}"

      current_deleted_combination = nil
      found = false
      # Note: skipping the first one, which is already rejected by gs.
      skip_first_one = true
      loop do


        current_deleted_combination = get_next_combination_with_max_n(m, n_max, current_deleted_combination)
        if current_deleted_combination.nil?
          # abort
          logger.info "replace_applicants_rejected_by_gs:current_deleted_combination is nil:abort ..."
          break
        else
          # Note: skipping the first one, which is already rejected by gs.  The first one should be 0,0,0,0 ...
          if skip_first_one
            logger.info "replace_applicants_rejected_by_gs:skip first one:current_deleted_combination=#{current_deleted_combination}"
            skip_first_one = false
            next
          end
        end


        deleted_combination_for_positions = sum_up_ball_in_the_box(current_deleted_combination)

        logger.info "replace_applicants_rejected_by_gs:deleted_combination_for_positions=" if $debug_info
        pp deleted_combination_for_positions if $debug_info

        # need some thinking
        dupped_deleted_combination_for_positions = deleted_combination_for_positions.dup
        selected_combination_index = -1 # start from 0, index from deleted_combination to $selection["selected_combinations"]

        combination_for_positions_found = true
        current_combination_for_positions = combination_for_positions.dup
        deleted_combination.each_with_index { |combination_index, dc_index|
          selected_combination_index = selected_combination_index + 1
          if !combination_index.nil?
            current_combination_for_positions[dc_index]= combination_for_positions[dc_index] +
                                                         dupped_deleted_combination_for_positions.shift

            if (current_combination_for_positions[dc_index] < 0 ||
                current_combination_for_positions[dc_index] > $selection["selection_ranks"][location]["positions"][dc_index]["rank_combination_size"] - 1)
              combination_for_positions_found = false
              break
            end
          end
        }
        break if !combination_for_positions_found

        logger.info "WARNING: dupped_deleted_combination_for_positions.size=#{dupped_deleted_combination_for_positions.size}" if dupped_deleted_combination_for_positions.size != 0

        verified_result = verify_constraints(location, current_combination_for_positions)
        if verified_result
          # prepare for GS
          # fix
          $selection["selected_combination_indexes"][dci_index] =  current_combination_for_positions
          # replace the last element by [-1], this should not be used in vicinity search
          #$selection["locations_selected"]["all_selected_location_indexes"][dci_index][-1] = current_combination_for_positions
          # update deleted_combination_indexes
          logger.info "current_combination_for_positions=#{current_combination_for_positions}" if $debug_info
          logger.info "$selection['selected_combination_indexes'][dci_index]=#{$selection['selected_combination_indexes'][dci_index]}"
          $selection["deleted_combination_indexes"][dci_index].each_with_index { |deleted_combination, deleted_combination_index|
            # only update when the value is not nil. skip all nils.
            logger.info "$selection['deleted_combination_indexes'][dci_index][deleted_combination_index]=#{$selection['deleted_combination_indexes'][dci_index][deleted_combination_index]}" if $debug_info
            if !$selection["deleted_combination_indexes"][dci_index][deleted_combination_index].nil?
              $selection["deleted_combination_indexes"][dci_index][deleted_combination_index] =
                  $selection["selected_combination_indexes"][dci_index][deleted_combination_index]
            end
          }
          found = true
          applicants_replaced = true
          update_selected_applicants(dci_index)
          break;
        end
      end

      if !found
        logger.info "replace_applicants_rejected_by_gs:not found ..."
        break
      end

    }

    logger.info "replace_applicants_rejected_by_gs:applicants_replaced=#{applicants_replaced}>>" if $debug_info
    return applicants_replaced
  end

  def self.update_selected_applicants(location_index)
    $selection['selected_combinations'][location_index]['selected_applicants'] = []
    $selection['selected_combinations'][location_index]['nth_combination_by_applicant'].each { |x|
      $selection['selected_combinations'][location_index]['selected_applicants'] << x if !x.nil?
    }
  end

  def self.match(position_ranks, applicants, constraints)
    $position_ranks, $applicants, $constraints = position_ranks, applicants, constraints

    if $debug_info
      logger.info "      ===== match input info BEGIN"
      logger.info "$position_ranks=#{$position_ranks}"
      logger.info "      ============================"
      logger.info "$applicants=#{$applicants}"
      logger.info "      ============================"
      logger.info "$constraints=#{$constraints}"
      logger.info "      ===== match input info END"
    end

    initialize_selection


    logger.info "      ===== select_applicants_with_constraints_for_all_locations BEGIN" if $debug_info
    all_found = select_applicants_with_constraints_for_all_locations
    logger.info "      ===== select_applicants_with_constraints_for_all_locations END" if $debug_info
    #logger.info '$selection["selected_combinations"]' if $debug_info
    #pp $selection["selected_combinations"] if $debug_info
    logger.info '$selection' if $debug_info
    pp $selection if $debug_true
    while all_found
      gs_result = false
      found = false
      vicinity_search_count = 0
      while !gs_result && vicinity_search_count <= 100
        logger.info "      ===== vicinity_search_count=#{vicinity_search_count}" if $debug_info

        $selection["selected_combinations"].each { |ssc|
          $selection["selected_combination_applicants"][ssc["location_position_index"][0]][ssc["location_position_index"][1]]=ssc["selected_applicants"]
        }

        if vicinity_search_count == 0
          logger.info "      ===== gale_shapley_with_constraints: BEGIN" if $debug_info
          gs_result = gale_shapley_with_constraints
          logger.info "      ===== gale_shapley_with_constraints: END" if $debug_info
        else
          logger.info "      ===== gale_shapley_with_constraints_check_only: BEGIN" if $debug_info
          gs_result = gale_shapley_with_constraints_check_only
          logger.info "      ===== gale_shapley_with_constraints_check_only: END" if $debug_info
        end

        if !gs_result
          logger.info "      ===== replace_applicants_rejected_by_gs: BEGIN" if $debug_info
          found = replace_applicants_rejected_by_gs
          logger.info "      ===== replace_applicants_rejected_by_gs: END" if $debug_info
          break if !found
          vicinity_search_count = vicinity_search_count + 1
        end
      end
      if gs_result
       # gs condition is satisfied, exit.
       logger.info "      ===== gale_shapley_with_constraints:SUCCEED!!!: COMPLETE" if $debug_info
       break
      else
       # gs condition is not satisfied, exit.
       logger.info "      ===== select_applicants_with_constraints_for_all_locations: BEGIN" if $debug_info
       all_found = select_applicants_with_constraints_for_all_locations
       logger.info "      ===== select_applicants_with_constraints_for_all_locations: END" if $debug_info
      end
    end



    #logger.info "get_combination_size(10,3)=#{get_combination_size(10,3)}"

    if all_found
      #logger.info '$selection["selected_combinations"]'
      #pp $selection["selected_combinations"] if $debug_debug
      logger.info '$selection'
      pp $selection if $debug_info

      logger.info '$selection["selected_combination_indexes"]'
      pp $selection["selected_combination_indexes"] if $debug_debug
      logger.info "     ===== succeeded to find a combination with constraints satified END" if $debug_info

      return $selection["selection_ranks"]
    else
      logger.info "     ===== failed to find any combination with constraints satified END" if $debug_info

      return false
    end
  end

  #----m_choose_n_iterator.rb-----------------------------------------------------------------------------------------------------------------------------
  # The spectacular algoriath I have developed will iterate the m C n one by one by a couple simple rules
  # rule 1: starting from all n balls on the left most.
  # rule 2: mv the first movable ball to the right and reset all the remaining balls to the left of the moved ball to remaining_m C remaining_n
  # note : reset means start from all balls to the left most.
  # 7 C 4 = 35
  #  1: ball
  #  0: empty
  # 1111000
  # 1110100
  # 1101100
  # 1011100
  # 0111100
  # 1110010
  # 1101010
  # 1011010
  # 0111010
  # 1100110
  # 1010110
  # 0110110
  # 1001110
  # 0101110
  # 0011110
  # 1110001
  # 1101001
  # 1011001
  # 0111001
  # 1100101
  # 1010101
  # 0110101
  # 1001101
  # 0101101
  # 0011101
  # 1100011
  # 1010011
  # 0110011
  # 1001011
  # 0101011
  # 0011011
  # 1000111
  # 0100111
  # 0010111
  # 0001111

  #

  #require 'pp'

  # input: m, n, current_combination
  #  m, n: C(m, n)
  #  n is 1, m-n is 0
  # current_combination: nil to start
  #                      non-nil to get the next combination from the current one
  # return: the next combination or nil if the end is reached
  def self.get_next_combination(m, n, current_combination)
    logger.info "get_next_combination:m=#{m}, n=#{n}, current_combination=#{current_combination} <<" if $debug_lib
    if current_combination.to_a.empty?
      current_combination = Array.new(n, 1) + Array.new(m-n, 0)
      logger.info "get_next_combination:return --------: new array(#{n} 1 and #{m-n} 0) >>" if $debug_lib
      return current_combination
    end
    found = false
    sum = 0
    current_combination.each_with_index { |x, index|
      logger.info "x=#{x}, index=#{index}, sum=#{sum}" if $debug_debug
      if (x == 0 && index - 1 >= 0 && current_combination[index-1] == 1)
        found = true
        # swap
        current_combination[index] = 1
        current_combination[index-1] = 0
        sum -= 1
        logger.info "get_next_combination:sum=#{sum}" if $debug
        [*0..index-2].each_with_index { |y, y_index|
          logger.info "get_next_combination:reset: sum=#{sum}" if $debug
          if sum > 0
            current_combination[y_index] = 1
          else
            current_combination[y_index] = 0
          end
            sum -= 1
        } if index >= 2

        break;
      else
        sum += x
      end
    }
    logger.info "get_next_combination:m=#{m}, n=#{n}, current_combination=#{current_combination} >>" if $debug_lib
    return (found == true)?current_combination:nil
  end

  # input: m, n_max, current_combination
  #  m: fixed number of box
  #  n: 0 .. n_max - 1 balls
  #  m, n: C(m+n-1, m-1)
  # current_combination: nil to start
  #                      non-nil to get the next combination from the current one
  # n_max: nil means no limits on n
  #
  # return: the next combination or nil if the end is reached
  def self.get_next_combination_with_max_n(m, n_max, current_combination)

    logger.info "get_next_combination_with_max_n:m=#{m}, n_max=#{n_max}, current_combination=#{current_combination} <<" if $debug_debug

    if current_combination.nil?
      n = 0
      logger.info "get_next_combination_with_max_n:n=#{n}:get_next_combination(#{m+n-1}, #{m-1}, #{current_combination})" if $debug_debug
      current_combination = get_next_combination(m+n-1, m-1, current_combination)
    else
      if current_combination.size == 0
        # handle m=1, n=0, returns [] the first time
        n = 1
      else
        n = current_combination.count(0)
      end
      current_combination = get_next_combination(m+n-1, m-1, current_combination)
      if !current_combination.nil?
        logger.info "get_next_combination_with_max_n:current_combination=#{current_combination} >>" if $debug_debug
        return current_combination if !current_combination.nil?
      end

      n = n + 1
      if !n_max.nil? && n>=n_max
        logger.info "get_next_combination_with_max_n:current_combination=#{current_combination} >>" if $debug_debug
        return nil if !n_max.nil? && n>=n_max
      end

      logger.info "get_next_combination_with_max_n:n=#{n}:get_next_combination(#{m+n-1}, #{m-1}, #{current_combination})" if $debug_debug
      current_combination = get_next_combination(m+n-1, m-1, nil)
    end

    logger.info "get_next_combination_with_max_n:current_combination=#{current_combination} >>" if $debug_debug
    return current_combination

  end

  def self.split_ball_in_the_box(current_combination)
    split_combination = []
    current_combination.each_with_index { |number_of_balls, index|
      split_combination << 1 if index > 0 && index < current_combination.size
      number_of_balls.times { split_combination <<  0 }
    }
    split_combination
  end

  # sum up ball in the box
  # sum up the 0 to be number of balls per box: this is a trick to reverse 0 and 1
  # the current_combination is starting from "0" which is the first rank position.
  # All positions have to have one choice so "0" as the first position fits the purpose
  def self.sum_up_ball_in_the_box(current_combination)

    logger.info "sum_up_ball_in_the_box<<" if $debug_debug
    if current_combination.nil?
      logger.info "sum_up_ball_in_the_box:error:input current_combination can not be nil." if $debug_debug
      logger.info "sum_up_ball_in_the_box<<" if $debug_debug
      return nil
    end
    pp current_combination if $debug_debug

    summed_up_combination =[]
    count_of_zero = 0
    if current_combination.size == 0
      count_of_zero = 0
      logger.info "push: current_combination.size=#{current_combination.size}, count_of_zero=#{count_of_zero}" if $debug_debug
      summed_up_combination << count_of_zero
      logger.info "end: current_combination.size=#{current_combination.size}, count_of_zero=#{count_of_zero}" if $debug_lib
    end
    current_combination.each_with_index { |n, index|
      if n == 0
        count_of_zero += 1
        logger.info "found 0: n=#{n}, index=#{index} count_of_zero=#{count_of_zero}" if $debug_lib
      end
      if n == 1
        summed_up_combination << count_of_zero
        count_of_zero = 0
        logger.info "push: n=#{n}, index=#{index} count_of_zero=#{count_of_zero}" if $debug_debug
      end
      if index == current_combination.size - 1
        summed_up_combination << count_of_zero
        count_of_zero = 0
        logger.info "end: n=#{n}, index=#{index} count_of_zero=#{count_of_zero}" if $debug_lib
      end
    }

    # no need to plus one since we assume the balls start from 0
    #summed_up_combination.map { |n| n+1 }

    pp summed_up_combination if $debug_debug
    logger.info "sum_up_ball_in_the_box>>" if $debug_debug
    summed_up_combination

  end

  def self.get_nth_combination(m, n, nth)
    current_combination = nil
    nth.times { |index|
      current_combination = get_next_combination(m, n, current_combination)
    }
    current_combination
  end

  def self.get_combinations(m, n)
    i=0
    while i < 10000000
      logger.info "i=#{i}" if $debug
      c=get_next_combination(m, n, c)
      break if c.nil?
      pp c
      i += 1
    end
  end

  #$debug = true
  $debug_lib = true

=begin

  logger.info "TEST +++++++++++++++++++++++++++++"
  #get_combinations(100, 4)
  #get_combinations(7, 4)
  #get_combinations(7, 1)
  #get_combinations(7, 7)
  get_combinations(3, 1)
  logger.info "expect [1, 1, 0]"
  get_combinations(1, 1)
  logger.info "expect [1]"
  get_combinations(1, 0)
  logger.info "expect [1, 1]"
  #get_combinations(0, 0)
  #logger.info "expect [1, 1, 1]"

  # unit test

  # unit test
  # get_combinations(7, 0)
  logger.info "TEST +++++++++++++++++++++++++++++"

  initial_combination=[0]
  logger.info "initial_combination=#{initial_combination}"
  split_combination = split_ball_in_the_box(initial_combination)
  logger.info "split_combination=#{split_combination}"
  sum_up_combination = sum_up_ball_in_the_box(split_combination)
  logger.info "sum_up_combination=#{sum_up_combination}"
  if initial_combination != sum_up_combination
    exit
  else
    logger.info "assertion:passed: initial_combination == sum_up_combination: #{initial_combination} == #{sum_up_combination}"
  end


  initial_combination=[1]
  logger.info "initial_combination=#{initial_combination}"
  split_combination = split_ball_in_the_box(initial_combination)
  logger.info "split_combination=#{split_combination}"
  sum_up_combination = sum_up_ball_in_the_box(split_combination)
  logger.info "sum_up_combination=#{sum_up_combination}"
  if initial_combination != sum_up_combination
    exit
  else
    logger.info "assertion:passed: initial_combination == sum_up_combination: #{initial_combination} == #{sum_up_combination}"
  end

  initial_combination=[0, 3, 0, 2]
  logger.info "initial_combination=#{initial_combination}"
  split_combination = split_ball_in_the_box(initial_combination)
  logger.info "split_combination=#{split_combination}"
  sum_up_combination = sum_up_ball_in_the_box(split_combination)
  logger.info "sum_up_combination=#{sum_up_combination}"
  if initial_combination != sum_up_combination
    exit
  else
    logger.info "assertion:passed: initial_combination == sum_up_combination: #{initial_combination} == #{sum_up_combination}"
  end

  initial_combination=[0, 3, 2, 0]
  logger.info "initial_combination=#{initial_combination}"
  split_combination = split_ball_in_the_box(initial_combination)
  logger.info "split_combination=#{split_combination}"
  sum_up_combination = sum_up_ball_in_the_box(split_combination)
  logger.info "sum_up_combination=#{sum_up_combination}"
  if initial_combination != sum_up_combination
    exit
  else
    logger.info "assertion:passed: initial_combination == sum_up_combination: #{initial_combination} == #{sum_up_combination}"
  end

  initial_combination=[0, 3, 2, 1, 0, 11, 9, 1]
  logger.info "initial_combination=#{initial_combination}"
  split_combination = split_ball_in_the_box(initial_combination)
  logger.info "split_combination=#{split_combination}"
  sum_up_combination = sum_up_ball_in_the_box(split_combination)
  logger.info "sum_up_combination=#{sum_up_combination}"
  if initial_combination != sum_up_combination
    exit
  else
    logger.info "assertion:passed: initial_combination == sum_up_combination: #{initial_combination} == #{sum_up_combination}"
  end

  #exit



  m=3
  n_max=nil
  current_combination=nil
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect:[1, 1], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect:[1, 1, 0], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 1, 0]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [1, 0, 1], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 0, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [0, 1, 1], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  m=3
  n_max=nil
  current_combination=[0, 1, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [1, 1, 0, 0], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  m=1
  n_max=3



  m=3
  n_max=nil
  current_combination=nil
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect:[1, 1], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect:[1, 1, 0], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 1, 0]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [1, 0, 1], current_combination=#{current_combination}"

  m=3
  n_max=nil
  current_combination=[1, 0, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [0, 1, 1], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  m=3
  n_max=nil
  current_combination=[0, 1, 1]
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, current_combination=#{current_combination}"
  current_combination=get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [1, 1, 0, 0], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  m=1
  n_max=3
  current_combination=nil
  logger.info "TEST get_next_combination_with_max_n: m=#{m}, n_max=#{n_max}, current_combination=#{current_combination}"
  current_combination = get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  logger.info "TEST get_next_combination_with_max_n: m=#{m}, n_max=#{n_max}, current_combination=#{current_combination}"
  current_combination = get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [0], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  logger.info "TEST get_next_combination_with_max_n: m=#{m}, n_max=#{n_max}, current_combination=#{current_combination}"
  current_combination = get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect [0, 0], current_combination=#{current_combination}"
  logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  logger.info "TEST get_next_combination_with_max_n: m=#{m}, n_max=#{n_max}, current_combination=#{current_combination}"
  current_combination = get_next_combination_with_max_n(m, n_max, current_combination)
  logger.info "expect nil, current_combination=#{current_combination}"
  # should not call sum_up_ball_in_the_box if nil
  #logger.info "sum_up_ball_in_the_box(current_combination)=#{sum_up_ball_in_the_box(current_combination)}"

  #exit
=end
end
