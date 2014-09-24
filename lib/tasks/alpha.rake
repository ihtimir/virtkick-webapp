namespace :alpha do
  desc 'Remove old virtual machines and accounts'
  task cleanup: :environment do
    User.guest.to_delete.each do |user|
      user.destroy
    end
  end
end
