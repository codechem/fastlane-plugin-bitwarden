# bitwarden plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-bitwarden)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-bitwarden`, add it to your project by running:

```bash
fastlane add_plugin bitwarden
```

## About

Bitwarden CLI warpper plugin

This plugin is a wrapper around the Bitwarden CLI, it provides very basic functionality to enable quick and easy access to your Bitwarden vault.

One nice use-case for a plugin like this is to automate and safely keep app deployment/build secrets like for example Android keystores and such.

It needs the [Bitwarden CLI](https://help.bitwarden.com/article/cli/) installed and available somewhere in `$PATH`. This can be overridden by using the `:cli_path` variable in all actions, or the analogous `BW_CLI_PATH` environment variable. 

By default it uses https://bitwarden.com as the Server URL, can be overriden with `BW_SERVER_URL` for a self-hosted instance.

Documentation is **TODO**, see the actions' source and the example `Fastfile` for now.

**This plugin is in an early stage of development, any contributions are welcome.**

## Example
Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

Make sure to setup the necessary variables or edit the `Fastfile` in order to be able to test everything out.

## Run tests for this plugin

Note: The tests are still not done so - **TODO**.

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
