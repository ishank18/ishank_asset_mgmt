require 'csv'

task :load_employees => :environment do
	CSV.foreach("#{Rails.root}/db/employees.csv") do |row|
		@employee = Employee.find_or_initialize_by_email row[2]
		@employee.employee_id = row[1]
		@employee.name = row[0]
		@employee.save
	end
	puts " -- Done -- "
end
