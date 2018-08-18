namespace :deploy do
  namespace :puma_mine do
    desc "start puma"
    task :start do
      puma_container :start
    end

    desc "reload puma"
    task :reload do
      puma_container :reload
    end

    desc "stop puma"
    task :stop do
      puma_container :stop
    end

    def puma_container action_name
      on roles(:web) do |host|
        puts "*" * 50
        puts "#{action_name} puma..."
        if test("[ -f #{current_path}/tmp/pids/puma.pid ]")
          puma_pid = capture("cat #{current_path}/tmp/pids/puma.pid")
          case action_name
          when :reload
            puts "reload now..."
            execute "cd #{current_path}; pumactl restart"
          when :start
            ;;
          when :stop
            puts "stop now..."
            execute "cd #{current_path}; kill #{puma_pid}"
          end
        else
          case action_name
          when :reload
            puts "reload now..."
            execute "cd #{current_path}; bundle exec puma -C config/puma.rb -d"
          when :start
            puts "start now..."
            execute "cd #{current_path}; bundle exec puma -C config/puma.rb -d"
          when :stop
            ;;
          end
        end
      end
    end
  end

end
