class Time

  def pst_s(format = '%Y-%m-%d %H:%M:%S')
    return self.in_time_zone("Pacific Time (US & Canada)").strftime(format)
  end
end