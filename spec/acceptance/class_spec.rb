require 'spec_helper_acceptance'

describe 'golang class:' do
  context 'default parameters' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'golang': version => '1.15.9' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.15} }
    end
  end

  context 'upgrades go' do
    it 'runs successfully' do
      pp = <<-EOS
      class { 'golang': version => '1.16.1' }
      EOS

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.16} }
    end
  end
end
