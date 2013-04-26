require 'spec_helper'

describe 'Participant signs in' do 
  let(:county) { create(:county) }
  let!(:user) { create(:user, county: county) }

  context 'with valid email and password' do
    context 'with no survey' do
      before { sign_in_as user }
      it 'signs out user' do
        page.should have_content('county does not have any active surveys')
        page.should have_button('Sign in')
      end
    end
    context 'with no active moments' do
      before do
        create(:survey, county_id: county.id,
                              start_date: 30.days.ago, end_date: 29.days.ago,
                              sample_size: 1)
        sign_in_as user
      end
      it 'signs out user' do
        page.should have_content('You do not have any active moments')
        page.should have_button('Sign in')
      end
    end
    context 'with 1 active moment' do
      before do
        create(:survey, county_id: county.id,
                              start_date: 3.days.ago, end_date: 2.days.ago,
                              sample_size: 1)
        sign_in_as user
      end
      it 'takes user to new response' do
        page.should have_content('New response for moment')
        page.should have_link('Sign out')
      end
    end
    context 'with 2 active moments' do
      before do
        create(:survey, county_id: county.id,
                              start_date: 3.days.ago, end_date: 2.days.ago,
                              sample_size: 2)
        sign_in_as user
      end
      it 'takes user to active moments' do
        page.should have_content('Active moments')
        page.should have_link('Sign out')
      end
    end
  end

  context 'with invalid email' do
    before { sign_in_with('invalid_email', 'password') }
    it "doesn't sign user in" do
      page.should have_content('Invalid email or password.')
      page.should have_content('Sign in')
    end
  end

  context 'with blank password' do
    before { sign_in_with(user.email, '') }
    it "doesn't sign user in" do
      page.should have_content('Invalid email or password.')
      page.should have_content('Sign in')
    end
  end
end