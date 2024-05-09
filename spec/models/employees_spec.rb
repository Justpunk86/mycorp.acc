require 'spec_helper'
require 'rails_helper'

describe Employee, type: :model do
  describe 'validation presence' do
    
    it { should validate_presence_of :last_name }

    it { should validate_presence_of :first_name }
    it { should validate_presence_of :father_name }
    it { should validate_presence_of :snils }
    it { should validate_presence_of :tin }
    it { should validate_presence_of :passport_sn }
    it { should validate_presence_of :passport_num }
    it { should validate_presence_of :onboarding_date }
    it { should validate_presence_of :insurance_start_date }

  end

  describe 'validation format' do
    it { should allow_value('Name').for(:last_name) }
    
    it { should allow_value('Name').for(:first_name) }
    it { should allow_value('Name').for(:father_name) }
    it { should allow_value('12345678910').for(:snils) }
    it { should allow_value('1234567891').for(:tin) }
    it { should allow_value('1234').for(:passport_sn) }
    it { should allow_value('123456').for(:passport_num) }

  end

  describe 'validation length' do
    
    it { should validate_length_of(:snils).is_equal_to(11) }
    it { should validate_length_of(:tin).is_equal_to(10) }
    it { should validate_length_of(:passport_sn).is_equal_to(4) }
    it { should validate_length_of(:passport_num).is_equal_to(6) }

  end

  describe 'validation uniqueness' do
    
    it { should validate_uniqueness_of(:snils) }
    it { should validate_uniqueness_of(:tin) }
    # it { should validate_uniqueness_of(:passport_sn) }
    # it { should validate_uniqueness_of(:passport_num) }

  end

end

# describe 'something' do
#   it "does something" do

#   end
# end
