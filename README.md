# chef-kibana5

## Description

This cookbook installs and configures [Kibana](https://www.elastic.co/products/kibana) version 5.2.0 and above.

## Requirements

### Cookbooks

- [ark](https://supermarket.chef.io/cookbooks/ark)
- [systemd](https://supermarket.chef.io/cookbooks/systemd)

### Platforms

Tested only on CentOS 7. Should work on any modern Linux OS with systemd.

## Recipes
* `default.rb` - Runs `kibana5_install` and `kibana5_configure` with default options.

## Resources

### kibana5_install

This resource installs Kibana 5 binaries.

#### Attributes

|Attribute|Description|Type|Default|
|---------|-----------|----|-------|
|`name`| Simply name. Currently not used. |String||
|`version`| Version of Kibana. 5.2.0 and above are supported. |String|`5.2.1`|
|`install_method`| Installation method. Currently only `release` is supported. This means installation from official binaries provided by Elastic. |String|`release`|
|`base_dir`| Base directory for Kibana binaries. |String|`/opt/kibana`|
|`svc_user`| Kibana daemon user. |String|`kibana`|
|`svc_group`| Kibana daemon group. |String|`kibana`|

### kibana5_configure

This resource configures Kibana daemon and main configuration file.

#### Attributes

|Attribute|Description|Type|Default|
|---------|-----------|----|-------|
|`svc_name`| Name of the daemon |String||
|`svc_user`| Kibana daemon user. |String|`kibana`|
|`svc_group`| Kibana daemon group. |String|`kibana`|
|`configuration`| Hash with configuration file values. See examples. |Hash||

examples of configuration hashes:

```ruby
{
  'server.port' => 5601,
  'server.host' => 'localhost',
  'elasticsearch.url' => 'http://localhost:9200',
}
```

```ruby
{
  'server.port' => 5601,
  'server.host' => 'localhost',
  'server.name' => 'My-Kibana',
  'elasticsearch.url' => 'http://localhost:9200',
  'logging.dest' => '/var/log/kibana.log',
  'logging.verbose' => 'true',
  'elasticsearch.requestHeadersWhitelist' => '[ authorization ]',
}
```

## Usage

It is recommended to use resources directly.

## Examples
You may see examples in fixture cookbook:
[test/fixtures/kibana5-test/recipes/default.rb](test/fixtures/app-cloud-test/recipes/default.rb)
[test/fixtures/kibana5-test/recipes/nginx.rb](test/fixtures/app-cloud-test/recipes/nginx.rb)

## Authors
- Author:: Azat Khadiev (akhadiev@parallels.com)
