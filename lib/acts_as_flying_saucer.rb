# ActsAsFlyingSaucer
module ActsAsFlyingSaucer
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  private
  module ClassMethods
    
    def acts_as_flying_saucer
      puts "hola"
    end
    
  end
end
