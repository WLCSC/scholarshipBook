namespace :cleanup do
    task :rollover => :environment do
        Score.all.each do |s|
            s.delete
        end
        Review.all.each do |r|
            r.delete
        end
        Datum.all.each do |d|
            d.delete
        end
        Application.all.each do |a|
            a.delete
        end
        Applicant.all.each do |a|
            a.delete
        end
        User.all.each do |u|
            u.delete unless u.roles.count > 0
        end
        Assignment.all.each do |a|
            a.delete
        end
        Invitation.all.each do |i|
            i.delete
        end
    end

    task :open => :environment do
        Scholarship.all.each do |s|
            s.active = true
            s.save
        end
    end
    
    task :close => :environment do
        Scholarship.all.each do |s|
            s.active = false
            s.save
        end
    end
end
