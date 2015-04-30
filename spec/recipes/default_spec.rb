require 'spec_helper'

describe 'flyway_test::default' do
  cached(:chef_run) do
    ChefSpec::ServerRunner.new(step_into: 'flyway', file_cache_path: '/var/chef/cache')
      .converge(described_recipe)
  end

  context 'compiling the test recipe' do
    it 'installs java' do
      expect(chef_run).to install_apt_package('openjdk-7-jre-headless')
    end

    it 'sets up mysql service' do
      expect(chef_run).to create_mysql_service('default')
    end

    it 'hack starts mysql service' do
      expect(chef_run).to run_execute('hack-start mysql on debian in docker')
    end

    it 'adds test db info' do
      expect(chef_run).to run_execute('add test db info')
    end

    it 'creates flyway[default]' do
      expect(chef_run).to create_flyway('default')
    end
  end

  context 'stepping into flyway[default] resource' do
    it 'creates directory' do
      expect(chef_run).to create_directory('/opt/flyway-default/')
    end

    # this is broken, fix cache_path nonsense!
    it 'downloads flyway' do
      expect(chef_run).to create_remote_file('default: download flyway tar')
    end

    it 'extracts flyway tar' do
      expect(chef_run).to_not run_bash('default: extract flyway tar')
      extract_action = chef_run.bash('default: extract flyway tar')
      expect(extract_action).to subscribe_to('remote_file[default: download flyway tar]').on(:run).immediately
    end

    it 'creates flyway conf' do
      expect(chef_run).to create_template('/opt/flyway-default/conf/flyway.conf')
    end

    it 'creates flyway migrations' do
      expect(chef_run).to create_remote_directory('/opt/flyway-default/sql')
    end

    it 'performs flyway migrations' do
      expect(chef_run).to run_execute('default: perform migrations')
    end
  end
end
