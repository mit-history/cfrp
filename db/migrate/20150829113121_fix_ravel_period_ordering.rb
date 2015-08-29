class FixRavelPeriodOrdering < ActiveRecord::Migration

  # seating category profiles table has been updated in git; drop old records and reload it
  def up

    dir = File.dirname(__FILE__)

    execute "DELETE FROM seating_category_profile WHERE profile='Ravel 1'"

    dbconn = ActiveRecord::Base.connection_pool.checkout
    raw  = dbconn.raw_connection
    count = nil

    result = raw.copy_data %q{COPY seating_category_profile(profile, period, start_date, end_date, seating_category_ids, category, note) FROM STDIN WITH (FORMAT csv)} do
      File.open(dir + '/../data/2015.06.25.ravel_seating_category_profile.csv', 'r').each do |line|
        raw.put_copy_data line
      end
    end

    count = dbconn.select_value("select count(*) from seating_category_profile").to_i

    ActiveRecord::Base.connection_pool.checkin(dbconn)

    count

  end

  def down

    execute "DELETE FROM seating_category_profile WHERE profile='Ravel 1'"

  end
end
