namespace :admin do
  desc "Create admin user"
  task create_admin: :environment do
    admin = User.find_or_create_by(email: 'admin@secondspark.com') do |user|
      user.name = 'Admin User'
      user.password = 'admin123'
      user.password_confirmation = 'admin123'
      user.address = '123 Admin Street, Winnipeg, MB'
      user.role = 'admin'
    end
    
    if admin.persisted?
      puts "Admin user created successfully!"
      puts "Email: admin@secondspark.com"
      puts "Password: admin123"
    else
      puts "Error creating admin user:"
      admin.errors.full_messages.each { |msg| puts "  #{msg}" }
    end
  end
end
