module StatusModule
  def self.included(recipient)
    recipient.class_eval do
      include ModelInstanceMethods
    end
  end
  
  # Instance Methods
  module ModelInstanceMethods
    
    def deactivate
      self.update_attributes(:status => 0)
    end
    
    def suspend
      self.update_attributes(:status => 2)
    end
    
    def activate
      self.update_attributes(:status => 1)
    end
    
  end
end

#This is where your module is being included into ActiveRecord
if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, StatusModule)
end