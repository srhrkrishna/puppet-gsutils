require 'spec_helper'
describe 'gsutil' do

  context 'with defaults for all parameters' do
    it { should contain_class('gsutil') }
  end
end
