require 'spec_helper'

describe RepositoryController do
  describe "sending a video file" do
    context "when a user is not authenticated" do
      before do
        get 'send_video', {
          :serial_slug   => 'house',
          :season_index  => 1,
          :episode_index => 1,
          :subdomain     => 'repo',
          :format        => 'mp4'
        }
      end

      it "should respond with 403 status code" do
        response.status.should eql(403)
      end

      it "should respond with empty body" do
        response.body.should eql(" ")
      end
    end
    
    context "when a user is authenticated" do
      before do
        sign_in(Factory(:user))

        @serial  = Factory(:serial, :slug => 'house')
        @season  = Factory(:season, :index => '1', :serial => @serial)
        @episode = Factory(:episode, :index => '1', :season => @season)

        @request_params = {
          :serial_slug   => 'house',
          :season_index  => 1,
          :episode_index => 1,
          :subdomain     => 'repo',
          :format        => 'mp4'
        }

        Episode.any_instance.stubs(:webm).returns(Rails.root.join('test', 'factories', 'test.webm'))
        Episode.any_instance.stubs(:mp4).returns(Rails.root.join('test', 'factories', 'test.mp4'))
      end

      it "should respond with 200 status code" do
        get 'send_video', @request_params

        response.status.should eql(200)
      end

      it "should find serial by slug" do
        get "send_video", @request_params

        assigns[:serial].should eql(@serial)
      end

      it "should find season by index" do
        get "send_video", @request_params

        assigns[:season].should eql(@season)
      end

      it "should find episode by index" do
        get "send_video", @request_params

        assigns[:episode].should eql(@episode)
      end

      it "should respond with video/webm content-type on webm request format" do
        get 'send_video', @request_params.merge(:format => "webm")

        response.content_type.should eql(Mime::WEBM)
      end

      it "should respond with video/h264 content-type on mp4 request format" do
        get "send_video", @request_params.merge(:format => "mp4")

        response.content_type.should eql(Mime::MP4)
      end

      it "should respond with X-Accel-Redirect header with path to a file" do
        get "send_video", @request_params.merge(:format => "mp4")

        response.headers["X-Accel-Redirect"].should eql(File.join('/stream', @episode.mp4).to_s)
      end

      it "should respond with empty body" do
        get "send_video", @request_params

        response.body.should eql(" ")
      end
      
      context "when request serial is not exists" do
        it "should respond with 404" do
          get "send_video", @request_params.merge(:serial_slug => 'fuuuuu')

          response.status.should eql(404)
        end
      end

      context "when request season is not exists" do
        it "should respond with 404" do
          get "send_video", @request_params.merge(:season_index => '999')

          response.status.should eql(404)
        end
      end

      context "when request episode is not exists" do
        it "should respond with 404" do
          get "send_video", @request_params.merge(:episode_index => '1024')

          response.status.should eql(404)
        end
      end
    end
  end
end
