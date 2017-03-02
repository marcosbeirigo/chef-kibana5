#
# Cookbook:: kibana5
# Resource:: kibana5_configure
#
# Copyright:: 2017, Parallels International GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource_name :kibana5_configure

property :svc_name, String, name_property: true
property :svc_user, String, default: 'kibana'
property :svc_group, String, default: 'kibana'
property :configuration, Hash, required: true

default_action :configure

action :configure do

  template '/usr/lib/systemd/system/kibana.service'  do
    source 'kibana.service.erb'
    mode '0755'
    variables user: new_resource.svc_user, exec_file: node['kibana5']['exec_file']
    notifies :restart, "service[#{new_resource.svc_name}]", :delayed
  end

  
  config = new_resource.configuration

  file config['logging.dest'] do
    mode '0644'
    owner new_resource.svc_user
    group new_resource.svc_group
    not_if { config['logging.dest'] == 'stdout' }
  end

  template node['kibana5']['config_file'] do
    cookbook 'kibana5'
    source 'kibana.yml.erb'
    owner new_resource.svc_user
    group new_resource.svc_group
    mode '0644'
    variables config: config
    notifies :restart, "service[#{new_resource.svc_name}]"
  end

  service new_resource.svc_name do
    provider Chef::Provider::Service::Systemd
    supports start: true, restart: true, stop: true, status: true
    action [:enable, :start]
  end
end
