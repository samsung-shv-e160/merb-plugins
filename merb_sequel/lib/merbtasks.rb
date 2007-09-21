namespace :sequel do
  namespace :db do
    desc "Perform migration using migrations in schema/migrations"
    task :migrate => :merb_env do
      Sequel::Migrator.apply(Merb::Orms::Sequel.connect, "schema/migrations", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
    end
  end
  
  namespace :sessions do
    desc "Clears sessions"
    task :clear => :merb_env do
      table_name = (Merb::Plugins.config[:sequel][:session_table_name] || "sessions")
      
      Merb::Orms::Sequel.connect.execute("DELETE FROM #{table_name}")
    end
  end
end