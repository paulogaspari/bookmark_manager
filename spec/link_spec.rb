require 'spec_helper'

describe Link do

	context "|||| The Database::     " do

		it 'has no links' do
			expect(Link.count).to eq(0)
		end

		it 'has a link after creating one' do
			Link.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			expect(Link.count).to eq(1)
		end

		it 'has a link url of makers academy after creating that record' do
			Link.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")			
			link = Link.first
			expect(link.url).to eq("http://makersacademy.com/")
		end
 
		it 'has a link with title Makers Academy after creating that record' do
			Link.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			link = Link.first
			expect(link.title).to eq("Makers Academy")
		end
 
		it 'has no link after destroying a previously created link' do
			Link.create(:title => "Makers Academy",
						:url => "http://makersacademy.com/")
			link = Link.first
			link.destroy
			expect(Link.count).to eq(0)
		end
	end
end



