# Ramco Ruby

This is an unofficial ruby client for the [RAMCOAMS API](https://api.ramcoams.com/api/v2/ramco_api_v2_doc.pdf).  The end goal is a complete, intuitive and simple ruby API for working with the RAMCOAMS API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ramco'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ramco

# Usage

Instantiate the client using a provided RAMCOAMS API key:
  
    ramco = Ramco.api_key("api_key")

##GetEntity

Fetch the attributes and/or relationships of one specific entity using guid.

    ramco.get_entity({"entity" => "Contact", "guid" => "6868642f-0144-e811-9c17-00155d10120d", "attributes" => "ContactId,FirstName,LastName"})

 * post params
    * Entity = Type of entity being queried (ex: Contact)
    * Guid = guid of entity to return
    * Attributes = comma separated list of attributes to return
    
##GetEntities

Fetch the attributes and/or relationships of multiple entities of one type using a user-defined filter.

    ramco.get_entities({"entity" => "Contact", "attributes" => "ContactId,FirstName,LastName", "maxresults" => "5"})

 * post params
    * Entity = Name of entity being queried (ex: Contact)
    * Filter (optional) = User-specified filter string
    * Attributes = comma separated list of attributes to return
    * StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)
    * MaxResults (optional) = Maximum number of entities to return
    
##GetEntityMetadata

Fetch metadata on entity type Contact (includes entity description, attributes and relationships).

    ramco.get_entity_metadata({"entity" => "Contact"})

##GetEntityTypes

Fetch all entities in the system.

    ramco.get_entity_types

##GetOptionSet

Fetch the valid value/label pairs for the specified OptionSet (what Ramco calls a picklist)

    ramco.get_option_set({"entity" => "Contact", "attribute" => "PreferredPhone"})

  * post params
    * Entity = Name of entity being queried (ex: Contact)
    * Attribute= Name of the attribute being queried (ex: PreferredPhone)

##ValidateUser

Returns the globally unique id of a contact that matches the provided cobalt_username and cobalt_password parameters. Returns a 422 error when there is no user with provided username/password combination.

    ramco.validate_user({"cobalt_username" => "username", "cobalt_password" => "password"})
  
  * Post params:
    * cobalt_username = User’s username
    * cobalt_password = User’s password

##ClearCache

Clears the server-side metadata cache. If an entity or attribute has been added (or removed), then clearing the cache will permit the changes to be reflected immediately. The cache will normally expire every 24 hours.

    ramco.clear_cache

# Testing

The test suite uses [VCR](https://github.com/myronmarston/vcr) to cache actual requests to the RAMCO API in a directory called responses in the spec directory.

In order for VCR to make and cache the actual calls to the RAMCO API you will need to copy spec/settings.yml.sample to spec/settings.yml and configure it with your RAMCO key or add RAMCO_KEY as an environment variable.

This file is ignored by git (see .gitignore) so you can commit any changes you make to the gem without having to worry about your key being released into the wild.

Now run the test suite:

    bundle
    bundle exec rake api

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/message-blocks/ramco-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

If you'd like to hack on Ramco-ruby, start by forking the repo on GitHub:

https://github.com/message-blocks/ramco-ruby

The best way to get your changes merged back into core is as follows:

1. Clone down your fork
1. Create a thoughtfully named topic branch to contain your change
1. Hack away
1. Add tests and make sure everything still passes by running `bundle exec rake`
1. If you are adding new functionality, document it in the README
1. Do not change the version number, we will do that on our end
1. If necessary, rebase your commits into logical chunks, without errors
1. Push the branch up to GitHub
1. Send a pull request for your branch

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Ramco Ruby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ramco/blob/master/CODE_OF_CONDUCT.md).
