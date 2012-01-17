# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

### Create with new, after that skip confirmation mail, save
### Ensure admin with the same name os not created on running the seed after implementing suggestion.
### Use find_or_initialize

@admin = Admin.create(:email => 'test@test.com', :password => 'vinsol', :password_confirmation => 'vinsol')
@admin.skip_confirmation!
@admin.save!
