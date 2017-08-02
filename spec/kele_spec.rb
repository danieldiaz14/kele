require 'spec_helper'

describe Kele, type: :request do
  context '.kele' do

    describe '#initialize' do
      it 'authenticates user', vcr: {cassette_name: :initialize} do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        expect(kele.instance_variable_get(:@auth_token)).to be_a String
      end
    end

    describe '#get_me', vcr: {cassette_name: :get_me} do
      it 'returns an object' do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        response = kele.get_me
        expect(response.instance_variable_get(:@user_data)).to be_a Object
      end
    end

    describe '#get_roadmap', vcr: {cassette_name: :get_roadmap} do
      it 'returns an object' do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        response = kele.get_roadmap(ENV['ROADMAP_ID'])
        expect(response.instance_variable_get(:@roadmap)).to be_a Object
      end
    end

    describe '#get_checkpoint', vcr: {cassette_name: :get_checkpoint} do
      it 'returns an object' do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        response = kele.get_checkpoint(ENV['CHECKPOINT_ID'])
        expect(response.instance_variable_get(:@checkpoint)).to be_a Object
      end
    end

    describe '#get_messages', vcr: {cassette_name: :get_messages} do
      it "returns messages by page" do
        kele = Kele.new(ENV['EMAIL'], ENV['PASSWORD'])
        response = kele.get_messages(ENV['PAGE_ID'])
        expect(response.instance_variable_get(:@messages)).to be_a Object
      end
    end
  end
end