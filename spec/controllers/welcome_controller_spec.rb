require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'tweet'" do

    it "post message to twitter" do
      time = Time.now
      Time.stub(:now).and_return(time)

      tweet = double('Twitter::Tweet')
      Twitter.stub(:update).and_return(tweet)

      Twitter.should_receive(:update).with("@gerusy Coffee please. (#{time})")

      post 'tweet'
    end


    shared_examples_for "redirect to 'index'" do
      it "returns http success" do
        expect(response).to redirect_to(:action => 'index')
      end
    end

    context 'tweet success' do
      before do
        tweet = double('Twitter::Tweet')
        Twitter.stub(:update).and_return(tweet)

        post 'tweet'
      end

      it_behaves_like "redirect to 'index'"

      it "show success message" do
        expect(flash[:error]).to be_nil
        expect(flash[:info]).not_to be_nil
      end
    end

    context 'tweet fail' do
      before do
        error = double('Twitter::Error')
        Twitter.stub(:update).and_raise(error)

        post 'tweet'
      end

      it_behaves_like "redirect to 'index'"

      it "show fail message" do
        expect(flash[:error]).not_to be_nil
        expect(flash[:info]).to be_nil
      end
    end
  end
end

