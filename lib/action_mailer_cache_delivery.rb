ActionMailer::Base.class_eval do
  
  TEMP_DIR_PATH = File.join(RAILS_ROOT,'tmp')
  CACHE_DIR_PATH = File.join(RAILS_ROOT,'tmp','cache')
  DELIVERIES_CACHE_PATH = File.join(RAILS_ROOT,'tmp','cache','action_mailer_cache_deliveries.cache')
  
  def perform_delivery_test(mail)
    mails = File.exist?(DELIVERIES_CACHE_PATH) ? File.open(DELIVERIES_CACHE_PATH,'r') { |f| Marshal.load(f) } : []
    mails << mail
    Dir.mkdir(TEMP_DIR_PATH) unless File.exist?(TEMP_DIR_PATH)
    Dir.mkdir(CACHE_DIR_PATH) unless File.exist?(CACHE_DIR_PATH)
    File.open(DELIVERIES_CACHE_PATH,'w') { |f| Marshal.dump(mails, f) }
  end
  
  def self.deliveries
    File.exist?(DELIVERIES_CACHE_PATH) ? File.open(DELIVERIES_CACHE_PATH,'r') { |f| Marshal.load(f) } : []
  end 
  
  def self.clear_deliveries
    File.open(DELIVERIES_CACHE_PATH,'w') { |f| Marshal.dump([], f) }
  end
  
end