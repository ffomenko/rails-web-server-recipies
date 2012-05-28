depends "build-essential"

%w{ ubuntu }.each do |os|
  supports os
end
