namespace :test_results do
  desc 'load csv data'
  task load: :environment do
    # csv = CSV.parse(file, headers: true)
    # text=File.open('xxx.txt').read
    text = File.open(File.join(Rails.root, "lib", "tasks", "Training_reto.txt")).read
    text.gsub!(/\r\n?/, "\n")
    text.each_line.with_index do |line, i|
      next if i == 0
      properties = line.split("\t")
      puts properties.join(',')
      Result.create(
        season: properties[0],
        league: properties[1],
        date: Time.zone.parse(properties[2]),
        home_team: properties[3],
        away_team: properties[4],
        home_score: properties[5],
        away_score: properties[6],
        difference: properties[7],
        result: properties[8][0].downcase,
      )
    end
  end
end
