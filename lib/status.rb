module Status
  DEACTIVATED = 0
  ACTIVATED   = 1
  SUSPENDED   = 2

  def deactivate
    self.update_attributes(status: DEACTIVATED)
  end

  def suspend
    self.update_attributes(status: SUSPENDED)
  end

  def activate
    self.update_attributes(status: ACTIVATED)
  end
end

#This is where your module is being included into ActiveRecord
if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, Status)
end
