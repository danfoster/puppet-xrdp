require 'spec_helper'
describe 'xrdp' do

  context 'with defaults for all parameters' do
    it { should contain_class('xrdp') }
  end
end
