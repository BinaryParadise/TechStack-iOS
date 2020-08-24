# watchman watch-del HomeworkCenter
# watchman watch HomeworkCenter
# watchman trigger-del $(pwd)/HomeworkCenter 'cmr'
# watchman -- trigger HomeworkCenter 'cmr' -- ruby ../extractor.rb
tail -f /usr/local/var/run/watchman/$(whoami)-state/log
