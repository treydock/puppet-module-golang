require 'spec_helper'

describe 'golang' do
  on_supported_os(hardwaremodels: ['x86_64']).each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      it do
        is_expected.to contain_file('/opt/go-1.13.8').with(
          ensure: 'directory',
          owner: 'root',
          group: 'root',
          mode: '0755',
        )
      end

      it do
        is_expected.to contain_archive('/tmp/go1.13.8.linux-amd64.tar.gz').with(
          source:      'https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz',
          extract:      'true',
          extract_path: '/opt/go-1.13.8',
          extract_command: 'tar xfz %s --strip-components=1',
          creates: '/opt/go-1.13.8/bin/go',
          cleanup: 'true',
          user: 'root',
          group: 'root',
          require: 'File[/opt/go-1.13.8]',
          before: [
            'File[go-binary]',
            'File[gofmt-binary]',
          ],
        )
      end

      it do
        is_expected.to contain_file('go-binary').with(ensure: 'link', path: '/usr/bin/go', target: '/opt/go-1.13.8/bin/go')
      end

      it do
        is_expected.to contain_file('gofmt-binary').with(ensure: 'link', path: '/usr/bin/gofmt', target: '/opt/go-1.13.8/bin/gofmt')
      end
    end
  end
end
