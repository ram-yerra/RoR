class User < ActiveRecord::Base

  validates_format_of :email,
                    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                    :message => "Please enter a valid email id"
                
  validates_format_of :firstname,
                    :with => /^[A-Za-z.]*\z/,
                    :message => "cannot contain numbers or white space"
                    
  validates_format_of :lastname,
                    :with => /^[A-Za-z.]*\z/,
                    :message => "cannot contain numbers or white space"
                    
  validates_uniqueness_of :email
  validates_uniqueness_of :login

  validates_confirmation_of :password
  validates_presence_of :confirmation

  validates_presence_of :firstname, :lastname, :email, :login

  validates_length_of :firstname, :maximum=>30, :message=>"Please enter less than 30 characters . You have entered %d characters."
  validates_length_of :lastname, :maximum=>30, :message=>"Please enter less than 30 characters . You have entered %d characters."
  validates_length_of :password, :within => 6..20, :too_long => "pick a shorter password", :too_short => "pick a longer password"
  validates_length_of :confirmation, :within => 6..20, :too_long => "pick a shorter password", :too_short => "pick a longer password"

end
