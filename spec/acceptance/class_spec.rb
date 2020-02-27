require 'spec_helper_acceptance'

describe 'golang class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'golang': version => '1.13.8' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.13.8} }
    end
  end

  context 'upgrades go' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'golang': version => '1.14' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.14} }
    end
  end
end
