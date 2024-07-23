# frozen_string_literal: true

require 'spec_helper'

describe 'golang' do
  on_supported_os(hardwaremodels: ['x86_64']).each do |os, os_facts|
    context "when #{os}" do
      let(:facts) do
        if os_facts[:os]['name'] == 'Debian'
          os = os_facts[:os]
          os['architecture'] = 'x86_64'
          os_facts[:os] = os
        end
        os_facts
      end

      it { is_expected.to compile.with_all_deps }

      it do
        is_expected.to contain_file('/opt/go-1.22.5').with(
          ensure: 'directory',
          owner: 'root',
          group: 'root',
          mode: '0755',
        )
      end

      it do
        is_expected.to contain_archive('/tmp/go1.22.5.linux-amd64.tar.gz').with(
          source: 'https://dl.google.com/go/go1.22.5.linux-amd64.tar.gz',
          extract: 'true',
          extract_path: '/opt/go-1.22.5',
          extract_command: 'tar xfz %s --strip-components=1',
          creates: '/opt/go-1.22.5/bin/go',
          cleanup: 'true',
          user: 'root',
          group: 'root',
          require: 'File[/opt/go-1.22.5]',
          before: [
            'File[go-binary]',
            'File[gofmt-binary]'
          ],
        )
      end

      it do
        is_expected.to contain_file('go-binary').with(ensure: 'link', path: '/usr/bin/go', target: '/opt/go-1.22.5/bin/go')
      end

      it do
        is_expected.to contain_file('gofmt-binary').with(ensure: 'link', path: '/usr/bin/gofmt', target: '/opt/go-1.22.5/bin/gofmt')
      end
    end
  end
end
