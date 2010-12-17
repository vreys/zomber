module EpisodesHelper
  VIDEO_CODECS = {
    :mp4  => 'avc1.42E01E, mp4a.40.2',
    :webm => 'vp8, vorbis'
  }
  
  def video_source_tag_for_episode(episode, format)
    opts = {}
    
    if [:mp4, :webm].include?(format)
      opts[:source] = repo_url( :subdomain     => 'repo',
                             :serial_slug   => episode.season.serial.slug,
                             :season_index  => episode.season.index,
                             :episode_index => episode.index,
                             :format        => format.to_s )

      opts[:codecs] = VIDEO_CODECS[format]
      opts[:type]   = Mime.const_get(format.to_s.upcase).to_s
    else
      opts[:source] = erlyviedo_url(episode.mp4)
    end

    render :partial => 'video_source', :locals => opts
  end

  def render_video_source_type_attr(type, codecs)
    raw(%Q{type="#{type}; codecs=#{codecs}"})
  end

  def erlyviedo_url(file_path)
    "http://#{request.env['SERVER_NAME']}:8082/iphone/playlists#{file_path}.m3u8"
  end
end
