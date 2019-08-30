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

## GetEntity

Fetch the attributes and/or relationships of one specific entity using guid.

    ramco.get_entity({"entity" => "Contact", "guid" => "6868642f-0144-e811-9c17-00155d10120d", "attributes" => "ContactId,FirstName,LastName"})

 * post params
    * Entity = Type of entity being queried (ex: Contact)
    * Guid = guid of entity to return
    * Attributes = comma separated list of attributes to return
    
## GetEntities

Fetch the attributes and/or relationships of multiple entities of one type using a user-defined filter.

    ramco.get_entities({"entity" => "Contact", "attributes" => "ContactId,FirstName,LastName", "maxresults" => "5"})

 * post params
    * Entity = Name of entity being queried (ex: Contact)
    * Filter (optional) = User-specified filter string
    * Attributes = comma separated list of attributes to return
    * StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)
    * MaxResults (optional) = Maximum number of entities to return
    
## GetEntityMetadata

Fetch metadata on entity type Contact (includes entity description, attributes and relationships).

    ramco.get_entity_metadata({"entity" => "Contact"})

## GetEntityTypes

Fetch all entities in the system.

    ramco.get_entity_types

## GetOptionSet

Fetch the valid value/label pairs for the specified OptionSet (what Ramco calls a picklist)

    ramco.get_option_set({"entity" => "Contact", "attribute" => "PreferredPhone"})

  * post params
    * Entity = Name of entity being queried (ex: Contact)
    * Attribute= Name of the attribute being queried (ex: PreferredPhone)

## ValidateUser

Returns the globally unique id of a contact that matches the provided cobalt_username and cobalt_password parameters. Returns a 422 error when there is no user with provided username/password combination.

    ramco.validate_user({"cobalt_username" => "username", "cobalt_password" => "password"})
  
  * Post params:
    * cobalt_username = User’s username
    * cobalt_password = User’s password

## UpdateEntity

Allows for modification of attributes of existing Entities.

    ramco.update_entity({"entity" => "Contact", "guid" => "6868642f-0144-e811-9c17-00155d10120d", "attribute_values" => "FirstName=#Jane#,Birthday=1980-12-31,EmailVerified=true,NumChildren=3"})

  * Post params:
    * Entity = Type of entity being modified (ex: Contact)
    * Guid = guid of entity being modified
    * AttributeValues = Comma separated attribute=value pairs.
    * StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)

### The AttributeValue parameter syntax

A comma delimited list of attribute value pairs like: 

    FirstName=#Joe#,Birthday=1980-12-31,EmailVerified=true,NumChildren=3

Strings must be wrapped with a delimiter. The default delimiter is ‘#’ but a user-specified delimiter can be utilized by including the optional StringDelimiter param.

OptionSets must be set to a numeric value valid for that optionset, or zero to clear current existing value. To determine values that are valid for an optionset, use the GetOptionSet api call.
Note that when updating an attribute of type EntityReferene, usually only the guid needs to be specified. In cases where the EntityReference can be of more than one type (ex: OwnerId can be SystemUser or Team) the value must be type:guid (SystemUser:fb50333e-6b9f-e111-8d5d- 00155d000140).

In instances where the string delimiter occurs in the string itself (ex: ‘Some#Text’), the delimiter must be Base64Encoded (ex: ‘SomeIw==Text’). Of course the option to change the delimiter using the StringDelimiter parameter exists as well.


## CreateEntity

Allows for creation of a new entity record.

    ramco.create_entity({"entity" => "Contact", "attribute_values" => "FirstName=#Jane#,Birthday=1980-12-31,EmailVerified=true,NumChildren=3"})

  * Post params:
    * Entity = Type of entity being modified (ex: Contact)
    * AttributeValues = Comma separated attribute=value pairs.
    * StringDelimiter (optional) = User-specified delimiter used to wrap string values (default is #)

### The AttributeValue parameter syntax

The AttributeValue parameter for CreateEntity follows the same format as that for UpdateEntity.

### PrimaryIdAttribute

Every entity type has a PrimaryIdAttribute which can be determined with a GetEntityMetadata call. If a specific guid is desired for the entity being created, it can be added to the AttributeValues parameter along with the other specified values. If the PrimaryIdAttribute is not specified, one will be automatically generated.

Example creating a Contact record (ContactId is PrimaryIdAttribute): 

    FirstName=#John#,LastName=#Doe#,ContactId= 84a4d17f-2e48-4a4b-bb28-26f7c14fc926, Birthday=1980-12-31

## ClearCache

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
