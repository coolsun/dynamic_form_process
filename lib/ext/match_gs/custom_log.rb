require 'pp';

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

def logSetLevel(logLevel=$LOG_NONE_LEVEL)
  $log_level = logLevel
end

def logInfo(s, use_pp=$USE_PP)
  if use_pp
    pp "#{s}" if $LOG_INFO & $log_level
  else
    puts "#{s}" if $LOG_INFO & $log_level
  end
end

def logUser(s, use_pp=$USE_PP)
  if use_pp
    pp "#{s}" if $LOG_USER & $log_level
  else
    puts "#{s}" if $LOG_USER & $log_level
  end
end

def logSystem(s, use_pp=$USE_PP)
  if use_pp
    pp "#{s}" if $LOG_SYSTEM & $log_level
  else
    puts "#{s}" if $LOG_SYSTEM & $log_level
  end
end

def logDebug(s, use_pp=$USE_PP)
  if use_pp
    pp s if $LOG_DEBUG & $log_level
  else
    puts "#{s}" if $LOG_DEBUG & $log_level
  end
end
