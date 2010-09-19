class SystemPermit < Permit::Base
  def initialize(ability)
    super
  end

  def permit?(user, request=nil) 
    super    
    licenses :user_admin, :blogging
  end  
end
