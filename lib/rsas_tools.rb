module RsasTools
  
  def self.arr_attr_to_int(arr)
    i_arr = [];
    arr.each do |value|
      i_arr << value.to_i;
    end
    return i_arr;
  end

  def self.time_to_utc(t)
    return (Time.utc(t.year, t.month, t.day, t.hour, t.min));
  end
  
  def self.get_where_search_condition(search_fields, search_string)
    return "" if search_string.blank?
    search_value = search_string.split(/[^a-zA-Z0-9_@.]+/)
    search_conditions = []
    search_fields.each do |field|
      search_value.each do |value|
        search_conditions << "lower(#{field}) like lower('%#{value}%')"
      end
    end
    return search_conditions.join(" or ")
  end
    
  def self.get_offset_and_limit(total, page, page_count)
    if page_count == 0
      return_offset = 0
      return_limit = total
      return_page = 1
    else
      return_offset = (page-1)*page_count > total ? 0 : (page-1)*page_count
      return_limit = page_count
      return_page = (page-1)*page_count > total ? 1 : page
    end
    return return_offset, return_limit, return_page
  end
end














