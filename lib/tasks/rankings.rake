require 'open-uri'
namespace :rankings do
  desc 'fetches world teams rankings'
  task world: :environment do
    base_url = "http://footballdatabase.com/ranking/world"
    pages = 47
    cols = [
      [:rank, 'td[1]/text()'],
      [:name, 'td[2]/a[1]/div[2]/text()'],
      [:country, 'td[2]/a[2]/text()'],
      [:rank_points, 'td[3]/text()'],
    ]
    pages.times.each do |p|
      url = "#{base_url}/#{p+1}"
      doc = Nokogiri::HTML(open(url))
      rows = doc.xpath('//table[1]/tbody/tr')
      rows.collect.each do |row|
        d = {}
        cols.each do |attr, path|
          d[attr] = row.at_xpath(path).to_s.strip
        end
        next if d.empty?
        t = Team.create(d)
        puts "#{t.rank}\t#{t.name}\t #{t.rank_points}"
      end
    end
  end
end
