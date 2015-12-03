class String
  def pst_t(format='%m/%d/%Y %H:%M')
    t_time = Time.strptime(self, format);
    zone = "Pacific Time (US & Canada)"
    return (ActiveSupport::TimeZone[zone].parse(t_time.strftime("%Y-%m-%d %H:%M:%S")));
  end
end
