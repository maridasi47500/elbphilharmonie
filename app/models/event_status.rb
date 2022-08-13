class EventStatus < ApplicationRecord
    belongs_to :event
    before_validation :fillinstatusorsub
    def fillinstatusorsub
      if !(self.status.present?)
        self.errors.add(:status, :blank)
        
      end
        if !(self.status_sub.present?)
        self.errors.add(:status_sub, :blank)
        
      end
    end
  
end
