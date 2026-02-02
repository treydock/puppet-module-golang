# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'golang class:' do
  context 'with default parameters' do
    it 'runs successfully' do
      pp = <<-PP
      class { 'golang': version => '1.24.12' }
      PP

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.24} }
    end
  end

  context 'with go upgrade' do
    it 'runs successfully' do
      pp = <<-PP
      class { 'golang': version => '1.25.6' }
      PP

      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe command('/usr/bin/go version') do
      its(:stdout) { is_expected.to match %r{1.25} }
    end
  end
end
