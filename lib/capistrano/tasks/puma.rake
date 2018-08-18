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
        unicorn_pid = capture("cat #{current_path}/tmp/pids/unicorn.pid")
        case action_name
        when :reload
          puts "reload now..."
          execute "pumactl restart"
        when :start
          if test("[ -f #{current_path}/tmp/pids/puma.pid ]")
            execute "cd #{current_path}; kill #{puma_pid}"
          end
          puts "start now..."
          execute "puma -C config/puma.rb"
        when :stop
          puts "stop now..."
          execute "cd #{current_path}; kill #{puma_pid}"
        end
      end
    end
  end

end
