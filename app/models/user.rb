class MockDeviseUser
  protected
  def password_required?
    true
  end
end

 
class User < ApplicationRecord
  has_many :favoriteevents
  has_many :favevents, through: :favoriteevents, source: :event
 def is_password_required?
    puts password_required?
  end
attr_accessor :password2, :password1, :afterloginbookmarkevent
before_validation :changemypassword
def addfavorite(eventid)
  if eventid
    self.favevents << Event.find(eventid)
  end
rescue
end
def changemypassword
  if self.password1 && self.password2 && self.password1 == self.password2
    self.password = self.password1
  elsif self.password1 && self.password2
    self.errors.add(:password1, :blank) if self.password1.strip.squish == ""
    self.errors.add(:password2, :blank) if self.password2.strip.squish == ""
    self.errors.add(:password, :badpasswords)
  end
end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :newsletterusers
  has_many :newsletters, through: :newsletterusers
  validates :password,presence: true, allow_blank: true, format: {with: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/, multiline: true, message: :mymessage}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
validates :phone, phone: { possible: true, allow_blank: true, types: [:voip, :mobile], country_specifier:  -> phone {
  Phonelib.parse(phone.phone).country.try(:upcase)}}
#before_validation :validatescountry
#def validatescountry
#  p self.phone
#  p self.country
#  self.errors.add(:phone, :wrongcountry) if Phonelib.parse(self.phone).country.try(:upcase) != self.country
#end
      
      def savemyemail
        if self.email == self.email_was
          self.errors.add(:email, :myemail)
        end
      end
       validates :email, uniqueness: {scope: [:encrypted_password, :last_name, :first_name], message: :mydata}
       attr_accessor "address_country", :email_repetition, :cbCorrection, "list_1","list_2","list_3", :news
       def nopass
         self.errors.add(:password,:mypassword)
       end
       def noemail
         self.errors.add(:email, :notfound)
       end
       def self.findnew(myemail,pass)
         if myemail && pass
         user=self.find_by_email(myemail)
         if user && user.valid_password?(pass)
        p "ok"
      elsif user 
        user.nopass
      else
        user=User.new
        user.noemail
      end
         else
           user=User.new
      end
        user
       end
       def updatemypasswords(p1,p2)
         if p1 && p2
         if p1 != p2
           self.errors.add(:password, :badpasswords)
         else
           self.password=p1
           self.save
         end
         end
         
       end
       def zipandcity
         zip_code+" "+city
       end
       def mygender
         self.gender == "female" ? "Ms" : "Mr"
       end
       def seecountry
         Country.find_by(myvalue: country).name
       end
       before_validation :mynewvalues
       def mynewvalues
         if self.news
         if self.list_1 && !self.newsletters.find_by(id: 1)
           self.newsletters << Newsletter.where(id: 1)
         elsif !self.list_1 && self.newsletters.find_by(id: 1)
           self.newsletters.delete(Newsletter.find_by(id: 1))
         end
         if self.list_2 && !self.newsletters.find_by(id: 2)
           self.newsletters << Newsletter.where(id: 2)
         elsif !self.list_2 && self.newsletters.find_by(id: 2)
           self.newsletters.delete(Newsletter.find_by(id: 2))
         end
         if self.list_3 && !self.newsletters.find_by(id: 3)
           self.newsletters << Newsletter.where(id: 3)
         elsif !self.list_3 && self.newsletters.find_by(id: 3)
           self.newsletters.delete(Newsletter.find_by(id: 3))
         end
         end
       end
       def fullname
         first_name+" "+last_name.to_s
       end
end
