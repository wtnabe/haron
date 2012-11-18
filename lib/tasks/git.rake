# -*- mode: ruby -*-

namespace :git do
  desc 'git ls-files -o'
  task :untracked do
    sh 'git ls-files -o -X .gitignore'
  end
end
