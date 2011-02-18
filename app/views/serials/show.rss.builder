# encoding: utf-8
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
    xml.channel do
      xml.title "Cписок эпизодов \"#{@serial.title}\""
      xml.description @serial.description
      xml.link 'http://zomber.tv'

      @serial.seasons.each do |season|
        @serial.seasons.all.in_groups_of(3, false).each do |group|
          group.each_with_index do |season, index|

            season.episodes.each do |episode|
              xml.item do
                xml.link(serial_episode_url(:serial_id => @serial.slug, :season_index => season.index, :episode_index => episode.index))
                xml.title "#{episode.index} эпизод[#{season.index} сезон]"

                xml.pubDate episode.updated_at.to_s(:rfc822)
                xml.guid(serial_episode_url(:serial_id => @serial.slug, :season_index => season.index, :episode_index => episode.index))
              end
            end
          end
        end
      end
    end
end

